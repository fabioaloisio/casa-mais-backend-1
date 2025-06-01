class Medicamentos {
  constructor(data) {
    this.id = data.id || null;
    this.nome = data.nome;
    this.tipo = data.tipo;
    this.quantidade = data.quantidade;
    this.validade = data.validade;
  }

  validaMedicamento() {
    const errors = [];

    if (!this.nome || this.nome.trim().length === 0)
      errors.push('Nome do Medicamento é obrigatório.');

    if (!this.tipo || this.tipo.trim().length === 0)
      errors.push('Tipo do Medicamento é obrigatório.');

    if (this.quantidade === undefined || this.quantidade === null)
      errors.push('Quantidade é obrigatória.');
    else if (typeof this.quantidade !== 'number' || this.quantidade <= 0)
      errors.push('Quantidade deve ser um número maior que zero.');

    if (!this.validade || this.validade.trim().length === 0) {
      errors.push('Data de validade é obrigatória.');
    } else if (!this.validaData(this.validade)) {
      errors.push('Data de validade inválida. Formato esperado: MM/YYYY e mês entre 01 e 12.');
    }

    return errors;
  }

  validaData(data) {
    const regex = /^(0[1-9]|1[0-2])\/\d{4}$/;
    if (!regex.test(data)) return false;

    const [mes, ano] = data.split('/').map(Number);

    const dataValidade = new Date(ano, mes - 1, 1);
    const hoje = new Date();
    hoje.setHours(0, 0, 0, 0);

    return dataValidade >= hoje;
  }

  getDataParaMySQL() {
    const [mes, ano] = this.validade.split('/');
    return `${ano}-${mes}-01`;
  }

  toJSON(){
    return{
      id: this.id,
      nome: this.nome,
      tipo: this.tipo,
      quantidade: this.quantidade,
      validade: this.validade
    };
  }

}

module.exports = Medicamentos;