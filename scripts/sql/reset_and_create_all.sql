-- Script completo para reset e criação do banco Casa Mais
-- Remove tudo e recria com estrutura correta
-- Data: 2025-01-06

-- Usar o banco de dados
USE casamais_db;

-- 1. RESET - Remover tabelas existentes (ordem importa por causa das FKs)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS doacoes;
DROP TABLE IF EXISTS despesas;
DROP TABLE IF EXISTS doadores;
DROP TABLE IF EXISTS tipos_despesas;
SET FOREIGN_KEY_CHECKS = 1;

-- 2. CRIAR ESTRUTURA COMPLETA

-- Tabela tipos_despesas (base para FK)
CREATE TABLE tipos_despesas (
  id int NOT NULL AUTO_INCREMENT,
  nome varchar(100) NOT NULL,
  descricao varchar(500) DEFAULT NULL,
  ativo tinyint(1) NOT NULL DEFAULT 1,
  data_cadastro timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY nome (nome),
  KEY ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela doadores (base para FK)
CREATE TABLE doadores (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela despesas (FK na posição 2)
CREATE TABLE despesas (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela doacoes (FK na posição 2)
CREATE TABLE doacoes (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 3. POPULAR DADOS ESSENCIAIS

-- Tipos de despesas
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
('Outros', 'Despesas diversas não categorizadas', 1);

-- Doadores
INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep) VALUES
('PF', 'Maria Silva Santos', '97200167606', 'maria.silva@email.com', '11987654321', 'Rua das Flores, 123', 'São Paulo', 'SP', '01234567'),
('PF', 'João Pedro Oliveira', '57813901037', 'joao.pedro@email.com', '11976543210', 'Av. Paulista, 456', 'São Paulo', 'SP', '01311000'),
('PF', 'Ana Beatriz Costa', '02951994150', 'ana.costa@email.com', '11965432109', 'Rua Augusta, 789', 'São Paulo', 'SP', '01305100'),
('PJ', 'Supermercado Bom Preço LTDA', '68569796000131', 'contato@bompreco.com.br', '1133334444', 'Av. do Comércio, 1000', 'São Paulo', 'SP', '03031000'),
('PJ', 'Farmácia Saúde & Vida ME', '20729550000153', 'contato@saudevida.com.br', '1144445555', 'Rua da Saúde, 200', 'São Paulo', 'SP', '04038001');

-- Despesas de exemplo
INSERT INTO despesas (tipo_despesa_id, descricao, categoria, valor, data_despesa, forma_pagamento, fornecedor, observacoes, status) VALUES
(2, 'Compra de medicamentos básicos', 'Medicamentos', 450.75, '2025-01-05', 'pix', 'Farmácia Popular', 'Medicamentos para estoque básico', 'paga'),
(5, 'Conta de energia elétrica', 'Utilidades', 235.50, '2025-01-10', 'boleto', 'CPFL Energia', 'Conta de janeiro/2025', 'paga'),
(1, 'Compra de alimentos para cozinha', 'Alimentação', 890.30, '2025-01-12', 'cartao_debito', 'Supermercado Extra', 'Compras mensais', 'paga');

-- Doações de exemplo
INSERT INTO doacoes (doador_id, valor, data_doacao, observacoes) VALUES
(1, 150.00, '2025-01-05', 'Doação mensal'),
(2, 200.00, '2025-01-04', NULL),
(3, 100.00, '2025-01-03', 'Primeira doação'),
(4, 1000.00, '2025-01-05', 'Doação corporativa mensal'),
(5, 750.00, '2025-01-04', 'Parceria solidária');

-- 4. VERIFICAR RESULTADO
SELECT 'Estrutura criada com sucesso!' as status;
SELECT 'Tipos de despesas:' as tabela, COUNT(*) as total FROM tipos_despesas;
SELECT 'Doadores:' as tabela, COUNT(*) as total FROM doadores;
SELECT 'Despesas:' as tabela, COUNT(*) as total FROM despesas;
SELECT 'Doações:' as tabela, COUNT(*) as total FROM doacoes;