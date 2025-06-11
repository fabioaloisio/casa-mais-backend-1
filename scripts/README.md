# =Ü Scripts do Backend

Esta pasta contém scripts utilitários para o backend da Casa+.

## =Ë Scripts Disponíveis

### =à **Setup e Configuração**

#### `setup-db.js`

Cria o banco de dados e todas as tabelas necessárias.

```bash
# Executar via npm
npm run setup-db

# Ou diretamente
node scripts/setup-db.js
```

**Funcionalidades:**
-  Cria banco de dados `casamais_db`
-  Cria todas as tabelas com relacionamentos
-  Configura índices e constraints
-  Verifica conexão com MySQL

### =Ã **População de Dados**

#### `populate-db.js`

Popula o banco com dados de exemplo originais, e faz a migração dos dados existentes de doações para doadores

```bash
# Executar via npm
npm run populate-db

# Ou diretamente
node scripts/populate-db.js
```

**Funcionalidades:**

-  Dados de assistidas, medicamentos, doações
-  Estrutura original do sistema
-  Validação de tabelas existentes

#### `populate-doadores.js`

Popula o banco com doadores que possuem CPF/CNPJ válidos e endereços completos.

```bash
# Executar via npm
npm run populate-doadores

# Ou diretamente
node scripts/populate-doadores.js
```

**Funcionalidades:**

-  Gera 10 doadores PF com CPFs válidos
-  Gera 10 doadores PJ com CNPJs válidos
-  Endereços brasileiros completos
-  Limpa dados existentes antes de popular
-  Cria doações associadas aos doadores

### = **Validação**

#### `validar-documentos.js`

Valida todos os CPFs e CNPJs no banco de dados.

```bash
# Executar via npm
npm run validate-docs

# Ou diretamente
node scripts/validar-documentos.js
```

**Funcionalidades:**

-  Valida CPFs usando algoritmo oficial
-  Valida CNPJs usando algoritmo oficial
-  Mostra estatísticas de validação
-  Lista exemplos de documentos válidos

### >ê **Testes de API**

#### `test_doadores_endpoints.sh`

Testa todos os endpoints da API de doadores.

```bash
# Executar via npm
npm run test:doadores

# Ou diretamente
bash scripts/test_doadores_endpoints.sh
```

**Testes inclusos:**

-  Listar doadores
-  Criar doador PF/PJ
-  Buscar por ID
-  Filtros (tipo, busca)
-  Atualizar doador
-  Histórico de doações
-  Validações de erro
-  Desativar doador

#### `test_doacoes_endpoints.sh`

Testa todos os endpoints da API de doações.

```bash
# Executar via npm
npm run test:doacoes

# Ou diretamente
bash scripts/test_doacoes_endpoints.sh
```

**Testes inclusos:**

-  Listar doações
-  Criar com doador existente
-  Criar com novo doador (compatibilidade)
-  Buscar por ID
-  Filtros (período, tipo, doador)
-  Atualizar doação
-  Estatísticas
-  Validações de erro
-  Excluir doação

## =' Pré-requisitos

Para executar os scripts:

1. **Servidor rodando**: `npm run dev`
2. **Banco configurado**: `npm run setup-db`
3. **Dependências instaladas**: `npm install`

## =Ê Saída dos Scripts

### População de Doadores

```
=€ Iniciando população de doadores com dados válidos...

 Conectado ao banco de dados
= Limpando doadores existentes...
= Inserindo doadores PF com CPFs válidos...
= Inserindo doadores PJ com CNPJs válidos...
= Criando doações para os doadores...

=Ê Dados inseridos com sucesso:
   - Doadores: 20
   - Doações: 20
   - Total arrecadado: R$ 10125.00

= Exemplos de CPFs gerados:
   Maria Silva Santos: 29415498110 
   João Pedro Oliveira: 29227197907 
   Ana Beatriz Costa: 35674996610 

 População de doadores concluída com sucesso!
```

### Validação de Documentos

```
= Validando documentos gerados...

=Ê Resultado da validação:
    CPFs válidos: 10
   L CPFs inválidos: 0
    CNPJs válidos: 10
   L CNPJs inválidos: 0

<à Exemplos de endereços gerados:
   Maria Silva Santos: Alameda Bela Vista, 1172, Santo André/PI - CEP: 34019924
   João Pedro Oliveira: Praça Paulista, 3102, Belo Horizonte/SC - CEP: 52569127
```

### Testes de API

```
>ê TESTANDO ENDPOINTS DE DOADORES
==================================

1ã  GET - Listar todos os doadores
Status: 200 

2ã  POST - Criar doador Pessoa Física
Status: 201 

...

 TODOS OS TESTES CONCLUÍDOS!
```

## =à Personalização

### Adicionando Novos Scripts

1. Crie o arquivo na pasta `scripts/`
2. Adicione permissão de execução: `chmod +x scripts/nome_script.sh`
3. Adicione ao `package.json`:
   ```json
   "scripts": {
     "meu-script": "node scripts/meu-script.js"
   }
   ```

### Modificando População

Para alterar os dados gerados, edite:

- `populate-doadores.js` - Nomes, endereços, valores
- Funções `gerarCPFValido()` e `gerarCNPJValido()`
- Arrays de dados fake (cidades, estados, etc.)

## = Resolução de Problemas

### Erro de Conexão

```bash
L Erro: Access denied for user 'root'@'localhost'
```

**Solução**: Verifique as credenciais no `.env`

### Erro de Foreign Key

```bash
L Erro: Cannot add or update a child row: a foreign key constraint fails
```

**Solução**: Execute o script de limpeza antes de popular

### Scripts não Executam

```bash
L Permission denied
```

**Solução**: `chmod +x scripts/*.sh`

## =Ú Documentação Relacionada

- **[../docs/CURL_COMMANDS.md](../docs/CURL_COMMANDS.md)** - Comandos curl manuais
- **[../docs/DOCUMENTOS_VALIDOS.md](../docs/DOCUMENTOS_VALIDOS.md)** - Validação CPF/CNPJ
- **[../README.md](../README.md)** - Documentação principal

---

**Scripts organizados para melhor produtividade! =€**