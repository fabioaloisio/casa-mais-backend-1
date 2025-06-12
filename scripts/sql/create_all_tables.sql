-- Script unificado para criar todas as tabelas com estrutura correta
-- Data: 2025-01-06

-- Criar database se não existir
CREATE DATABASE
IF NOT EXISTS casamais_db;
USE casamais_db;

-- 1. Tabela tipos_despesas (base para FK)
CREATE TABLE
IF NOT EXISTS tipos_despesas
(
  id int NOT NULL AUTO_INCREMENT,
  nome varchar
(100) NOT NULL,
  descricao varchar
(500) DEFAULT NULL,
  ativo tinyint
(1) NOT NULL DEFAULT 1,
  data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY
(id),
  UNIQUE KEY nome
(nome),
  KEY ativo
(ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 2. Tabela doadores (base para FK)
CREATE TABLE
IF NOT EXISTS doadores
(
  id int NOT NULL AUTO_INCREMENT,
  tipo_doador enum
('PF','PJ') NOT NULL,
  nome varchar
(255) NOT NULL,
  documento varchar
(20) NOT NULL,
  email varchar
(255) DEFAULT NULL,
  telefone varchar
(20) NOT NULL,
  endereco varchar
(255) DEFAULT NULL,
  cidade varchar
(100) DEFAULT NULL,
  estado varchar
(2) DEFAULT NULL,
  cep varchar
(10) DEFAULT NULL,
  data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY
(id),
  UNIQUE KEY documento
(documento),
  KEY tipo_doador
(tipo_doador),
  KEY cidade
(cidade),
  KEY estado
(estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. Tabela despesas (com FK para tipos_despesas)
CREATE TABLE
IF NOT EXISTS despesas
(
  id int NOT NULL AUTO_INCREMENT,
  tipo_despesa_id int NOT NULL,
  descricao varchar
(255) NOT NULL,
  categoria varchar
(100) NOT NULL,
  valor decimal
(10,2) NOT NULL,
  data_despesa date NOT NULL,
  forma_pagamento varchar
(50) NOT NULL,
  fornecedor varchar
(255) DEFAULT NULL,
  observacoes text DEFAULT NULL,
  status enum
('pendente','paga','cancelada') NOT NULL DEFAULT 'pendente',
  data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY
(id),
  KEY idx_despesas_tipo_despesa_id
(tipo_despesa_id),
  KEY categoria
(categoria),
  KEY data_despesa
(data_despesa),
  KEY forma_pagamento
(forma_pagamento),
  KEY status
(status),
  CONSTRAINT fk_despesas_tipo_despesa FOREIGN KEY
(tipo_despesa_id) REFERENCES tipos_despesas
(id) ON
DELETE RESTRICT ON
UPDATE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 4. Tabela doacoes (com FK para doadores)
CREATE TABLE
IF NOT EXISTS doacoes
(
  id int NOT NULL AUTO_INCREMENT,
  doador_id int NOT NULL,
  valor decimal
(10,2) NOT NULL,
  data_doacao date NOT NULL,
  observacoes text DEFAULT NULL,
  data_cadastro datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao datetime DEFAULT NULL,
  PRIMARY KEY
(id),
  KEY idx_doacoes_doador_id
(doador_id),
  KEY data_doacao
(data_doacao),
  CONSTRAINT fk_doacoes_doador FOREIGN KEY
(doador_id) REFERENCES doadores
(id) ON
DELETE RESTRICT ON
UPDATE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE
IF NOT EXISTS unidades_medida
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR
(50) NOT NULL,
    sigla VARCHAR
(10) NOT NULL UNIQUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP
NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Unidades de medida de medicamentos cadastradas.';


CREATE TABLE
IF NOT EXISTS medicamentos
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR
(100) NOT NULL,
    forma_farmaceutica VARCHAR
(45) NOT NULL,
    descricao VARCHAR
(250) DEFAULT NULL,
    unidade_medida_id INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON
UPDATE CURRENT_TIMESTAMP
NOT NULL,
    CONSTRAINT fk_unidade_medida FOREIGN KEY
(unidade_medida_id) 
        REFERENCES unidades_medida
(id) 
        ON
DELETE RESTRICT 
        ON
UPDATE CASCADE
) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci 
COMMENT='Medicamentos cadastrados na instituição.';

-- 5. Verificar estruturas criadas
SELECT 'Tabelas criadas com sucesso!' as status;