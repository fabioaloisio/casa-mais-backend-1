// Aldruin Bonfim de Lima Souza - RA 10482416915

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
    const campos = [];
    const valores = [];

    if (medicamento.nome !== undefined) {
      campos.push('nome = ?');
      valores.push(medicamento.nome);
    }
    if (medicamento.tipo !== undefined) {
      campos.push('tipo = ?');
      valores.push(medicamento.tipo);
    }
    if (medicamento.quantidade !== undefined) {
      campos.push('quantidade = ?');
      valores.push(medicamento.quantidade);
    }
    if (medicamento.validade !== undefined) {
      campos.push('validade = ?');
      valores.push(medicamento.getDataParaMySQL());
    }

    if (campos.length === 0) return false;

    valores.push(id);

    const [result] = await db.execute(
      `UPDATE medicamentos SET ${campos.join(', ')} WHERE id = ?;`,
      valores
    );

    return result.affectedRows > 0;
  }

  async delete(id) {
    const [result] = await db.execute('DELETE FROM medicamentos WHERE id = ?;', [id]);
    return result.affectedRows > 0;
  }
}

module.exports = new MedicamentoRepository();
