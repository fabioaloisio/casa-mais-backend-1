const db = require('../src/config/database');

async function setupCompleteDatabase() {
  let connection;
  
  try {
    // Primeiro conectar sem especificar o banco para criar o banco
    const mysql = require('mysql2/promise');
    const tempConnection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || 'jdEjk$%*(Ll)',
      port: process.env.DB_PORT || 3306
    });
    
    // Criar o banco se não existir
    await tempConnection.execute('CREATE DATABASE IF NOT EXISTS casamais_db');
    await tempConnection.end();
    
    connection = await db.getConnection();
    console.log('🔗 Conectado ao banco de dados');

    // 1. Criar todas as tabelas
    console.log('\n📋 Criando estrutura das tabelas...');
    
    // Tipos de despesas
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS tipos_despesas (
        id int NOT NULL AUTO_INCREMENT,
        nome varchar(100) NOT NULL,
        descricao varchar(500) DEFAULT NULL,
        ativo tinyint(1) NOT NULL DEFAULT 1,
        data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE KEY nome (nome),
        KEY ativo (ativo)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela tipos_despesas criada');

    // Doadores
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS doadores (
        id int NOT NULL AUTO_INCREMENT,
        tipo_doador enum('PF','PJ') NOT NULL,
        nome varchar(255) NOT NULL,
        documento varchar(20) NOT NULL,
        email varchar(255) DEFAULT NULL,
        telefone varchar(20) NOT NULL,
        endereco varchar(255) DEFAULT NULL,
        cidade varchar(100) DEFAULT NULL,
        estado varchar(2) DEFAULT NULL,
        cep varchar(10) DEFAULT NULL,
        data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE KEY documento (documento),
        KEY tipo_doador (tipo_doador),
        KEY cidade (cidade),
        KEY estado (estado)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela doadores criada');

    // Despesas (com FK)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS despesas (
        id int NOT NULL AUTO_INCREMENT,
        tipo_despesa_id int NOT NULL,
        descricao varchar(255) NOT NULL,
        categoria varchar(100) NOT NULL,
        valor decimal(10,2) NOT NULL,
        data_despesa date NOT NULL,
        forma_pagamento varchar(50) NOT NULL,
        fornecedor varchar(255) DEFAULT NULL,
        observacoes text DEFAULT NULL,
        status enum('pendente','paga','cancelada') NOT NULL DEFAULT 'pendente',
        data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        KEY idx_despesas_tipo_despesa_id (tipo_despesa_id),
        KEY categoria (categoria),
        KEY data_despesa (data_despesa),
        KEY forma_pagamento (forma_pagamento),
        KEY status (status),
        CONSTRAINT fk_despesas_tipo_despesa FOREIGN KEY (tipo_despesa_id) REFERENCES tipos_despesas (id) ON DELETE RESTRICT ON UPDATE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela despesas criada com FK');

    // Doações (com FK)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS doacoes (
        id int NOT NULL AUTO_INCREMENT,
        doador_id int NOT NULL,
        valor decimal(10,2) NOT NULL,
        data_doacao date NOT NULL,
        observacoes text DEFAULT NULL,
        data_cadastro datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
        data_atualizacao datetime DEFAULT NULL,
        PRIMARY KEY (id),
        KEY idx_doacoes_doador_id (doador_id),
        KEY data_doacao (data_doacao),
        CONSTRAINT fk_doacoes_doador FOREIGN KEY (doador_id) REFERENCES doadores (id) ON DELETE RESTRICT ON UPDATE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela doacoes criada com FK');

    // Unidades de medida (base para FK)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS unidades_medida (
        id int NOT NULL AUTO_INCREMENT,
        nome varchar(50) NOT NULL,
        sigla varchar(10) NOT NULL,
        createdAt timestamp DEFAULT CURRENT_TIMESTAMP,
        updatedAt timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (id),
        UNIQUE KEY nome (nome),
        UNIQUE KEY sigla (sigla)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela unidades_medida criada');

    // Medicamentos (com FK para unidades_medida)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS medicamentos (
        id int NOT NULL AUTO_INCREMENT,
        nome varchar(100) NOT NULL,
        forma_farmaceutica varchar(45) NOT NULL,
        descricao varchar(250) DEFAULT NULL,
        unidade_medida_id int NOT NULL,
        createdAt timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updatedAt timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
        PRIMARY KEY (id),
        KEY idx_medicamentos_unidade_medida_id (unidade_medida_id),
        KEY nome (nome),
        KEY forma_farmaceutica (forma_farmaceutica),
        CONSTRAINT fk_medicamentos_unidade_medida FOREIGN KEY (unidade_medida_id) REFERENCES unidades_medida (id) ON DELETE RESTRICT ON UPDATE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela medicamentos criada com FK');

    // Assistidas
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS assistidas (
        id int NOT NULL AUTO_INCREMENT,
        nome varchar(255) NOT NULL COMMENT 'Nome completo da assistida',
        cpf varchar(20) COMMENT 'CPF da assistida',
        rg varchar(20) COMMENT 'RG da assistida',
        idade int COMMENT 'Idade da assistida',
        data_nascimento date COMMENT 'Data de nascimento',
        nacionalidade varchar(100) COMMENT 'Nacionalidade',
        estado_civil varchar(100) COMMENT 'Estado civil',
        profissao varchar(100) COMMENT 'Profissão atual ou anterior',
        escolaridade varchar(100) COMMENT 'Nível de escolaridade',
        status varchar(50) COMMENT 'Status atual (ex: Ativa, Em Tratamento)',
        logradouro varchar(255) COMMENT 'Rua/Avenida',
        bairro varchar(255) COMMENT 'Bairro de residência',
        numero varchar(20) COMMENT 'Número da residência',
        cep varchar(20) COMMENT 'CEP',
        estado varchar(2) COMMENT 'UF (ex: SP, MG)',
        cidade varchar(100) COMMENT 'Cidade',
        telefone varchar(20) COMMENT 'Telefone principal',
        telefone_contato varchar(20) COMMENT 'Telefone de contato alternativo',
        data_atendimento date COMMENT 'Data do primeiro atendimento',
        hora time COMMENT 'Hora do primeiro atendimento',
        historia_patologica text COMMENT 'História clínica da assistida',
        tempo_sem_uso varchar(100) COMMENT 'Tempo desde o último uso de substâncias',
        motivacao_internacoes text COMMENT 'Motivo(s) das internações anteriores',
        fatos_marcantes text COMMENT 'Fatos marcantes na vida da assistida',
        infancia text COMMENT 'Relato sobre a infância',
        adolescencia text COMMENT 'Relato sobre a adolescência',
        createdAt timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação do registro',
        updatedAt timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização do registro',
        PRIMARY KEY (id),
        UNIQUE KEY cpf (cpf),
        KEY nome (nome),
        KEY status (status),
        KEY cidade (cidade),
        KEY estado (estado)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela assistidas criada');

    // Internacoes (com FK para assistidas)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS internacoes (
        id int NOT NULL AUTO_INCREMENT,
        assistida_id int NOT NULL COMMENT 'Referência à assistida (foreign key)',
        local varchar(255) COMMENT 'Local da internação',
        duracao varchar(100) COMMENT 'Duração da internação',
        data date COMMENT 'Data da internação',
        createdAt timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação',
        updatedAt timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização',
        PRIMARY KEY (id),
        KEY idx_internacoes_assistida_id (assistida_id),
        KEY data (data),
        CONSTRAINT fk_internacoes_assistida FOREIGN KEY (assistida_id) REFERENCES assistidas (id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela internacoes criada com FK');

    // Medicamentos utilizados (com FK para assistidas)
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS medicamentos_utilizados (
        id int NOT NULL AUTO_INCREMENT,
        assistida_id int NOT NULL COMMENT 'Referência à assistida (foreign key)',
        nome varchar(100) COMMENT 'Nome do medicamento',
        dosagem varchar(50) COMMENT 'Dosagem do medicamento',
        frequencia varchar(100) COMMENT 'Frequência de uso',
        createdAt timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação',
        updatedAt timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização',
        PRIMARY KEY (id),
        KEY idx_medicamentos_utilizados_assistida_id (assistida_id),
        KEY nome (nome),
        CONSTRAINT fk_medicamentos_utilizados_assistida FOREIGN KEY (assistida_id) REFERENCES assistidas (id) ON DELETE CASCADE
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
    `);
    console.log('✓ Tabela medicamentos_utilizados criada com FK');

    // 2. Verificar se tabelas estão vazias antes de popular
    const [tiposCount] = await connection.execute('SELECT COUNT(*) as total FROM tipos_despesas');
    const [doadoresCount] = await connection.execute('SELECT COUNT(*) as total FROM doadores');
    const [unidadesCount] = await connection.execute('SELECT COUNT(*) as total FROM unidades_medida');
    const [assistidasCount] = await connection.execute('SELECT COUNT(*) as total FROM assistidas');
    
    if (tiposCount[0].total === 0 && doadoresCount[0].total === 0 && unidadesCount[0].total === 0 && assistidasCount[0].total === 0) {
      console.log('\n🌱 Populando dados de exemplo...');
      
      // Popular tipos de despesas
      await connection.execute(`
        INSERT INTO tipos_despesas (nome, descricao, ativo) VALUES
        ('Alimentação', 'Gastos com alimentação, merenda e suprimentos alimentícios', 1),
        ('Medicamentos', 'Gastos com medicamentos e materiais médicos', 1),
        ('Limpeza e Higiene', 'Produtos de limpeza e higiene pessoal', 1),
        ('Manutenção', 'Reparos e manutenção da infraestrutura', 1),
        ('Utilidades', 'Água, luz, telefone e internet', 1),
        ('Transporte', 'Gastos com transporte e combustível', 1),
        ('Material de Escritório', 'Papelaria e materiais administrativos', 1),
        ('Recursos Humanos', 'Salários, benefícios e treinamentos', 1),
        ('Equipamentos', 'Compra e manutenção de equipamentos', 1),
        ('Outros', 'Despesas diversas não categorizadas', 1)
      `);
      console.log('✓ Tipos de despesas populados');

      // Popular doadores
      await connection.execute(`
        INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep) VALUES
        ('PF', 'Maria Silva Santos', '97200167606', 'maria.silva@email.com', '11987654321', 'Rua das Flores, 123', 'São Paulo', 'SP', '01234567'),
        ('PF', 'João Pedro Oliveira', '57813901037', 'joao.pedro@email.com', '11976543210', 'Av. Paulista, 456', 'São Paulo', 'SP', '01311000'),
        ('PF', 'Ana Beatriz Costa', '02951994150', 'ana.costa@email.com', '11965432109', 'Rua Augusta, 789', 'São Paulo', 'SP', '01305100'),
        ('PJ', 'Supermercado Bom Preço LTDA', '68569796000131', 'contato@bompreco.com.br', '1133334444', 'Av. do Comércio, 1000', 'São Paulo', 'SP', '03031000'),
        ('PJ', 'Farmácia Saúde & Vida ME', '20729550000153', 'contato@saudevida.com.br', '1144445555', 'Rua da Saúde, 200', 'São Paulo', 'SP', '04038001')
      `);
      console.log('✓ Doadores populados');

      // Popular despesas
      await connection.execute(`
        INSERT INTO despesas (tipo_despesa_id, descricao, categoria, valor, data_despesa, forma_pagamento, fornecedor, observacoes, status) VALUES
        (2, 'Compra de medicamentos básicos', 'Medicamentos', 450.75, '2025-01-05', 'pix', 'Farmácia Popular', 'Medicamentos para estoque básico', 'paga'),
        (5, 'Conta de energia elétrica', 'Utilidades', 235.50, '2025-01-10', 'boleto', 'CPFL Energia', 'Conta de janeiro/2025', 'paga'),
        (1, 'Compra de alimentos para cozinha', 'Alimentação', 890.30, '2025-01-12', 'cartao_debito', 'Supermercado Extra', 'Compras mensais', 'paga')
      `);
      console.log('✓ Despesas populadas');

      // Popular doações
      await connection.execute(`
        INSERT INTO doacoes (doador_id, valor, data_doacao, observacoes) VALUES
        (1, 150.00, '2025-01-05', 'Doação mensal'),
        (2, 200.00, '2025-01-04', NULL),
        (3, 100.00, '2025-01-03', 'Primeira doação'),
        (4, 1000.00, '2025-01-05', 'Doação corporativa mensal'),
        (5, 750.00, '2025-01-04', 'Parceria solidária')
      `);
      console.log('✓ Doações populadas');

      // Popular unidades de medida
      await connection.execute(`
        INSERT INTO unidades_medida (nome, sigla) VALUES
        ('Grama', 'g'),
        ('Miligrama', 'mg'),
        ('Litro', 'L'),
        ('Mililitro', 'mL'),
        ('Unidade', 'un'),
        ('Ampola', 'amp')
      `);
      console.log('✓ Unidades de medida populadas');

      // Popular medicamentos
      await connection.execute(`
        INSERT INTO medicamentos (nome, forma_farmaceutica, descricao, unidade_medida_id) VALUES
        ('Paracetamol 750mg', 'Comprimido', 'Analgésico e antitérmico.', (SELECT id FROM unidades_medida WHERE sigla = 'mg')),
        ('Amoxicilina 500mg', 'Cápsula', 'Antibiótico de amplo espectro.', (SELECT id FROM unidades_medida WHERE sigla = 'mg')),
        ('Dipirona 500mg', 'Comprimido', 'Eficaz contra dores e febre.', (SELECT id FROM unidades_medida WHERE sigla = 'mg')),
        ('Ibuprofeno 600mg', 'Comprimido', 'Anti-inflamatório não esteroide.', (SELECT id FROM unidades_medida WHERE sigla = 'mg')),
        ('Omeprazol 20mg', 'Cápsula', 'Redução da produção de ácido gástrico.', (SELECT id FROM unidades_medida WHERE sigla = 'mg'))
      `);
      console.log('✓ Medicamentos populados');

      // Popular assistidas
      await connection.execute(`
        INSERT INTO assistidas (
          nome, cpf, rg, idade, data_nascimento, nacionalidade, estado_civil, profissao, escolaridade, status,
          logradouro, bairro, numero, cep, estado, cidade, telefone, telefone_contato
        ) VALUES
        ('Maria das Dores', '12345678900', 'MG-12345678', 42, '1983-09-15', 'Brasileira', 'Solteira', 'Cozinheira', 'Fundamental Completo', 'Ativa',
         'Rua das Flores', 'Centro', '120', '30100-000', 'MG', 'Belo Horizonte', '31999998888', '31988887777'),
        ('Ana Paula Lima', '98765432199', 'SP-98765432', 36, '1988-02-20', 'Brasileira', 'Casada', 'Auxiliar de Limpeza', 'Médio Incompleto', 'Em Tratamento',
         'Avenida Central', 'Jardim das Palmeiras', '500', '04000-200', 'SP', 'São Paulo', '11912345678', '11934567890')
      `);
      console.log('✓ Assistidas populadas');
    } else {
      console.log('\n⏭️ Dados já existem, pulando população');
    }

    // 3. Verificar estruturas finais
    console.log('\n📊 Resumo das tabelas criadas:');
    
    const [finalTipos] = await connection.execute('SELECT COUNT(*) as total FROM tipos_despesas');
    const [finalDoadores] = await connection.execute('SELECT COUNT(*) as total FROM doadores');
    const [finalDespesas] = await connection.execute('SELECT COUNT(*) as total FROM despesas');
    const [finalDoacoes] = await connection.execute('SELECT COUNT(*) as total FROM doacoes');
    const [finalUnidades] = await connection.execute('SELECT COUNT(*) as total FROM unidades_medida');
    const [finalMedicamentos] = await connection.execute('SELECT COUNT(*) as total FROM medicamentos');
    const [finalAssistidas] = await connection.execute('SELECT COUNT(*) as total FROM assistidas');
    const [finalInternacoes] = await connection.execute('SELECT COUNT(*) as total FROM internacoes');
    const [finalMedUtilizados] = await connection.execute('SELECT COUNT(*) as total FROM medicamentos_utilizados');
    
    console.log(`📋 Tipos de despesas: ${finalTipos[0].total} registros`);
    console.log(`👥 Doadores: ${finalDoadores[0].total} registros`);
    console.log(`💸 Despesas: ${finalDespesas[0].total} registros`);
    console.log(`💰 Doações: ${finalDoacoes[0].total} registros`);
    console.log(`📏 Unidades de medida: ${finalUnidades[0].total} registros`);
    console.log(`💊 Medicamentos: ${finalMedicamentos[0].total} registros`);
    console.log(`👩 Assistidas: ${finalAssistidas[0].total} registros`);
    console.log(`🏥 Internações: ${finalInternacoes[0].total} registros`);
    console.log(`💉 Medicamentos utilizados: ${finalMedUtilizados[0].total} registros`);

    // 4. Verificar Foreign Keys
    console.log('\n🔗 Verificando Foreign Keys:');
    const [foreignKeys] = await connection.execute(`
      SELECT 
        TABLE_NAME,
        COLUMN_NAME,
        REFERENCED_TABLE_NAME,
        REFERENCED_COLUMN_NAME
      FROM information_schema.KEY_COLUMN_USAGE 
      WHERE TABLE_SCHEMA = 'casamais_db'
      AND REFERENCED_TABLE_NAME IS NOT NULL
    `);
    
    foreignKeys.forEach(fk => {
      console.log(`✓ ${fk.TABLE_NAME}.${fk.COLUMN_NAME} -> ${fk.REFERENCED_TABLE_NAME}.${fk.REFERENCED_COLUMN_NAME}`);
    });

    console.log('\n✅ Banco de dados configurado com sucesso!');
    console.log('🚀 Pronto para uso com todas as tabelas e Foreign Keys');

  } catch (error) {
    console.error('❌ Erro durante a configuração:', error.message);
    throw error;
  } finally {
    if (connection) {
      connection.release();
    }
  }
}

// Executar configuração
setupCompleteDatabase()
  .then(() => {
    console.log('\n🎉 Script finalizado com sucesso!');
    process.exit(0);
  })
  .catch((error) => {
    console.error('💥 Falha na configuração:', error);
    process.exit(1);
  });