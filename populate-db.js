const mysql = require('mysql2/promise');
const fs = require('fs').promises;
const path = require('path');
require('dotenv').config();

async function populateDatabase() {
  let connection;
  
  try {
    // Conectar ao banco de dados
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || 'admin',
      database: process.env.DB_NAME || 'casamais_db',
      port: process.env.DB_PORT || 3306,
      multipleStatements: true
    });

    console.log('✅ Conectado ao banco de dados');

    // Ler o arquivo SQL
    const sqlFilePath = path.join(__dirname, 'sql', 'populate_data.sql');
    const sqlContent = await fs.readFile(sqlFilePath, 'utf8');

    // Garantir que o banco e tabelas existem
    console.log('🔄 Verificando banco de dados e tabelas...');
    
    // Verificar se as tabelas existem antes de popular
    const [tables] = await connection.execute(
      "SELECT COUNT(*) as count FROM information_schema.tables WHERE table_schema = ? AND table_name IN ('medicamentos', 'doacoes')",
      [process.env.DB_NAME || 'casamais_db']
    );
    
    if (tables[0].count < 2) {
      console.log('❌ Tabelas não encontradas. Execute primeiro: npm run setup-db');
      process.exit(1);
    }
    
    console.log('✅ Tabelas verificadas');

    // Executar o script SQL
    console.log('🔄 Populando banco de dados...');
    await connection.query(sqlContent);

    // Verificar resultados
    const [medicamentos] = await connection.execute('SELECT COUNT(*) as total FROM medicamentos');
    const [doacoes] = await connection.execute('SELECT COUNT(*) as total FROM doacoes');
    const [totalArrecadado] = await connection.execute('SELECT COALESCE(SUM(valor), 0) as total FROM doacoes');

    console.log('\n📊 Dados inseridos com sucesso:');
    console.log(`   - Medicamentos: ${medicamentos[0].total}`);
    console.log(`   - Doações: ${doacoes[0].total}`);
    console.log(`   - Total arrecadado: R$ ${Number(totalArrecadado[0].total).toFixed(2)}`);

    console.log('\n🎉 População do banco de dados concluída!');

  } catch (error) {
    console.error('❌ Erro ao popular banco de dados:', error.message);
    process.exit(1);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

// Perguntar confirmação antes de popular
const readline = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('⚠️  ATENÇÃO: Este script irá inserir dados de exemplo no banco de dados.');
console.log('   Certifique-se de que o banco foi criado com: npm run setup-db\n');

readline.question('Deseja continuar? (s/N): ', (answer) => {
  if (answer.toLowerCase() === 's') {
    readline.close();
    populateDatabase();
  } else {
    console.log('Operação cancelada.');
    readline.close();
  }
});