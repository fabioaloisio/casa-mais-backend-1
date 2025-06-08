const mysql = require('mysql2/promise');
const fs = require('fs').promises;
const path = require('path');
require('dotenv').config();

async function setupDatabase() {
  let connection;

  try {
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || '3511',
      port: process.env.DB_PORT || 3306,
      multipleStatements: true
    });

    console.log('✅ Conectado ao MySQL');

    const setupPath = path.join(__dirname, 'sql', 'setup_database.sql');
    const doadoresPath = path.join(__dirname, 'sql', 'create_doadores_table.sql');

    const setupContent = await fs.readFile(setupPath, 'utf8');
    const doadoresContent = await fs.readFile(doadoresPath, 'utf8');

    await connection.query(setupContent);
    await connection.query(doadoresContent);

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
