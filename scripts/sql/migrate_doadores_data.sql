-- Script de migração de dados existentes de doações para doadores

-- 1. Inserir doadores únicos baseados nos dados existentes de doações
INSERT INTO doadores (tipo_doador, nome, documento, email, telefone, ativo)
SELECT DISTINCT 
    tipo_doador,
    nome_doador,
    documento,
    d.email,
    d.telefone,
    TRUE as ativo
FROM doacoes d
WHERE d.documento IS NOT NULL
  AND d.documento != ''
ON DUPLICATE KEY UPDATE
    nome = VALUES(nome),
    email = COALESCE(VALUES(email), doadores.email),
    telefone = VALUES(telefone);

-- 2. Atualizar a tabela doacoes com o doador_id correspondente
UPDATE doacoes d
INNER JOIN doadores dr ON d.documento = dr.documento
SET d.doador_id = dr.id
WHERE d.doador_id IS NULL;

-- 3. Verificar se todos os registros foram migrados
SELECT COUNT(*) as doacoes_sem_doador
FROM doacoes
WHERE doador_id IS NULL;

-- 4. Após verificar que todos os registros foram migrados, adicionar a foreign key
-- ALTER TABLE doacoes ADD CONSTRAINT fk_doador FOREIGN KEY (doador_id) REFERENCES doadores(id);

-- 5. Após confirmar que tudo está funcionando, remover as colunas antigas
ALTER TABLE doacoes 
DROP COLUMN tipo_doador,
DROP COLUMN nome_doador,
DROP COLUMN documento,
DROP COLUMN email,
DROP COLUMN telefone;