# Scripts SQL - Casa Mais

Scripts SQL para configuração direta do banco de dados via MySQL.

## 🚀 Uso Rápido

### Opção 1: Setup Completo (Recomendado)
```bash
mysql -u root -p3511 casamais_db < scripts/sql/reset_and_create_all.sql
```
**Remove e recria tudo com estrutura otimizada**

### Opção 2: Setup por Partes
```bash
# 1. Criar estrutura
mysql -u root -p3511 casamais_db < scripts/sql/create_all_tables.sql

# 2. Popular dados
mysql -u root -p3511 casamais_db < scripts/sql/populate_all_data.sql
```

## 📁 Scripts Disponíveis

- **`reset_and_create_all.sql`** - Setup completo (reset + criação + dados)
- **`create_all_tables.sql`** - Apenas estrutura das tabelas
- **`populate_all_data.sql`** - Apenas dados de exemplo

## 📋 Estrutura Criada

```sql
tipos_despesas (id, nome, descricao, ativo, timestamps)
doadores (id, tipo_doador, nome, documento, contatos, timestamps)
despesas (id, tipo_despesa_id, descricao, valor, data, status, timestamps)  -- FK posição 2
doacoes (id, doador_id, valor, data_doacao, observacoes, timestamps)       -- FK posição 2
```

## 🔗 Foreign Keys

- **`despesas.tipo_despesa_id → tipos_despesas.id`**
- **`doacoes.doador_id → doadores.id`**
- Constraints: `ON DELETE RESTRICT ON UPDATE CASCADE`
- Índices automáticos nas FKs para performance

## 📊 Dados Incluídos

- **10 tipos de despesas** (Alimentação, Medicamentos, Manutenção, etc.)
- **5 doadores** (3 Pessoas Físicas + 2 Pessoas Jurídicas)
- **3 despesas** de exemplo com diferentes categorias e status
- **5 doações** de exemplo vinculadas aos doadores

## ⚡ Características Técnicas

- **Engine**: InnoDB
- **Charset**: utf8mb4_0900_ai_ci
- **Validações**: Documentos únicos, campos obrigatórios
- **Índices**: Otimizados para consultas frequentes
- **Timestamps**: Automáticos para auditoria

## ✅ Vantagens

- ✅ **Setup instantâneo** - execução direta no MySQL
- ✅ **Estrutura otimizada** - FKs nas posições corretas
- ✅ **Integridade garantida** - constraints de banco
- ✅ **Dados prontos** - exemplos para teste imediato
- ✅ **Performance** - índices e estrutura otimizada