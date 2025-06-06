const mysql = require('mysql2/promise');
require('dotenv').config();

// Função para gerar CPF válido
function gerarCPFValido() {
  // Gera 9 dígitos aleatórios
  const primeirosDígitos = [];
  for (let i = 0; i < 9; i++) {
    primeirosDígitos.push(Math.floor(Math.random() * 10));
  }

  // Calcula primeiro dígito verificador
  let soma = 0;
  for (let i = 0; i < 9; i++) {
    soma += primeirosDígitos[i] * (10 - i);
  }
  let resto = soma % 11;
  const primeiroDigitoVerificador = resto < 2 ? 0 : 11 - resto;

  // Calcula segundo dígito verificador
  soma = 0;
  for (let i = 0; i < 9; i++) {
    soma += primeirosDígitos[i] * (11 - i);
  }
  soma += primeiroDigitoVerificador * 2;
  resto = soma % 11;
  const segundoDigitoVerificador = resto < 2 ? 0 : 11 - resto;

  // Monta o CPF completo
  return primeirosDígitos.join('') + primeiroDigitoVerificador + segundoDigitoVerificador;
}

// Função para gerar CNPJ válido
function gerarCNPJValido() {
  // Gera 12 dígitos aleatórios (8 iniciais + 4 da filial)
  const primeirosDígitos = [];
  for (let i = 0; i < 8; i++) {
    primeirosDígitos.push(Math.floor(Math.random() * 10));
  }
  // Adiciona 0001 (filial padrão)
  primeirosDígitos.push(0, 0, 0, 1);

  // Pesos para cálculo dos dígitos verificadores
  const pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

  // Calcula primeiro dígito verificador
  let soma = 0;
  for (let i = 0; i < 12; i++) {
    soma += primeirosDígitos[i] * pesos1[i];
  }
  let resto = soma % 11;
  const primeiroDigitoVerificador = resto < 2 ? 0 : 11 - resto;

  // Calcula segundo dígito verificador
  soma = 0;
  for (let i = 0; i < 12; i++) {
    soma += primeirosDígitos[i] * pesos2[i];
  }
  soma += primeiroDigitoVerificador * pesos2[12];
  resto = soma % 11;
  const segundoDigitoVerificador = resto < 2 ? 0 : 11 - resto;

  // Monta o CNPJ completo
  return primeirosDígitos.join('') + primeiroDigitoVerificador + segundoDigitoVerificador;
}

// Função para gerar endereço fake
function gerarEnderecoFake() {
  const tiposRua = ['Rua', 'Avenida', 'Alameda', 'Travessa', 'Praça'];
  const nomes = [
    'das Flores', 'dos Pássaros', 'do Sol', 'da Paz', 'da Esperança',
    'São João', 'Santos Dumont', 'Paulista', 'Copacabana', 'Ipanema',
    'das Acácias', 'dos Eucaliptos', 'da Liberdade', 'do Comércio', 'Central',
    'Bela Vista', 'Alto da Boa Vista', 'Vila Rica', 'Jardim América', 'Campo Belo'
  ];
  
  const tipo = tiposRua[Math.floor(Math.random() * tiposRua.length)];
  const nome = nomes[Math.floor(Math.random() * nomes.length)];
  const numero = Math.floor(Math.random() * 9999) + 1;
  
  return `${tipo} ${nome}, ${numero}`;
}

// Função para gerar cidade brasileira fake
function gerarCidadeFake() {
  const cidades = [
    'São Paulo', 'Rio de Janeiro', 'Belo Horizonte', 'Salvador', 'Brasília',
    'Fortaleza', 'Curitiba', 'Recife', 'Porto Alegre', 'Goiânia',
    'Belém', 'Guarulhos', 'Campinas', 'São Luís', 'Maceió',
    'Teresina', 'Natal', 'Campo Grande', 'João Pessoa', 'São Bernardo do Campo',
    'Nova Iguaçu', 'Osasco', 'Santo André', 'São José dos Campos', 'Ribeirão Preto'
  ];
  
  return cidades[Math.floor(Math.random() * cidades.length)];
}

// Função para gerar estado brasileiro
function gerarEstadoFake() {
  const estados = [
    'SP', 'RJ', 'MG', 'BA', 'RS', 'PR', 'PE', 'CE', 'SC', 'GO',
    'PB', 'PA', 'ES', 'AL', 'MT', 'MS', 'DF', 'SE', 'AM', 'RO',
    'AC', 'MA', 'RN', 'TO', 'PI', 'AP', 'RR'
  ];
  
  return estados[Math.floor(Math.random() * estados.length)];
}

// Função para gerar CEP fake
function gerarCEPFake() {
  const cep = [];
  for (let i = 0; i < 8; i++) {
    cep.push(Math.floor(Math.random() * 10));
  }
  return cep.join('');
}

async function populateDoadores() {
  let connection;

  try {
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME || 'casamais_db'
    });

    console.log('✅ Conectado ao banco de dados');

    // Dados de doadores PF
    const doadoresPF = [
      { nome: 'Maria Silva Santos', email: 'maria.silva@email.com', telefone: '11987654321' },
      { nome: 'João Pedro Oliveira', email: 'joao.pedro@email.com', telefone: '11976543210' },
      { nome: 'Ana Beatriz Costa', email: 'ana.costa@email.com', telefone: '11965432109' },
      { nome: 'Carlos Eduardo Lima', email: 'carlos.lima@email.com', telefone: '11954321098' },
      { nome: 'Juliana Ferreira', email: 'juliana.f@email.com', telefone: '11943210987' },
      { nome: 'Roberto Alves Souza', email: 'roberto.souza@email.com', telefone: '11932109876' },
      { nome: 'Fernanda Rodrigues', email: 'fernanda.r@email.com', telefone: '11921098765' },
      { nome: 'Paulo Henrique Silva', email: 'paulo.silva@email.com', telefone: '11910987654' },
      { nome: 'Mariana Gomes', email: 'mariana.gomes@email.com', telefone: '11909876543' },
      { nome: 'Ricardo Martins', email: 'ricardo.m@email.com', telefone: '11898765432' }
    ];

    // Dados de doadores PJ
    const doadoresPJ = [
      { nome: 'Supermercado Bom Preço LTDA', email: 'contato@bompreco.com.br', telefone: '1133334444' },
      { nome: 'Farmácia Saúde & Vida ME', email: 'contato@saudevida.com.br', telefone: '1144445555' },
      { nome: 'Padaria Pão Quente EIRELI', email: 'contato@paoquente.com.br', telefone: '1155556666' },
      { nome: 'Auto Peças Central LTDA', email: 'vendas@autopecas.com.br', telefone: '1166667777' },
      { nome: 'Restaurante Sabor Caseiro ME', email: 'contato@saborcaseiro.com.br', telefone: '1177778888' },
      { nome: 'Clínica Médica Vida Plena', email: 'contato@vidaplena.med.br', telefone: '1188889999' },
      { nome: 'Escritório Advocacia Silva & Associados', email: 'contato@silvaadv.com.br', telefone: '1199990000' },
      { nome: 'Construtora Bom Lar LTDA', email: 'contato@bomlar.com.br', telefone: '1100001111' },
      { nome: 'Transportadora Rápida Express', email: 'contato@rapidaexpress.com.br', telefone: '1111112222' },
      { nome: 'Escola Infantil Pequeno Príncipe', email: 'direcao@pequenoprincipe.edu.br', telefone: '1122223333' }
    ];

    console.log('🔄 Limpando doadores existentes...');
    // Desabilitar verificação de FK temporariamente
    await connection.execute('SET FOREIGN_KEY_CHECKS = 0');
    await connection.execute('DELETE FROM doacoes');
    await connection.execute('DELETE FROM doadores');
    await connection.execute('ALTER TABLE doadores AUTO_INCREMENT = 1');
    await connection.execute('SET FOREIGN_KEY_CHECKS = 1');

    console.log('🔄 Inserindo doadores PF com CPFs válidos...');
    for (const doador of doadoresPF) {
      const cpf = gerarCPFValido();
      const endereco = gerarEnderecoFake();
      const cidade = gerarCidadeFake();
      const estado = gerarEstadoFake();
      const cep = gerarCEPFake();

      await connection.execute(
        `INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep, ativo) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        ['PF', doador.nome, cpf, doador.email, doador.telefone, endereco, cidade, estado, cep, true]
      );
    }

    console.log('🔄 Inserindo doadores PJ com CNPJs válidos...');
    for (const doador of doadoresPJ) {
      const cnpj = gerarCNPJValido();
      const endereco = gerarEnderecoFake();
      const cidade = gerarCidadeFake();
      const estado = gerarEstadoFake();
      const cep = gerarCEPFake();

      await connection.execute(
        `INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep, ativo) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        ['PJ', doador.nome, cnpj, doador.email, doador.telefone, endereco, cidade, estado, cep, true]
      );
    }

    console.log('🔄 Criando doações para os doadores...');
    const valores = [150, 200, 100, 300, 50, 500, 120, 180, 250, 75, 1000, 750, 300, 500, 400, 2000, 800, 1500, 600, 350];
    const observacoes = [
      'Doação mensal', null, 'Primeira doação', 'Doação especial', null,
      'Doação de fim de ano', 'Doação recorrente', null, 'Em memória de...', null,
      'Doação corporativa mensal', 'Parceria solidária', null, 'Doação trimestral', 'Apoio social',
      'Doação anual', null, 'Responsabilidade social', null, 'Campanha solidária dos pais'
    ];
    
    const datasDoacao = [
      '2025-01-05', '2025-01-04', '2025-01-03', '2025-01-02', '2025-01-01',
      '2024-12-31', '2024-12-30', '2024-12-29', '2024-12-28', '2024-12-27',
      '2025-01-05', '2025-01-04', '2025-01-03', '2025-01-02', '2025-01-01',
      '2024-12-31', '2024-12-30', '2024-12-29', '2024-12-28', '2024-12-27'
    ];

    for (let i = 0; i < 20; i++) {
      await connection.execute(
        `INSERT INTO doacoes (doador_id, valor, data_doacao, observacoes, data_cadastro) 
         VALUES (?, ?, ?, ?, NOW())`,
        [i + 1, valores[i], datasDoacao[i], observacoes[i]]
      );
    }

    // Verificar resultados
    const [doadores] = await connection.execute('SELECT COUNT(*) as total FROM doadores');
    const [doacoes] = await connection.execute('SELECT COUNT(*) as total FROM doacoes');
    const [totalArrecadado] = await connection.execute('SELECT COALESCE(SUM(valor), 0) as total FROM doacoes');

    console.log('\n📊 Dados inseridos com sucesso:');
    console.log(`   - Doadores: ${doadores[0].total}`);
    console.log(`   - Doações: ${doacoes[0].total}`);
    console.log(`   - Total arrecadado: R$ ${Number(totalArrecadado[0].total).toFixed(2)}`);
    
    console.log('\n🔍 Exemplos de CPFs gerados:');
    const [exemplosPF] = await connection.execute('SELECT nome, documento FROM doadores WHERE tipo_doador = "PF" LIMIT 3');
    exemplosPF.forEach(d => console.log(`   ${d.nome}: ${d.documento}`));
    
    console.log('\n🔍 Exemplos de CNPJs gerados:');
    const [exemplosPJ] = await connection.execute('SELECT nome, documento FROM doadores WHERE tipo_doador = "PJ" LIMIT 3');
    exemplosPJ.forEach(d => console.log(`   ${d.nome}: ${d.documento}`));

    console.log('\n✅ População de doadores concluída com sucesso!');

  } catch (error) {
    console.error('❌ Erro ao popular doadores:', error.message);
    process.exit(1);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

// Executar se chamado diretamente
if (require.main === module) {
  console.log('🚀 Iniciando população de doadores com dados válidos...\n');
  populateDoadores();
}

module.exports = { populateDoadores, gerarCPFValido, gerarCNPJValido };