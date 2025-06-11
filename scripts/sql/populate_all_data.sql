-- Script para popular todas as tabelas com dados de exemplo
-- Data: 2025-01-06

USE casamais_db;

-- 1. Popular tipos_despesas
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

-- 2. Popular doadores
INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, endereco, cidade, estado, cep) VALUES
('PF', 'Maria Silva Santos', '97200167606', 'maria.silva@email.com', '11987654321', 'Rua das Flores, 123', 'São Paulo', 'SP', '01234567'),
('PF', 'João Pedro Oliveira', '57813901037', 'joao.pedro@email.com', '11976543210', 'Av. Paulista, 456', 'São Paulo', 'SP', '01311000'),
('PF', 'Ana Beatriz Costa', '02951994150', 'ana.costa@email.com', '11965432109', 'Rua Augusta, 789', 'São Paulo', 'SP', '01305100'),
('PF', 'Carlos Eduardo Lima', '65773830655', 'carlos.lima@email.com', '11954321098', 'Rua Oscar Freire, 321', 'São Paulo', 'SP', '01426001'),
('PF', 'Juliana Ferreira', '41682563677', 'juliana.f@email.com', '11943210987', 'Av. Faria Lima, 654', 'São Paulo', 'SP', '01452000'),
('PF', 'Roberto Alves Souza', '47303095020', 'roberto.souza@email.com', '11932109876', 'Rua Haddock Lobo, 987', 'São Paulo', 'SP', '01414001'),
('PF', 'Fernanda Rodrigues', '58525383880', 'fernanda.r@email.com', '11921098765', 'Av. Rebouças, 147', 'São Paulo', 'SP', '05401300'),
('PF', 'Paulo Henrique Silva', '57352730869', 'paulo.silva@email.com', '11910987654', 'Rua Cardeal Arcoverde, 258', 'São Paulo', 'SP', '05407002'),
('PF', 'Mariana Gomes', '01650993560', 'mariana.gomes@email.com', '11909876543', 'Av. Consolação, 369', 'São Paulo', 'SP', '01301100'),
('PF', 'Ricardo Martins', '28937353989', 'ricardo.m@email.com', '11898765432', 'Rua da Consolação, 741', 'São Paulo', 'SP', '01302907'),
('PJ', 'Supermercado Bom Preço LTDA', '68569796000131', 'contato@bompreco.com.br', '1133334444', 'Av. do Comércio, 1000', 'São Paulo', 'SP', '03031000'),
('PJ', 'Farmácia Saúde & Vida ME', '20729550000153', 'contato@saudevida.com.br', '1144445555', 'Rua da Saúde, 200', 'São Paulo', 'SP', '04038001'),
('PJ', 'Padaria Pão Quente EIRELI', '28097821000107', 'contato@paoquente.com.br', '1155556666', 'Av. São João, 300', 'São Paulo', 'SP', '01035000'),
('PJ', 'Auto Peças Central LTDA', '64040600000166', 'vendas@autopecas.com.br', '1166667777', 'Rua do Gasômetro, 400', 'São Paulo', 'SP', '04047020'),
('PJ', 'Restaurante Sabor Caseiro ME', '67444698000105', 'contato@saborcaseiro.com.br', '1177778888', 'Av. Lins de Vasconcelos, 500', 'São Paulo', 'SP', '01538001');

-- 3. Popular despesas (usando tipo_despesa_id)
INSERT INTO despesas (tipo_despesa_id, descricao, categoria, valor, data_despesa, forma_pagamento, fornecedor, observacoes, status) VALUES
(2, 'Compra de medicamentos básicos', 'Medicamentos', 450.75, '2025-01-05', 'pix', 'Farmácia Popular', 'Medicamentos para estoque básico', 'paga'),
(5, 'Conta de energia elétrica', 'Utilidades', 235.50, '2025-01-10', 'boleto', 'CPFL Energia', 'Conta de janeiro/2025', 'paga'),
(1, 'Compra de alimentos para cozinha', 'Alimentação', 890.30, '2025-01-12', 'cartao_debito', 'Supermercado Extra', 'Compras mensais', 'paga'),
(4, 'Manutenção do ar condicionado', 'Manutenção', 180.00, '2025-01-15', 'dinheiro', 'Refrigeração Silva', 'Limpeza e manutenção preventiva', 'paga'),
(3, 'Material de limpeza', 'Limpeza e Higiene', 125.90, '2025-01-18', 'pix', 'Distribuidora Limpeza Total', 'Produtos para higienização', 'paga'),
(6, 'Combustível para veículo institucional', 'Transporte', 150.00, '2025-01-20', 'cartao_credito', 'Posto Ipiranga', 'Abastecimento van', 'paga'),
(7, 'Papelaria e material de escritório', 'Material de Escritório', 89.75, '2025-01-22', 'pix', 'Papelaria Central', 'Canetas, papel, grampos', 'paga'),
(4, 'Serviços de jardinagem', 'Manutenção', 200.00, '2025-01-25', 'transferencia', 'João Jardineiro', 'Manutenção do jardim', 'pendente'),
(2, 'Medicamentos especiais', 'Medicamentos', 680.40, '2025-01-28', 'boleto', 'Farmácia Hospitalar', 'Medicamentos controlados', 'pendente'),
(5, 'Internet banda larga', 'Utilidades', 99.90, '2025-01-30', 'cartao_credito', 'Vivo Fibra', 'Mensalidade internet', 'pendente');

-- 4. Popular doacoes (usando doador_id)
INSERT INTO doacoes (doador_id, valor, data_doacao, observacoes) VALUES
(1, 150.00, '2025-01-05', 'Doação mensal'),
(2, 200.00, '2025-01-04', NULL),
(3, 100.00, '2025-01-03', 'Primeira doação'),
(4, 300.00, '2025-01-02', 'Doação especial'),
(5, 50.00, '2025-01-01', NULL),
(6, 500.00, '2024-12-31', 'Doação de fim de ano'),
(7, 120.00, '2024-12-30', 'Doação recorrente'),
(8, 180.00, '2024-12-29', NULL),
(9, 250.00, '2024-12-28', 'Em memória de...'),
(10, 75.00, '2024-12-27', NULL),
(11, 1000.00, '2025-01-05', 'Doação corporativa mensal'),
(12, 750.00, '2025-01-04', 'Parceria solidária'),
(13, 300.00, '2025-01-03', NULL),
(14, 500.00, '2025-01-02', 'Doação trimestral'),
(15, 400.00, '2025-01-01', 'Apoio social');

-- 5. Verificar dados inseridos
SELECT 'Dados inseridos com sucesso!' as status;
SELECT 'Tipos de despesas:', COUNT(*) as total FROM tipos_despesas;
SELECT 'Doadores:', COUNT(*) as total FROM doadores;
SELECT 'Despesas:', COUNT(*) as total FROM despesas;
SELECT 'Doações:', COUNT(*) as total FROM doacoes;