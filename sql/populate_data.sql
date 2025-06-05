-- Script para popular o banco de dados com dados de exemplo

-- Limpar dados existentes (opcional - remova se quiser manter dados existentes)
-- DELETE FROM medicamentos;
-- DELETE FROM doacoes;

-- Popular tabela de medicamentos
INSERT INTO medicamentos
  (nome, tipo, quantidade, validade)
VALUES
  ('Paracetamol 750mg', 'Comprimido', 10, '2026-06-01'),
  ('Amoxicilina 500mg', 'Cápsula', 8, '2027-09-01'),
  ('Dipirona 500mg', 'Comprimido', 20, '2026-01-01'),
  ('Ibuprofeno 600mg', 'Comprimido', 15, '2028-12-01'),
  ('Omeprazol 20mg', 'Cápsula', 12, '2026-05-01'),
  ('Loratadina 10mg', 'Comprimido', 9, '2029-10-01'),
  ('Metformina 850mg', 'Comprimido', 11, '2026-03-01'),
  ('Losartana 50mg', 'Comprimido', 14, '2030-11-01'),
  ('Salbutamol 100mcg', 'Spray', 6, '2031-08-01'),
  ('Ranitidina 150mg', 'Comprimido', 7, '2026-04-01'),
  ('Azitromicina 500mg', 'Comprimido', 5, '2028-07-15'),
  ('Prednisona 20mg', 'Comprimido', 18, '2026-02-01'),
  ('Dexametasona 4mg', 'Comprimido', 22, '2027-09-15'),
  ('Vitamina C 500mg', 'Comprimido', 30, '2026-12-01'),
  ('Complexo B', 'Comprimido', 25, '2026-06-01'),
  ('Cetirizina 10mg', 'Comprimido', 13, '2029-11-15'),
  ('Nimesulida 100mg', 'Comprimido', 16, '2026-10-30'),
  ('Dorflex', 'Comprimido', 24, '2026-01-15'),
  ('Buscopan 10mg', 'Comprimido', 19, '2028-12-31'),
  ('Lactulose 667mg/ml', 'Xarope', 4, '2028-08-30');

-- Popular tabela de doações
INSERT INTO doacoes
  (tipo_doador, nome_doador, documento, email, telefone, valor, data_doacao, observacoes)
VALUES
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


INSERT INTO assistidas
  (
  nome, cpf, rg, idade, data_nascimento, nacionalidade, estado_civil, profissao, escolaridade, status,
  logradouro, bairro, numero, cep, estado, cidade, telefone, telefone_contato,
  data_atendimento, hora, historia_patologica, tempo_sem_uso,
  motivacao_internacoes, fatos_marcantes, infancia, adolescencia
  )
VALUES
  -- 1. Maria das Dores
  ('Maria das Dores', '12345678900', 'MG-12345678', 42, '1983-09-15', 'Brasileira', 'Solteira', 'Cozinheira', 'Fundamental Completo', 'Ativa',
    'Rua das Flores', 'Centro', '120', '30100-000', 'MG', 'Belo Horizonte', '31999998888', '31988887777',
    '2025-05-01', '14:30:00', 'Histórico de alcoolismo desde os 20 anos.', '6 meses',
    'Tentativas de reabilitação por alcoolismo', 'Perda da guarda dos filhos', 'Cresceu em situação de vulnerabilidade', 'Envolvimento com más companhias'),

  -- 2. Ana Paula Lima
  ('Ana Paula Lima', '98765432199', 'SP-98765432', 36, '1988-02-20', 'Brasileira', 'Casada', 'Auxiliar de Limpeza', 'Médio Incompleto', 'Em Tratamento',
    'Avenida Central', 'Jardim das Palmeiras', '500', '04000-200', 'SP', 'São Paulo', '11912345678', '11934567890',
    '2025-05-10', '09:00:00', 'Dependência de crack nos últimos 10 anos.', '3 semanas',
    NULL, 'Perda do emprego por uso', 'Família instável e violenta', 'Morou na rua por um tempo'),

  -- 3. Jéssica Andrade
  ('Jéssica Andrade', '11223344556', 'RJ-33445566', 29, '1995-03-10', 'Brasileira', 'Solteira', 'Manicure', 'Médio Completo', 'Ativa',
    'Rua das Acácias', 'Lapa', '88', '20220-330', 'RJ', 'Rio de Janeiro', '21999887766', '21988776655',
    '2025-04-15', '10:00:00', 'Uso ocasional de maconha.', '15 dias',
    NULL, 'Separação conturbada', 'Abandono paterno', 'Boa aluna, mas rebelde'),

  -- 4. Carla Menezes
  ('Carla Menezes', '22334455667', 'BA-44556677', 40, '1984-07-12', 'Brasileira', 'Divorciada', 'Doméstica', 'Fundamental Completo', 'Inativa',
    'Rua do Sossego', 'São Caetano', '22', '40200-000', 'BA', 'Salvador', '71987654321', '71996543210',
    '2025-03-22', '11:45:00', 'Uso intenso de álcool e calmantes.', '2 meses',
    'Crises de abstinência severas', 'Perda da mãe aos 10 anos', 'Criada pela avó', 'Casamento abusivo'),

  -- 5. Renata Oliveira
  ('Renata Oliveira', '33445566778', 'RS-55667788', 33, '1991-01-25', 'Brasileira', 'Casada', 'Atendente', 'Médio Completo', 'Em Tratamento',
    'Avenida Brasil', 'Centro', '305', '90010-000', 'RS', 'Porto Alegre', '51991234567', '51993456789',
    '2025-06-01', '08:30:00', 'Histórico de uso de crack e cocaína.', '1 semana',
    'Recaídas constantes', 'Filhos retirados pelo conselho', 'Lar violento', 'Adolescência em rua'),

  -- 6. Tatiane Soares
  ('Tatiane Soares', '44556677889', 'PE-66778899', 27, '1997-11-04', 'Brasileira', 'Solteira', 'Vendedora', 'Médio Incompleto', 'Ativa',
    'Rua da Aurora', 'Boa Vista', '112', '50050-100', 'PE', 'Recife', '81999887766', '81988776655',
    '2025-05-20', '16:00:00', 'Nenhum histórico de substância.', NULL,
    NULL, 'Traumas emocionais na infância', 'Cresceu em abrigo', 'Boa aluna'),

  -- 7. Eliane Costa
  ('Eliane Costa', '55667788990', 'CE-77889900', 50, '1974-08-08', 'Brasileira', 'Viúva', 'Artesã', 'Fundamental Incompleto', 'Ativa',
    'Travessa das Palmeiras', 'Mucuripe', '55', '60165-000', 'CE', 'Fortaleza', '85991234567', '85993456789',
    '2025-04-05', '13:15:00', 'Uso crônico de álcool por mais de 30 anos.', '1 ano',
    'Internação compulsória por risco de morte', 'Perda do marido e isolamento', 'Infância simples no interior', 'Início precoce no consumo');


-- Maria das Dores (id = 1)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (1, 'Álcool', 20, '20 anos', 'Alta');

-- Ana Paula Lima (id = 2)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (2, 'Crack', 26, '10 anos', 'Muito Alta'),
  (2, 'Maconha', 20, '5 anos', 'Média');

-- Jéssica Andrade (id = 3)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (3, 'Maconha', 15, '5 anos', 'Baixa');

-- Carla Menezes (id = 4)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (4, 'Álcool', 25, '15 anos', 'Alta'),
  (4, 'Calmantes', 30, '10 anos', 'Média');

-- Renata Oliveira (id = 5)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (5, 'Crack', 23, '10 anos', 'Alta'),
  (5, 'Cocaína', 25, '8 anos', 'Alta');

-- Eliane Costa (id = 7)
INSERT INTO drogas_utilizadas
  (assistida_id, tipo, idade_inicio, tempo_uso, intensidade)
VALUES
  (7, 'Álcool', 17, '30 anos', 'Muito Alta');

-- Maria das Dores (id = 1)
INSERT INTO internacoes
  (assistida_id, local, duracao, data)
VALUES
  (1, 'Clínica Esperança', '30 dias', '2022-01-10'),
  (1, 'Casa Recomeço', '45 dias', '2023-03-05');

-- Carla Menezes (id = 4)
INSERT INTO internacoes
  (assistida_id, local, duracao, data)
VALUES
  (4, 'Centro de Reabilitação Bahia', '60 dias', '2024-10-15');

-- Renata Oliveira (id = 5)
INSERT INTO internacoes
  (assistida_id, local, duracao, data)
VALUES
  (5, 'Unidade Terapêutica Porto Seguro', '40 dias', '2023-07-22'),
  (5, 'Clínica Nova Vida', '90 dias', '2022-11-10');

-- Eliane Costa (id = 7)
INSERT INTO internacoes
  (assistida_id, local, duracao, data)
VALUES
  (7, 'Hospital São José', '15 dias', '2023-04-18'),
  (7, 'Casa da Esperança', '30 dias', '2024-01-30');

-- Maria das Dores
INSERT INTO medicamentos_utilizados
  (assistida_id, nome, dosagem, frequencia)
VALUES
  (1, 'Clonazepam', '2mg', '1x ao dia');

-- Jéssica Andrade
INSERT INTO medicamentos_utilizados
  (assistida_id, nome, dosagem, frequencia)
VALUES
  (3, 'Fluoxetina', '20mg', '1x ao dia');

-- Carla Menezes
INSERT INTO medicamentos_utilizados
  (assistida_id, nome, dosagem, frequencia)
VALUES
  (4, 'Diazepam', '5mg', '2x ao dia');

-- Eliane Costa
INSERT INTO medicamentos_utilizados
  (assistida_id, nome, dosagem, frequencia)
VALUES
  (7, 'Risperidona', '1mg', '1x ao dia');

-- Verificar dados inseridos
SELECT 'Medicamentos inseridos:' as info, COUNT(*) as total
FROM medicamentos;
SELECT 'Doações inseridas:' as info, COUNT(*) as total
FROM doacoes;
SELECT 'Total arrecadado:' as info, CONCAT('R$ ', FORMAT(SUM(valor), 2, 'pt_BR')) as valor
FROM doacoes;

SELECT 'Assistidas inseridas:' AS info, COUNT(*) AS total
FROM assistidas;
SELECT 'Drogas utilizadas registradas:' AS info, COUNT(*) AS total
FROM drogas_utilizadas;
SELECT 'Internações registradas:' AS info, COUNT(*) AS total
FROM internacoes;
SELECT 'Medicações utilizadas registradas:' AS info, COUNT(*) AS total
FROM medicamentos_utilizados;