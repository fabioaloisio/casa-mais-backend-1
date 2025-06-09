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
      password: process.env.DB_PASSWORD || '3511',
      database: process.env.DB_NAME || 'casamais_db',
      port: process.env.DB_PORT || 3306,
      multipleStatements: true
    });

    console.log('✅ Conectado ao banco de dados');

    // Verificar se as tabelas existem
    console.log('🔄 Verificando banco de dados e tabelas...');
    const [tables] = await connection.execute(
      `SELECT COUNT(*) as count FROM information_schema.tables 
       WHERE table_schema = ? 
         AND table_name IN ('assistidas', 'drogas_utilizadas', 'internacoes', 'medicamentos_utilizados', 'doacoes', 'medicamentos')`,
      [process.env.DB_NAME || 'casamais_db']
    );

    if (tables[0].count < 6) {
      console.log('❌ Tabelas não encontradas. Execute primeiro: npm run setup-db');
      process.exit(1);
    }
    console.log('✅ Tabelas verificadas');

    // Executar o script populate_data.sql
    console.log('🔄 Populando banco de dados...');
    const populateSQLPath = path.join(__dirname, 'sql', 'populate_data.sql');
    const populateSQL = await fs.readFile(populateSQLPath, 'utf8');
    await connection.query(populateSQL);

    // Executar a migração de doadores
    console.log('🔄 Executando migração dos doadores...');
    const migrateSQLPath = path.join(__dirname, 'sql', 'migrate_doadores_data.sql');
    const migrateSQL = await fs.readFile(migrateSQLPath, 'utf8');
    await connection.query(migrateSQL);

    // Verificar resultados
    const [medicamentos] = await connection.execute('SELECT COUNT(*) as total FROM medicamentos');
    const [doacoes] = await connection.execute('SELECT COUNT(*) as total FROM doacoes');
    const [totalArrecadado] = await connection.execute('SELECT COALESCE(SUM(valor), 0) as total FROM doacoes');

    const [assistidas] = await connection.execute('SELECT COUNT(*) as total FROM assistidas');
    const [drogas] = await connection.execute('SELECT COUNT(*) as total FROM drogas_utilizadas');
    const [internacoes] = await connection.execute('SELECT COUNT(*) as total FROM internacoes');
    const [medicamentosUtilizados] = await connection.execute('SELECT COUNT(*) as total FROM medicamentos_utilizados');

    console.log('\n📊 Dados inseridos com sucesso:');
    console.log(`   - Medicamentos: ${medicamentos[0].total}`);
    console.log(`   - Doações: ${doacoes[0].total}`);
    console.log(`   - Total arrecadado: R$ ${Number(totalArrecadado[0].total).toFixed(2)}`);
    console.log(`   - Assistidas: ${assistidas[0].total}`);
    // console.log(`   - Drogas utilizadas: ${drogas[0].total}`);
    // console.log(`   - Internações: ${internacoes[0].total}`);
    // console.log(`   - Medicamentos utilizados: ${medicamentosUtilizados[0].total}`);

    console.log('\n✅ Migração concluída e banco de dados populado com sucesso!');
  } catch (error) {
    console.error('❌ Erro ao executar script:', error.message);
    process.exit(1);
  } finally {
    if (connection) await connection.end();
  }
}

// Confirmação do usuário antes de executar
const readline = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('⚠️  ATENÇÃO: Este script irá inserir dados de exemplo e migrar os doadores.');
console.log('   Certifique-se de que o banco foi criado com: npm run setup-db\n');

readline.question('Deseja continuar? (s/N): ', (answer) => {
  if (answer.toLowerCase() === 's') {
    readline.close();
    populateDatabase();
  } else {
    console.log('❌ Operação cancelada.');
    readline.close();
  }
});
