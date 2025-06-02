const doacaoRepository = require('../repository/doacaoRepository');
const Doacao = require('../models/doacao');

class DoacaoController {
  // Criar nova doação
  async criar(req, res) {
    try {
      const doacao = new Doacao(req.body);
      
      // Validar dados
      const erros = doacao.validaDoacao();
      if (erros.length > 0) {
        return res.status(400).json({
          success: false,
          message: 'Dados inválidos',
          errors: erros
        });
      }
      
      // Criar doação
      const id = await doacaoRepository.criar(req.body);
      
      // Buscar doação criada
      const doacaoCriada = await doacaoRepository.buscarPorId(id);
      
      return res.status(201).json({
        success: true,
        message: 'Doação cadastrada com sucesso',
        data: doacaoCriada.toJSON()
      });
    } catch (error) {
      console.error('Erro ao criar doação:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao cadastrar doação',
        error: error.message
      });
    }
  }

  // Listar todas as doações
  async listar(req, res) {
    try {
      const filtros = {
        tipoDoador: req.query.tipoDoador,
        nomeDoador: req.query.nomeDoador,
        documento: req.query.documento,
        dataInicio: req.query.dataInicio,
        dataFim: req.query.dataFim
      };
      
      const doacoes = await doacaoRepository.buscarTodos(filtros);
      
      return res.json({
        success: true,
        data: doacoes.map(d => d.toJSON()),
        total: doacoes.length
      });
    } catch (error) {
      console.error('Erro ao listar doações:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao listar doações',
        error: error.message
      });
    }
  }

  // Buscar doação por ID
  async buscarPorId(req, res) {
    try {
      const { id } = req.params;
      
      const doacao = await doacaoRepository.buscarPorId(id);
      
      if (!doacao) {
        return res.status(404).json({
          success: false,
          message: 'Doação não encontrada'
        });
      }
      
      return res.json({
        success: true,
        data: doacao.toJSON()
      });
    } catch (error) {
      console.error('Erro ao buscar doação:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao buscar doação',
        error: error.message
      });
    }
  }

  // Buscar doações por doador
  async buscarPorDoador(req, res) {
    try {
      const { documento } = req.params;
      
      if (!documento) {
        return res.status(400).json({
          success: false,
          message: 'Documento do doador é obrigatório'
        });
      }
      
      const doacoes = await doacaoRepository.buscarPorDoador(documento);
      
      return res.json({
        success: true,
        data: doacoes.map(d => d.toJSON()),
        total: doacoes.length
      });
    } catch (error) {
      console.error('Erro ao buscar doações por doador:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao buscar doações do doador',
        error: error.message
      });
    }
  }

  // Atualizar doação
  async atualizar(req, res) {
    try {
      const { id } = req.params;
      
      // Verificar se doação existe
      const doacaoExistente = await doacaoRepository.buscarPorId(id);
      if (!doacaoExistente) {
        return res.status(404).json({
          success: false,
          message: 'Doação não encontrada'
        });
      }
      
      // Validar dados
      const doacao = new Doacao({ ...req.body, id });
      const erros = doacao.validaDoacao();
      if (erros.length > 0) {
        return res.status(400).json({
          success: false,
          message: 'Dados inválidos',
          errors: erros
        });
      }
      
      // Atualizar doação
      const atualizado = await doacaoRepository.atualizar(id, req.body);
      
      if (!atualizado) {
        return res.status(500).json({
          success: false,
          message: 'Erro ao atualizar doação'
        });
      }
      
      // Buscar doação atualizada
      const doacaoAtualizada = await doacaoRepository.buscarPorId(id);
      
      return res.json({
        success: true,
        message: 'Doação atualizada com sucesso',
        data: doacaoAtualizada.toJSON()
      });
    } catch (error) {
      console.error('Erro ao atualizar doação:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao atualizar doação',
        error: error.message
      });
    }
  }

  // Excluir doação
  async excluir(req, res) {
    try {
      const { id } = req.params;
      
      // Verificar se doação existe
      const existe = await doacaoRepository.existe(id);
      if (!existe) {
        return res.status(404).json({
          success: false,
          message: 'Doação não encontrada'
        });
      }
      
      // Excluir doação
      const excluido = await doacaoRepository.excluir(id);
      
      if (!excluido) {
        return res.status(500).json({
          success: false,
          message: 'Erro ao excluir doação'
        });
      }
      
      return res.json({
        success: true,
        message: 'Doação excluída com sucesso'
      });
    } catch (error) {
      console.error('Erro ao excluir doação:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao excluir doação',
        error: error.message
      });
    }
  }

  // Obter estatísticas
  async estatisticas(req, res) {
    try {
      const filtros = {
        dataInicio: req.query.dataInicio,
        dataFim: req.query.dataFim
      };
      
      const estatisticas = await doacaoRepository.obterEstatisticas(filtros);
      
      return res.json({
        success: true,
        data: estatisticas
      });
    } catch (error) {
      console.error('Erro ao obter estatísticas:', error);
      return res.status(500).json({
        success: false,
        message: 'Erro ao obter estatísticas',
        error: error.message
      });
    }
  }
}

module.exports = new DoacaoController();