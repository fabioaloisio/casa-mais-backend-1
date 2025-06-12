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

-- 5. Popular unidades_medida
INSERT INTO unidades_medida (nome, sigla) VALUES
('Grama', 'g'),
('Miligrama', 'mg'),
('Litro', 'L'),
('Mililitro', 'mL'),
('Unidade', 'un'),
('Ampola', 'amp');

-- 6. Popular medicamentos (com unidade_medida_id)
INSERT INTO medicamentos (nome, tipo, quantidade, unidade_medida_id) VALUES
('Paracetamol 750mg', 'Comprimido', 100, 5),
('Amoxicilina 500mg', 'Cápsula', 80, 5),
('Dipirona 500mg', 'Comprimido', 200, 5),
('Ibuprofeno 600mg', 'Comprimido', 150, 5),
('Omeprazol 20mg', 'Cápsula', 120, 5),
('Loratadina 10mg', 'Comprimido', 90, 5),
('Metformina 850mg', 'Comprimido', 110, 5),
('Losartana 50mg', 'Comprimido', 140, 5),
('Salbutamol 100mcg', 'Spray', 25, 6),
('Ranitidina 150mg', 'Comprimido', 70, 5),
('Azitromicina 500mg', 'Comprimido', 50, 5),
('Prednisona 20mg', 'Comprimido', 180, 5),
('Dexametasona 4mg', 'Comprimido', 220, 5),
('Vitamina C 500mg', 'Comprimido', 300, 5),
('Complexo B', 'Comprimido', 250, 5),
('Cetirizina 10mg', 'Comprimido', 130, 5),
('Nimesulida 100mg', 'Comprimido', 160, 5),
('Dorflex', 'Comprimido', 240, 5),
('Buscopan 10mg', 'Comprimido', 190, 5),
('Lactulose 667mg/ml', 'Xarope', 40, 4);

-- 7. Popular assistidas
INSERT INTO assistidas (
  nome, cpf, rg, idade, data_nascimento, nacionalidade, estado_civil, profissao, escolaridade, status,
  logradouro, bairro, numero, cep, estado, cidade, telefone, telefone_contato
) VALUES
('Maria das Dores', '12345678900', 'MG-12345678', 42, '1983-09-15', 'Brasileira', 'Solteira', 'Cozinheira', 'Fundamental Completo', 'Ativa',
 'Rua das Flores', 'Centro', '120', '30100-000', 'MG', 'Belo Horizonte', '31999998888', '31988887777'),
('Ana Paula Lima', '98765432199', 'SP-98765432', 36, '1988-02-20', 'Brasileira', 'Casada', 'Auxiliar de Limpeza', 'Médio Incompleto', 'Em Tratamento',
 'Avenida Central', 'Jardim das Palmeiras', '500', '04000-200', 'SP', 'São Paulo', '11912345678', '11934567890'),
('Jéssica Andrade', '11223344556', 'RJ-33445566', 29, '1995-03-10', 'Brasileira', 'Solteira', 'Manicure', 'Médio Completo', 'Ativa',
 'Rua das Acácias', 'Lapa', '88', '20220-330', 'RJ', 'Rio de Janeiro', '21999887766', '21988776655'),
('Carla Menezes', '22334455667', 'BA-44556677', 40, '1984-07-12', 'Brasileira', 'Divorciada', 'Doméstica', 'Fundamental Completo', 'Inativa',
 'Rua do Sossego', 'São Caetano', '22', '40200-000', 'BA', 'Salvador', '71987654321', '71996543210'),
('Renata Oliveira', '33445566778', 'RS-55667788', 33, '1991-01-25', 'Brasileira', 'Casada', 'Atendente', 'Médio Completo', 'Em Tratamento',
 'Avenida Brasil', 'Centro', '305', '90010-000', 'RS', 'Porto Alegre', '51991234567', '51993456789'),
('Tatiane Soares', '44556677889', 'PE-66778899', 27, '1997-11-04', 'Brasileira', 'Solteira', 'Vendedora', 'Médio Incompleto', 'Ativa',
 'Rua da Aurora', 'Boa Vista', '112', '50050-100', 'PE', 'Recife', '81999887766', '81988776655'),
('Eliane Costa', '55667788990', 'CE-77889900', 50, '1974-08-08', 'Brasileira', 'Viúva', 'Artesã', 'Fundamental Incompleto', 'Ativa',
 'Travessa das Palmeiras', 'Mucuripe', '55', '60165-000', 'CE', 'Fortaleza', '85991234567', '85993456789');

-- 8. Verificar dados inseridos
SELECT 'Dados inseridos com sucesso!' as status;
SELECT 'Tipos de despesas:', COUNT(*) as total FROM tipos_despesas;
SELECT 'Doadores:', COUNT(*) as total FROM doadores;
SELECT 'Despesas:', COUNT(*) as total FROM despesas;
SELECT 'Doações:', COUNT(*) as total FROM doacoes;
SELECT 'Unidades de medida:', COUNT(*) as total FROM unidades_medida;
SELECT 'Medicamentos:', COUNT(*) as total FROM medicamentos;
SELECT 'Assistidas:', COUNT(*) as total FROM assistidas;