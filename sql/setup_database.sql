-- Criar o banco de dados se não existir
CREATE DATABASE IF NOT EXISTS casamais_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Selecionar o banco
USE casamais_db;

-- Tabela de doações
CREATE TABLE IF NOT EXISTS doacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_doador ENUM('PF', 'PJ') NOT NULL COMMENT 'Tipo de doador: PF = Pessoa Física, PJ = Pessoa Jurídica',
    nome_doador VARCHAR(255) NOT NULL,
    documento VARCHAR(14) NOT NULL COMMENT 'CPF (11 dígitos) ou CNPJ (14 dígitos)',
    email VARCHAR(255),
    telefone VARCHAR(15) NOT NULL COMMENT 'Telefone sem formatação',
    valor DECIMAL(10, 2) NOT NULL COMMENT 'Valor da doação em reais',
    data_doacao DATE NOT NULL COMMENT 'Data em que a doação foi realizada',
    observacoes TEXT,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_documento (documento),
    INDEX idx_data_doacao (data_doacao),
    INDEX idx_tipo_doador (tipo_doador)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabela para armazenar doações monetárias';

-- Tabela de medicamentos em estoque
CREATE TABLE IF NOT EXISTS medicamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    quantidade INT NOT NULL,
    validade DATE NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Medicamentos disponíveis no estoque da instituição';

-- Tabela principal: assistidas
CREATE TABLE IF NOT EXISTS assistidas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) COMMENT 'Nome completo da assistida',
    cpf VARCHAR(20) UNIQUE COMMENT 'CPF da assistida',
    rg VARCHAR(20) COMMENT 'RG da assistida',
    idade INT COMMENT 'Idade da assistida',
    data_nascimento DATE COMMENT 'Data de nascimento',
    nacionalidade VARCHAR(100) COMMENT 'Nacionalidade',
    estado_civil VARCHAR(100) COMMENT 'Estado civil',
    profissao VARCHAR(100) COMMENT 'Profissão atual ou anterior',
    escolaridade VARCHAR(100) COMMENT 'Nível de escolaridade',
    status VARCHAR(50) COMMENT 'Status atual (ex: Ativa, Em Tratamento)',

    logradouro VARCHAR(255) COMMENT 'Rua/Avenida',
    bairro VARCHAR(255) COMMENT 'Bairro de residência',
    numero VARCHAR(20) COMMENT 'Número da residência',
    cep VARCHAR(20) COMMENT 'CEP',
    estado VARCHAR(2) COMMENT 'UF (ex: SP, MG)',
    cidade VARCHAR(100) COMMENT 'Cidade',
    telefone VARCHAR(20) COMMENT 'Telefone principal',
    telefone_contato VARCHAR(20) COMMENT 'Telefone de contato alternativo',

    data_atendimento DATE COMMENT 'Data do primeiro atendimento',
    hora TIME COMMENT 'Hora do primeiro atendimento',
    historia_patologica TEXT COMMENT 'História clínica da assistida',
    tempo_sem_uso VARCHAR(100) COMMENT 'Tempo desde o último uso de substâncias',

    motivacao_internacoes TEXT NULL COMMENT 'Motivo(s) das internações anteriores',
    fatos_marcantes TEXT COMMENT 'Fatos marcantes na vida da assistida',
    infancia TEXT COMMENT 'Relato sobre a infância',
    adolescencia TEXT COMMENT 'Relato sobre a adolescência',

    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação do registro',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização do registro'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cadastro de mulheres assistidas pela instituição';

-- Tabela de substâncias utilizadas por assistidas
CREATE TABLE IF NOT EXISTS drogas_utilizadas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    assistida_id INT NOT NULL COMMENT 'Referência à assistida (foreign key)',
    tipo VARCHAR(100) COMMENT 'Tipo de substância (ex: álcool, crack)',
    idade_inicio INT COMMENT 'Idade em que começou o uso',
    tempo_uso VARCHAR(100) COMMENT 'Tempo estimado de uso',
    intensidade VARCHAR(100) COMMENT 'Intensidade do uso (ex: Alta, Muito Alta)',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização',
    FOREIGN KEY (assistida_id) REFERENCES assistidas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Histórico de substâncias utilizadas pelas assistidas';

-- Tabela de internações
CREATE TABLE IF NOT EXISTS internacoes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    assistida_id INT NOT NULL COMMENT 'Referência à assistida (foreign key)',
    local VARCHAR(255) COMMENT 'Local onde ocorreu a internação',
    duracao VARCHAR(100) COMMENT 'Duração da internação (ex: 30 dias)',
    data DATE COMMENT 'Data da internação',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização',
    FOREIGN KEY (assistida_id) REFERENCES assistidas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Internações anteriores das assistidas';

-- NOVA: Tabela de medicamentos utilizados pelas assistidas
CREATE TABLE IF NOT EXISTS medicamentos_utilizados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    assistida_id INT NOT NULL COMMENT 'Referência à assistida (foreign key)',
    nome VARCHAR(255) COMMENT 'Nome do medicamento',
    dosagem VARCHAR(50) COMMENT 'Dosagem (ex: 500mg)',
    frequencia VARCHAR(100) COMMENT 'Frequência de uso (ex: 2x ao dia)',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'Data de criação',
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'Última atualização',
    FOREIGN KEY (assistida_id) REFERENCES assistidas(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Medicamentos usados por assistidas';

-- Mensagem final de confirmação
SELECT 'Banco de dados e todas as tabelas criadas com sucesso!' AS mensagem;
