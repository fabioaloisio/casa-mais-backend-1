const db = require('../config/database');
const Medicamento = require('../models/medicamento');

class MedicamentoRepository {
  async findAll() {
    const [rows] = await db.execute('SELECT * FROM medicamentos;');
    return rows.map(row => new Medicamento(row));
  }

  async findById(id) {
    const [rows] = await db.execute('SELECT * FROM medicamentos WHERE id = ?;', [id]);
    return rows.length ? new Medicamento(rows[0]) : null;
  }

  async findByTipo(tipo) {
    const [rows] = await db.execute('SELECT * FROM medicamentos WHERE tipo LIKE ?;', [`%${tipo}%`]);
    return rows.map(row => new Medicamento(row));
  }

  async findByNome(nome) {
    const [rows] = await db.execute('SELECT * FROM medicamentos WHERE nome LIKE ?;', [`%${nome}%`]);
    return rows.map(row => new Medicamento(row));
  }

  async create(medicamento) {
    const [result] = await db.execute(
      `INSERT INTO medicamentos (nome, tipo, quantidade, validade) VALUES (?, ?, ?, ?);`,
      [medicamento.nome, medicamento.tipo, medicamento.quantidade, medicamento.getDataParaMySQL()]
    );
    medicamento.id = result.insertId;
    return medicamento;
  }

  async update(id, medicamento) {
    const [result] = await db.execute(
      `UPDATE medicamentos SET nome = ?, tipo = ?, quantidade = ?, validade = ? WHERE id = ?;`,
      [medicamento.nome, medicamento.tipo, medicamento.quantidade, medicamento.getDataParaMySQL(), id]
    );
    return result.affectedRows > 0;
  }

  async delete(id) {
    const [result] = await db.execute('DELETE FROM medicamentos WHERE id = ?;', [id]);
    return result.affectedRows > 0;
  }
}

module.exports = new MedicamentoRepository();