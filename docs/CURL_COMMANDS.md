# Comandos CURL para Testar APIs - Casa+

Este documento contém todos os comandos curl para testar os endpoints das APIs de Doadores e Doações.

## 🏃‍♂️ Execução Rápida

Para executar todos os testes automaticamente:

```bash
# Testar endpoints de doadores
./test_doadores_endpoints.sh

# Testar endpoints de doações
./test_doacoes_endpoints.sh
```

## 👥 API DE DOADORES

### 1. Listar Todos os Doadores
```bash
curl -X GET http://localhost:3003/api/doadores
```

### 2. Criar Doador Pessoa Física
```bash
curl -X POST http://localhost:3003/api/doadores \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PF",
    "nome": "João da Silva Santos",
    "documento": "12345678901",
    "email": "joao.santos@email.com",
    "telefone": "11999887766",
    "endereco": "Rua das Flores, 123",
    "cidade": "São Paulo",
    "estado": "SP",
    "cep": "01234567"
  }'
```

### 3. Criar Doador Pessoa Jurídica
```bash
curl -X POST http://localhost:3003/api/doadores \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PJ",
    "nome": "Empresa Solidária LTDA",
    "documento": "12345678000190",
    "email": "contato@empresa.com.br",
    "telefone": "1133334444",
    "endereco": "Av. Paulista, 1000",
    "cidade": "São Paulo",
    "estado": "SP",
    "cep": "01310100"
  }'
```

### 4. Buscar Doador por ID
```bash
curl -X GET http://localhost:3003/api/doadores/1
```

### 5. Filtrar Doadores por Tipo
```bash
# Pessoa Física
curl -X GET "http://localhost:3003/api/doadores?tipo_doador=PF"

# Pessoa Jurídica
curl -X GET "http://localhost:3003/api/doadores?tipo_doador=PJ"
```

### 6. Buscar Doadores por Nome
```bash
curl -X GET "http://localhost:3003/api/doadores?search=Silva"
```

### 7. Atualizar Doador
```bash
curl -X PUT http://localhost:3003/api/doadores/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "João da Silva Santos ATUALIZADO",
    "email": "joao.atualizado@email.com",
    "telefone": "11888777666"
  }'
```

### 8. Buscar Doações de um Doador
```bash
curl -X GET http://localhost:3003/api/doadores/1/doacoes
```

### 9. Desativar Doador
```bash
curl -X DELETE http://localhost:3003/api/doadores/2
```

### 10. Testar Validações - Documento Duplicado
```bash
curl -X POST http://localhost:3003/api/doadores \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PF",
    "nome": "Outro Nome",
    "documento": "12345678901",
    "email": "outro@email.com",
    "telefone": "11555444333"
  }'
```

### 11. Testar Validações - Dados Inválidos
```bash
curl -X POST http://localhost:3003/api/doadores \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "INVALIDO",
    "nome": "",
    "documento": "123",
    "telefone": ""
  }'
```

## 💰 API DE DOAÇÕES

### 1. Listar Todas as Doações
```bash
curl -X GET http://localhost:3003/api/doacoes
```

### 2. Criar Doação com Doador Existente
```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 250.75,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação teste via API"
  }'
```

### 3. Criar Doação com Novo Doador (Modo Compatibilidade)
```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "dadosDoador": {
      "tipoDoador": "PF",
      "nomeDoador": "Maria Fernanda Costa",
      "documento": "98765432100",
      "email": "maria.costa@email.com",
      "telefone": "11987654321"
    },
    "valor": 150.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Primeira doação da Maria"
  }'
```

### 4. Buscar Doação por ID
```bash
curl -X GET http://localhost:3003/api/doacoes/1
```

### 5. Buscar Doações por Doador
```bash
curl -X GET http://localhost:3003/api/doacoes/doador/1
```

### 6. Filtrar Doações por Período
```bash
curl -X GET "http://localhost:3003/api/doacoes?dataInicio=2025-01-01&dataFim=2025-12-31"
```

### 7. Filtrar Doações por Tipo de Doador
```bash
# Pessoa Física
curl -X GET "http://localhost:3003/api/doacoes?tipoDoador=PF"

# Pessoa Jurídica
curl -X GET "http://localhost:3003/api/doacoes?tipoDoador=PJ"
```

### 8. Filtrar por Nome do Doador
```bash
curl -X GET "http://localhost:3003/api/doacoes?nomeDoador=Silva"
```

### 9. Atualizar Doação
```bash
curl -X PUT http://localhost:3003/api/doacoes/1 \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 300.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação ATUALIZADA via API"
  }'
```

### 10. Obter Estatísticas de Doações
```bash
curl -X GET http://localhost:3003/api/doacoes/estatisticas
```

### 11. Estatísticas por Período
```bash
curl -X GET "http://localhost:3003/api/doacoes/estatisticas?dataInicio=2025-01-01&dataFim=2025-12-31"
```

### 12. Excluir Doação
```bash
curl -X DELETE http://localhost:3003/api/doacoes/2
```

### 13. Testar Validações - Doação sem Doador
```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "valor": 100.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação sem doador"
  }'
```

### 14. Testar Validações - Dados Inválidos
```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": -50,
    "dataDoacao": "2026-01-01",
    "observacoes": "Doação inválida"
  }'
```

## 📊 Exemplos de Respostas

### Sucesso - Listar Doadores
```json
[
  {
    "id": 1,
    "tipo_doador": "PF",
    "nome": "Maria Silva Santos",
    "documento": "12345678901",
    "email": "maria.silva@email.com",
    "telefone": "11987654321",
    "endereco": null,
    "cidade": null,
    "estado": null,
    "cep": null,
    "data_cadastro": "2025-06-06T00:37:28.000Z",
    "data_atualizacao": null,
    "ativo": true
  }
]
```

### Sucesso - Criar Doação
```json
{
  "success": true,
  "message": "Doação cadastrada com sucesso",
  "data": {
    "id": 21,
    "doadorId": 1,
    "doador": {
      "id": 1,
      "nome": "João da Silva Santos",
      "documento": "12345678901",
      "tipoDoador": "PF",
      "email": "joao@email.com",
      "telefone": "11999999999"
    },
    "valor": 250.75,
    "dataDoacao": "2025-06-05T03:00:00.000Z",
    "observacoes": "Doação teste via API",
    "dataCadastro": "2025-06-06T03:44:02.000Z",
    "dataAtualizacao": null
  }
}
```

### Erro - Validação
```json
{
  "error": "Campos obrigatórios: tipo_doador, nome, documento, telefone"
}
```

### Erro - Documento Duplicado
```json
{
  "error": "Já existe um doador cadastrado com este documento",
  "doador": {
    "id": 1,
    "nome": "João da Silva Santos",
    // ... outros campos
  }
}
```

## 🔧 Configuração

Certifique-se de que:

1. O servidor está rodando em `http://localhost:3003`
2. O banco de dados foi configurado e populado
3. As tabelas `doadores` e `doacoes` existem e estão relacionadas

Para iniciar o servidor:
```bash
npm run dev
```

## 📝 Notas

- Todos os campos de data devem estar no formato ISO: `YYYY-MM-DD`
- Valores monetários podem ser decimal: `250.75`
- CPF deve ter 11 dígitos, CNPJ deve ter 14 dígitos
- Telefones podem ter formatação ou apenas números
- A API mantém compatibilidade com o formato antigo usando `dadosDoador`