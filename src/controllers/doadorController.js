const doadorRepository = require('../repository/doadorRepository');
const Doador = require('../models/doador');

class DoadorController {
  async create(req, res) {
    try {
      const { tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep } = req.body;

      if (!tipo_doador || !nome || !documento || !telefone) {
        return res.status(400).json({ 
          error: 'Campos obrigatórios: tipo_doador, nome, documento, telefone' 
        });
      }

      const doadorExistente = await doadorRepository.findByDocumento(documento);
      if (doadorExistente) {
        return res.status(409).json({ 
          error: 'Já existe um doador cadastrado com este documento',
          doador: doadorExistente
        });
      }

      const novoDoador = new Doador(
        null,
        tipo_doador,
        nome,
        documento,
        email || null,
        telefone,
        endereco || null,
        cidade || null,
        estado || null,
        cep || null,
        null,
        null,
        true
      );

      const id = await doadorRepository.create(novoDoador);
      const doadorCriado = await doadorRepository.findById(id);

      res.status(201).json({
        message: 'Doador cadastrado com sucesso',
        doador: doadorCriado
      });
    } catch (error) {
      console.error('Erro ao criar doador:', error);
      res.status(500).json({ error: 'Erro ao cadastrar doador' });
    }
  }

  async findAll(req, res) {
    try {
      const { tipo_doador, ativo, search } = req.query;
      
      const filters = {};
      if (tipo_doador) filters.tipo_doador = tipo_doador;
      if (ativo !== undefined) filters.ativo = ativo === 'true';
      if (search) filters.search = search;

      const doadores = await doadorRepository.findAll(filters);
      res.json(doadores);
    } catch (error) {
      console.error('Erro ao buscar doadores:', error);
      res.status(500).json({ error: 'Erro ao buscar doadores' });
    }
  }

  async findById(req, res) {
    try {
      const { id } = req.params;
      const doador = await doadorRepository.findById(id);

      if (!doador) {
        return res.status(404).json({ error: 'Doador não encontrado' });
      }

      const totalDoacoes = await doadorRepository.getTotalDoacoesByDoador(id);
      
      res.json({
        ...doador,
        estatisticas: totalDoacoes
      });
    } catch (error) {
      console.error('Erro ao buscar doador:', error);
      res.status(500).json({ error: 'Erro ao buscar doador' });
    }
  }

  async update(req, res) {
    try {
      const { id } = req.params;
      const dadosAtualizacao = req.body;

      const doadorExistente = await doadorRepository.findById(id);
      if (!doadorExistente) {
        return res.status(404).json({ error: 'Doador não encontrado' });
      }

      if (dadosAtualizacao.documento && dadosAtualizacao.documento !== doadorExistente.documento) {
        const doadorComMesmoDocumento = await doadorRepository.findByDocumento(dadosAtualizacao.documento);
        if (doadorComMesmoDocumento) {
          return res.status(409).json({ 
            error: 'Já existe outro doador cadastrado com este documento' 
          });
        }
      }

      const doadorAtualizado = new Doador();
      Object.assign(doadorAtualizado, dadosAtualizacao);

      const linhasAfetadas = await doadorRepository.update(id, doadorAtualizado);
      
      if (linhasAfetadas === 0) {
        return res.status(400).json({ error: 'Nenhuma alteração realizada' });
      }

      const doador = await doadorRepository.findById(id);
      res.json({
        message: 'Doador atualizado com sucesso',
        doador
      });
    } catch (error) {
      console.error('Erro ao atualizar doador:', error);
      res.status(500).json({ error: 'Erro ao atualizar doador' });
    }
  }

  async delete(req, res) {
    try {
      const { id } = req.params;

      const doador = await doadorRepository.findById(id);
      if (!doador) {
        return res.status(404).json({ error: 'Doador não encontrado' });
      }

      const doacoes = await doadorRepository.findDoacoesByDoadorId(id);
      if (doacoes.length > 0) {
        return res.status(400).json({ 
          error: 'Não é possível excluir um doador que possui doações registradas',
          total_doacoes: doacoes.length
        });
      }

      const linhasAfetadas = await doadorRepository.delete(id);
      
      if (linhasAfetadas === 0) {
        return res.status(400).json({ error: 'Erro ao desativar doador' });
      }

      res.json({ message: 'Doador desativado com sucesso' });
    } catch (error) {
      console.error('Erro ao desativar doador:', error);
      res.status(500).json({ error: 'Erro ao desativar doador' });
    }
  }

  async findDoacoes(req, res) {
    try {
      const { id } = req.params;
      
      const doador = await doadorRepository.findById(id);
      if (!doador) {
        return res.status(404).json({ error: 'Doador não encontrado' });
      }

      const doacoes = await doadorRepository.findDoacoesByDoadorId(id);
      const estatisticas = await doadorRepository.getTotalDoacoesByDoador(id);

      res.json({
        doador,
        doacoes,
        estatisticas
      });
    } catch (error) {
      console.error('Erro ao buscar doações do doador:', error);
      res.status(500).json({ error: 'Erro ao buscar doações' });
    }
  }
}

module.exports = new DoadorController();