class Doacao {
  constructor(doacao) {
    this.id = doacao.id;
    this.tipoDoador = doacao.tipoDoador;
    this.nomeDoador = doacao.nomeDoador;
    this.documento = doacao.documento;
    this.email = doacao.email || null;
    this.telefone = doacao.telefone;
    this.valor = parseFloat(doacao.valor) || 0;
    this.dataDoacao = doacao.dataDoacao;
    this.observacoes = doacao.observacoes || null;
    this.dataCadastro = doacao.dataCadastro || new Date();
    this.dataAtualizacao = doacao.dataAtualizacao || null;
  }

  validaDoacao() {
    const erros = [];

    // Validação do tipo de doador
    if (!this.tipoDoador || !['PF', 'PJ'].includes(this.tipoDoador)) {
      erros.push('Tipo de doador inválido. Deve ser PF ou PJ');
    }

    // Validação do nome do doador
    if (!this.nomeDoador || this.nomeDoador.trim().length === 0) {
      erros.push('Nome do doador é obrigatório');
    }

    // Validação do documento (CPF/CNPJ)
    if (!this.documento || this.documento.trim().length === 0) {
      erros.push('Documento é obrigatório');
    } else {
      // Remove caracteres não numéricos
      const docLimpo = this.documento.replace(/\D/g, '');
      
      if (this.tipoDoador === 'PF' && docLimpo.length !== 11) {
        erros.push('CPF deve ter 11 dígitos');
      } else if (this.tipoDoador === 'PJ' && docLimpo.length !== 14) {
        erros.push('CNPJ deve ter 14 dígitos');
      }
    }

    // Validação do email (opcional, mas se fornecido deve ser válido)
    if (this.email && !this.validaEmail(this.email)) {
      erros.push('Email inválido');
    }

    // Validação do telefone
    if (!this.telefone || this.telefone.trim().length === 0) {
      erros.push('Telefone é obrigatório');
    }

    // Validação do valor
    if (!this.valor || this.valor <= 0) {
      erros.push('Valor da doação deve ser maior que zero');
    }

    // Validação da data de doação
    if (!this.dataDoacao) {
      erros.push('Data da doação é obrigatória');
    } else {
      const dataDoacao = new Date(this.dataDoacao);
      const hoje = new Date();
      
      if (dataDoacao > hoje) {
        erros.push('Data da doação não pode ser futura');
      }
    }

    return erros;
  }

  validaEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
  }

  // Formata documento removendo caracteres especiais
  getDocumentoLimpo() {
    return this.documento ? this.documento.replace(/\D/g, '') : '';
  }

  // Formata data para MySQL
  getDataDoacaoParaMySQL() {
    if (!this.dataDoacao) return null;
    
    const data = new Date(this.dataDoacao);
    return data.toISOString().split('T')[0];
  }

  // Formata datas de timestamp para MySQL
  getDataCadastroParaMySQL() {
    const data = new Date(this.dataCadastro);
    return data.toISOString().slice(0, 19).replace('T', ' ');
  }

  getDataAtualizacaoParaMySQL() {
    if (!this.dataAtualizacao) return null;
    
    const data = new Date(this.dataAtualizacao);
    return data.toISOString().slice(0, 19).replace('T', ' ');
  }

  // Prepara objeto para inserção/atualização no banco
  paraMySQL() {
    return {
      tipo_doador: this.tipoDoador,
      nome_doador: this.nomeDoador,
      documento: this.getDocumentoLimpo(),
      email: this.email,
      telefone: this.telefone.replace(/\D/g, ''), // Remove formatação
      valor: this.valor,
      data_doacao: this.getDataDoacaoParaMySQL(),
      observacoes: this.observacoes,
      data_cadastro: this.getDataCadastroParaMySQL(),
      data_atualizacao: this.getDataAtualizacaoParaMySQL()
    };
  }

  // Converte para JSON para resposta da API
  toJSON() {
    return {
      id: this.id,
      tipoDoador: this.tipoDoador,
      nomeDoador: this.nomeDoador,
      documento: this.documento,
      email: this.email,
      telefone: this.telefone,
      valor: this.valor,
      dataDoacao: this.dataDoacao,
      observacoes: this.observacoes,
      dataCadastro: this.dataCadastro,
      dataAtualizacao: this.dataAtualizacao
    };
  }

  // Método estático para criar doação a partir do resultado do banco
  static fromDatabase(row) {
    return new Doacao({
      id: row.id,
      tipoDoador: row.tipo_doador,
      nomeDoador: row.nome_doador,
      documento: row.documento,
      email: row.email,
      telefone: row.telefone,
      valor: row.valor,
      dataDoacao: row.data_doacao,
      observacoes: row.observacoes,
      dataCadastro: row.data_cadastro,
      dataAtualizacao: row.data_atualizacao
    });
  }
}

module.exports = Doacao;