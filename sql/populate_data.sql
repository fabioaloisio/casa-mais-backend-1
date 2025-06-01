-- Script para popular o banco de dados com dados de exemplo

-- Limpar dados existentes (opcional - remova se quiser manter dados existentes)
-- DELETE FROM medicamentos;
-- DELETE FROM doacoes;

-- Popular tabela de medicamentos
INSERT INTO medicamentos (nome, tipo, quantidade, validade) VALUES 
('Paracetamol 750mg', 'Comprimido', 10, '2025-06-01'),
('Amoxicilina 500mg', 'Cápsula', 8, '2025-09-01'),
('Dipirona 500mg', 'Comprimido', 20, '2026-01-01'),
('Ibuprofeno 600mg', 'Comprimido', 15, '2025-12-01'),
('Omeprazol 20mg', 'Cápsula', 12, '2026-05-01'),
('Loratadina 10mg', 'Comprimido', 9, '2025-10-01'),
('Metformina 850mg', 'Comprimido', 11, '2026-03-01'),
('Losartana 50mg', 'Comprimido', 14, '2025-11-01'),
('Salbutamol 100mcg', 'Spray', 6, '2025-08-01'),
('Ranitidina 150mg', 'Comprimido', 7, '2026-04-01'),
('Azitromicina 500mg', 'Comprimido', 5, '2025-07-15'),
('Prednisona 20mg', 'Comprimido', 18, '2026-02-01'),
('Dexametasona 4mg', 'Comprimido', 22, '2025-09-15'),
('Vitamina C 500mg', 'Comprimido', 30, '2026-12-01'),
('Complexo B', 'Comprimido', 25, '2026-06-01'),
('Cetirizina 10mg', 'Comprimido', 13, '2025-11-15'),
('Nimesulida 100mg', 'Comprimido', 16, '2025-10-30'),
('Dorflex', 'Comprimido', 24, '2026-01-15'),
('Buscopan 10mg', 'Comprimido', 19, '2025-12-31'),
('Lactulose 667mg/ml', 'Xarope', 4, '2025-08-30');

-- Popular tabela de doações
INSERT INTO doacoes (tipo_doador, nome_doador, documento, email, telefone, valor, data_doacao, observacoes) VALUES
-- Pessoa Física
('PF', 'Maria Silva Santos', '12345678901', 'maria.silva@email.com', '11987654321', 150.00, '2025-01-05', 'Doação mensal'),
('PF', 'João Pedro Oliveira', '23456789012', 'joao.pedro@email.com', '11976543210', 200.00, '2025-01-04', NULL),
('PF', 'Ana Beatriz Costa', '34567890123', 'ana.costa@email.com', '11965432109', 100.00, '2025-01-03', 'Primeira doação'),
('PF', 'Carlos Eduardo Lima', '45678901234', 'carlos.lima@email.com', '11954321098', 300.00, '2025-01-02', 'Doação especial'),
('PF', 'Juliana Ferreira', '56789012345', 'juliana.f@email.com', '11943210987', 50.00, '2025-01-01', NULL),
('PF', 'Roberto Alves Souza', '67890123456', 'roberto.souza@email.com', '11932109876', 500.00, '2024-12-31', 'Doação de fim de ano'),
('PF', 'Fernanda Rodrigues', '78901234567', 'fernanda.r@email.com', '11921098765', 120.00, '2024-12-30', 'Doação recorrente'),
('PF', 'Paulo Henrique Silva', '89012345678', 'paulo.silva@email.com', '11910987654', 180.00, '2024-12-29', NULL),
('PF', 'Mariana Gomes', '90123456789', 'mariana.gomes@email.com', '11909876543', 250.00, '2024-12-28', 'Em memória de...'),
('PF', 'Ricardo Martins', '01234567890', 'ricardo.m@email.com', '11898765432', 75.00, '2024-12-27', NULL),

-- Pessoa Jurídica
('PJ', 'Supermercado Bom Preço LTDA', '12345678000190', 'contato@bompreco.com.br', '1133334444', 1000.00, '2025-01-05', 'Doação corporativa mensal'),
('PJ', 'Farmácia Saúde & Vida ME', '23456789000101', 'contato@saudevida.com.br', '1144445555', 750.00, '2025-01-04', 'Parceria solidária'),
('PJ', 'Padaria Pão Quente EIRELI', '34567890000112', 'contato@paoquente.com.br', '1155556666', 300.00, '2025-01-03', NULL),
('PJ', 'Auto Peças Central LTDA', '45678901000123', 'vendas@autopecas.com.br', '1166667777', 500.00, '2025-01-02', 'Doação trimestral'),
('PJ', 'Restaurante Sabor Caseiro ME', '56789012000134', 'contato@saborcaseiro.com.br', '1177778888', 400.00, '2025-01-01', 'Apoio social'),
('PJ', 'Clínica Médica Vida Plena', '67890123000145', 'contato@vidaplena.med.br', '1188889999', 2000.00, '2024-12-31', 'Doação anual'),
('PJ', 'Escritório Advocacia Silva & Associados', '78901234000156', 'contato@silvaadv.com.br', '1199990000', 800.00, '2024-12-30', NULL),
('PJ', 'Construtora Bom Lar LTDA', '89012345000167', 'contato@bomlar.com.br', '1100001111', 1500.00, '2024-12-29', 'Responsabilidade social'),
('PJ', 'Transportadora Rápida Express', '90123456000178', 'contato@rapidaexpress.com.br', '1111112222', 600.00, '2024-12-28', NULL),
('PJ', 'Escola Infantil Pequeno Príncipe', '01234567000189', 'direcao@pequenoprincipe.edu.br', '1122223333', 350.00, '2024-12-27', 'Campanha solidária dos pais');

-- Verificar dados inseridos
SELECT 'Medicamentos inseridos:' as info, COUNT(*) as total FROM medicamentos;
SELECT 'Doações inseridas:' as info, COUNT(*) as total FROM doacoes;
SELECT 'Total arrecadado:' as info, CONCAT('R$ ', FORMAT(SUM(valor), 2, 'pt_BR')) as valor FROM doacoes;