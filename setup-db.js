const mysql = require('mysql2/promise');
const fs = require('fs').promises;
const path = require('path');
require('dotenv').config();

async function setupDatabase() {
  let connection;
  
  try {
    // Conectar sem especificar o banco de dados
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || 'admin',
      port: process.env.DB_PORT || 3306,
      multipleStatements: true
    });

    console.log('✅ Conectado ao MySQL');

    // Ler e executar o arquivo SQL de setup
    const sqlFilePath = path.join(__dirname, 'sql', 'setup_database.sql');
    const sqlContent = await fs.readFile(sqlFilePath, 'utf8');
    
    // Executar o script SQL
    await connection.query(sqlContent);
    
    console.log(`✅ Banco de dados '${process.env.DB_NAME || 'casamais_db'}' e tabelas criados com sucesso`);
    console.log('\n🎉 Configuração do banco de dados concluída!');
    console.log('Você pode agora executar: npm run populate-db (opcional) ou npm start');

  } catch (error) {
    console.error('❌ Erro ao configurar banco de dados:', error.message);
    process.exit(1);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

setupDatabase();