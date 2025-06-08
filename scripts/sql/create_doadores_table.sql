-- Criar tabela de doadores
CREATE TABLE IF NOT EXISTS doadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_doador ENUM('PF', 'PJ') NOT NULL,
    nome VARCHAR(255) NOT NULL,
    documento VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(255),
    telefone VARCHAR(15) NOT NULL,
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    cep VARCHAR(10),
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    data_atualizacao DATETIME ON UPDATE CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    INDEX idx_documento (documento),
    INDEX idx_tipo_doador (tipo_doador)
);

-- Adicionar coluna doador_id na tabela doacoes
ALTER TABLE doacoes ADD COLUMN doador_id INT;

-- Criar índice para melhor performance
CREATE INDEX idx_doador_id ON doacoes (doador_id);

-- Adicionar chave estrangeira (será feito após migração dos dados)
-- ALTER TABLE doacoes ADD CONSTRAINT fk_doador FOREIGN KEY (doador_id) REFERENCES doadores(id);