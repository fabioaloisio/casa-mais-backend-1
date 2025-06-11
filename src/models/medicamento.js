// Aldruin Bonfim de Lima Souza - RA 10482416915
class Medicamento {
  constructor(data) {
    this.id = data.id || null;
    this.nome = data.nome;
    this.tipo = data.tipo;
    this.quantidade = data.quantidade;
    this.unidade_medida_id = data.unidade_medida_id;
  }

  validate(isUpdate = false) {
    const errors = [];

    if (!isUpdate || this.nome !== undefined) {
      if (!this.nome || this.nome.trim().length === 0) {
        errors.push(isUpdate ? 'Nome do Medicamento não pode ser vazio.' : 'Nome do Medicamento é obrigatório.');
      }
    }

    if (!isUpdate || this.tipo !== undefined) {
      if (!this.tipo || this.tipo.trim().length === 0) {
        errors.push(isUpdate ? 'Tipo do Medicamento não pode ser vazio.' : 'Tipo do Medicamento é obrigatório.');
      }
    }

    if (!isUpdate || this.quantidade !== undefined) {
      const quantidadeNumerica = Number(this.quantidade);

      if (isNaN(quantidadeNumerica)) {
        errors.push('Quantidade deve ser um número válido.');
      } else if (quantidadeNumerica <= 0) {
        errors.push('Quantidade deve ser maior que zero.');
      }
    }


    if (!isUpdate || this.unidade_medida_id !== undefined) {
      if (!this.unidade_medida_id || typeof this.unidade_medida_id !== 'number') {
        errors.push('Unidade de Medida é obrigatória e deve ser um ID válido.');
      }
    }

    return errors;
  }

  toJSON() {
    return {
      id: this.id,
      nome: this.nome,
      tipo: this.tipo,
      quantidade: this.quantidade,
      unidade_medida_id: this.unidade_medida_id
    };
  }
}

module.exports = Medicamento;