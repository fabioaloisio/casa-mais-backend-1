# Scripts do Casa Mais

Scripts para configuração completa do banco de dados com um único comando.

## 🚀 Setup Rápido

### Opção 1: Reset Completo (Recomendado)
```bash
# Via npm script (recomendado)
npm run db:reset

# Ou diretamente
node scripts/reset-and-setup-db.js
```

### Opção 2: Setup Incremental
```bash
# Via npm script (recomendado)  
npm run db:setup

# Ou diretamente
node scripts/setup-complete-db.js
```

### Opção 3: SQL Direto
```bash
# Script SQL completo
mysql -u root -p3511 casamais_db < scripts/sql/reset_and_create_all.sql

# Ou em partes
mysql -u root -p3511 casamais_db < scripts/sql/create_all_tables.sql
mysql -u root -p3511 casamais_db < scripts/sql/populate_all_data.sql
```

## 📋 Estrutura Criada

### Tabelas com Foreign Keys otimizadas:

#### **tipos_despesas**
- `id` (PK)
- `nome`, `descricao`, `ativo`
- Timestamps automáticos

#### **doadores** 
- `id` (PK)
- `tipo_doador`, `nome`, `documento`
- `email`, `telefone`, `endereco`, `cidade`, `estado`, `cep`
- Timestamps automáticos

#### **despesas**
- `id` (PK)
- `tipo_despesa_id` (FK → tipos_despesas.id) ← **Posição 2**
- `descricao`, `categoria`, `valor`, `data_despesa`
- `forma_pagamento`, `fornecedor`, `observacoes`, `status`
- Timestamps automáticos

#### **doacoes**
- `id` (PK)  
- `doador_id` (FK → doadores.id) ← **Posição 2**
- `valor`, `data_doacao`, `observacoes`
- Timestamps automáticos

## ⚡ Características

- **Engine**: InnoDB com charset utf8mb4
- **Foreign Keys**: `ON DELETE RESTRICT ON UPDATE CASCADE`
- **Índices**: Automáticos nas FKs e campos principais
- **Validação**: Documentos únicos, campos obrigatórios
- **Performance**: Estrutura otimizada para consultas

## 📊 Dados Incluídos

- **10 tipos de despesas** essenciais (Alimentação, Medicamentos, etc.)
- **5 doadores** (3 PF + 2 PJ com dados realistas)
- **3 despesas** de exemplo com diferentes categorias
- **5 doações** de exemplo vinculadas aos doadores

## ✅ Benefícios

- ✅ **Setup instantâneo** - um comando e está pronto
- ✅ **Estrutura otimizada** - FKs nas posições corretas  
- ✅ **Integridade garantida** - constraints automáticas
- ✅ **Dados prontos** - exemplos para testar imediatamente
- ✅ **Compatibilidade total** - funciona com todo o sistema existente
- ✅ **Zero configuração** - sem ajustes manuais necessários

## 🧪 Scripts de Teste

Para validar as APIs após setup:

```bash
# Testar API específica
npm run test:doadores         # Testa endpoints de doadores
npm run test:doacoes         # Testa endpoints de doações  
npm run test:tipos-despesas  # Testa endpoints de tipos de despesa

# Testar todas as APIs
npm run test:all             # Executa todos os testes
npm test                     # Alias para test:all
```

## 📋 Scripts NPM Disponíveis

```bash
npm start                    # Inicia servidor de produção
npm run dev                  # Inicia servidor de desenvolvimento
npm run db:reset            # Reset completo do banco  
npm run db:setup            # Setup incremental do banco
npm run test:all            # Testa todas as APIs
```

## 🎯 Uso Prático

Ideal para:
- ✅ Novos desenvolvedores configurando ambiente
- ✅ Reset durante desenvolvimento/testes  
- ✅ Deployment em novos ambientes
- ✅ Demonstrações e apresentações
- ✅ Validação de APIs após mudanças
