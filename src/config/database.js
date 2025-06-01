const mysql = require('mysql2/promise');
const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: 'admin',
  database: 'casamais_db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
};

const pool = mysql.createPool(dbConfig);

//test connection

const testConnection = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('Conectado com sucesso ao banco de dados');
    connection.release();
  } catch (error) {
    console.error('Erro ao conectar ao banco de dados Mysql:', error.message);
  }
}

testConnection();

module.exports = pool;