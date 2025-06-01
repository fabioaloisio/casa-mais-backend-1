const db = require('../config/database');
const Medicamento = require('../models/medicamento');

class MedicamentoRepository {
  async findAll() {
    try {
      const [rows] = await db.execute('SELECT id, nome, tipo, quantidade, validade FROM medicamentos;');
      return rows.map(rows => new Medicamento(rows))
    } catch (error) {
      throw new Error(`Erro ao buscar medicamentos: ${error.message}`);
    }
  }
}

module.exports = new MedicamentoRepository();