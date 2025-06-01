const MedicamentoRepository = require('../repository/medicamentoRepository');
const Medicamento = require('../models/medicamento');


class MedicamentoController {

  async getAll(req, res) {
    try {
      const { tipo, nome } = req.query;
      let medicamentos;


      if (tipo) {
        medicamentos = await this.medicamentoRepository.findByTipo(tipo);
      } else if (nome) {
        medicamentos = await this.medicamentoRepository.findByNome(tipo);
      } else {
        medicamentos = await this.medicamentoRepository.findAll();
      }

      res.json({
        success: true,
        data: medicamentos.map(med => med.toJSON()),
        total: medicamentos.length
      })

    } catch (error) {
      res.status(500).json({ success: false, message: error.message })
    }
  }
}

module.exports = new MedicamentoController();