-- Criar o banco de dados se não existir
CREATE DATABASE IF NOT EXISTS casamais_db 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Criar tabela de doações
CREATE TABLE IF NOT EXISTS doacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_doador ENUM('PF', 'PJ') NOT NULL COMMENT 'Tipo de doador: PF = Pessoa Física, PJ = Pessoa Jurídica',
    nome_doador VARCHAR(255) NOT NULL,
    documento VARCHAR(14) NOT NULL COMMENT 'CPF (11 dígitos) ou CNPJ (14 dígitos) sem formatação',
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

-- Criar tabela de medicamentos se não existir
CREATE TABLE IF NOT EXISTS medicamentos(
    id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(45) NOT NULL,
    quantidade INT NOT NULL,
    validade DATE NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
    CONSTRAINT pk_Medicamentos PRIMARY KEY (id)
);

-- Mensagem de confirmação
SELECT 'Banco de dados e tabelas criados com sucesso!' AS mensagem;