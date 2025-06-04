// Aldruin Bonfim de Lima Souza - RA 10482416915
class Medicamento {
  constructor(data) {
    this.id = data.id || null;
    this.nome = data.nome;
    this.tipo = data.tipo;
    this.quantidade = data.quantidade;
    this.validade = data.validade;
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
      if (this.quantidade === undefined || this.quantidade === null) {
        errors.push('Quantidade é obrigatória.');
      } else if (typeof this.quantidade !== 'number' || this.quantidade <= 0) {
        errors.push('Quantidade deve ser um número maior que zero.');
      }
    }

    if (!isUpdate || this.validade !== undefined) {
      if (!this.validade || this.validade.trim().length === 0) {
        errors.push(isUpdate ? 'Data de validade não pode ser vazia.' : 'Data de validade é obrigatória.');
      } else if (!this.validaData(this.validade)) {
        errors.push('Data de validade inválida. Formato esperado: DD/MM/YYYY.');
      }
    }
    return errors;
  }

  validaData(data) {
    const regex = /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/;
    if (!regex.test(data)) return false;

    const [dia, mes, ano] = data.split('/').map(Number);

    const dataValidade = new Date(ano, mes - 1, dia);
    const hoje = new Date();
    hoje.setHours(0, 0, 0, 0);

    return dataValidade >= hoje;
  }

  getDataParaMySQL() {
    const [dia, mes, ano] = this.validade.split('/');
    return `${ano}-${mes.padStart(2, '0')}-${dia.padStart(2, '0')}`;
  }

  toJSON() {
    return {
      id: this.id,
      nome: this.nome,
      tipo: this.tipo,
      quantidade: this.quantidade,
      validade: this.validade
    };
  }

}

module.exports = Medicamento;
