#!/bin/bash

# Script para testar todos os endpoints de Doadores
# Executar: chmod +x test_doadores_endpoints.sh && ./test_doadores_endpoints.sh

BASE_URL="http://localhost:3003/api/doadores"

echo "🧪 TESTANDO ENDPOINTS DE DOADORES"
echo "=================================="
echo ""

# 1. LISTAR TODOS OS DOADORES
echo "1️⃣  GET - Listar todos os doadores"
echo "curl -X GET $BASE_URL"
curl -X GET $BASE_URL | jq '.' 2>/dev/null || curl -X GET $BASE_URL
echo -e "\n\n"

# 2. CRIAR NOVO DOADOR PESSOA FÍSICA
echo "2️⃣  POST - Criar doador Pessoa Física"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
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
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
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
echo -e "\n\n"

# 3. CRIAR NOVO DOADOR PESSOA JURÍDICA
echo "3️⃣  POST - Criar doador Pessoa Jurídica"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
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
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
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
echo -e "\n\n"

# 4. BUSCAR DOADOR POR ID
echo "4️⃣  GET - Buscar doador por ID (ID = 1)"
echo "curl -X GET $BASE_URL/1"
curl -X GET $BASE_URL/1 | jq '.' 2>/dev/null || curl -X GET $BASE_URL/1
echo -e "\n\n"

# 5. BUSCAR DOADOR POR ID INEXISTENTE
echo "5️⃣  GET - Buscar doador por ID inexistente (ID = 9999)"
echo "curl -X GET $BASE_URL/9999"
curl -X GET $BASE_URL/9999 | jq '.' 2>/dev/null || curl -X GET $BASE_URL/9999
echo -e "\n\n"

# 6. FILTRAR DOADORES POR TIPO
echo "6️⃣  GET - Filtrar doadores por tipo (PF)"
echo "curl -X GET '$BASE_URL?tipo_doador=PF'"
curl -X GET "$BASE_URL?tipo_doador=PF" | jq '.' 2>/dev/null || curl -X GET "$BASE_URL?tipo_doador=PF"
echo -e "\n\n"

# 7. FILTRAR DOADORES POR BUSCA
echo "7️⃣  GET - Buscar doadores por nome"
echo "curl -X GET '$BASE_URL?search=Silva'"
curl -X GET "$BASE_URL?search=Silva" | jq '.' 2>/dev/null || curl -X GET "$BASE_URL?search=Silva"
echo -e "\n\n"

# 8. ATUALIZAR DOADOR
echo "8️⃣  PUT - Atualizar doador (ID = 1)"
echo "curl -X PUT $BASE_URL/1 -H 'Content-Type: application/json' -d '{...}'"
curl -X PUT $BASE_URL/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "João da Silva Santos ATUALIZADO",
    "email": "joao.atualizado@email.com",
    "telefone": "11888777666"
  }' | jq '.' 2>/dev/null || curl -X PUT $BASE_URL/1 \
  -H "Content-Type: application/json" \
  -d '{
    "nome": "João da Silva Santos ATUALIZADO",
    "email": "joao.atualizado@email.com",
    "telefone": "11888777666"
  }'
echo -e "\n\n"

# 9. BUSCAR DOAÇÕES DE UM DOADOR
echo "9️⃣  GET - Buscar doações de um doador (ID = 1)"
echo "curl -X GET $BASE_URL/1/doacoes"
curl -X GET $BASE_URL/1/doacoes | jq '.' 2>/dev/null || curl -X GET $BASE_URL/1/doacoes
echo -e "\n\n"

# 10. TENTAR CRIAR DOADOR COM DOCUMENTO DUPLICADO
echo "🔟 POST - Tentar criar doador com documento duplicado"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PF",
    "nome": "Outro Nome",
    "documento": "12345678901",
    "email": "outro@email.com",
    "telefone": "11555444333"
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PF",
    "nome": "Outro Nome",
    "documento": "12345678901",
    "email": "outro@email.com",
    "telefone": "11555444333"
  }'
echo -e "\n\n"

# 11. TENTAR CRIAR DOADOR COM DADOS INVÁLIDOS
echo "1️⃣1️⃣ POST - Tentar criar doador com dados inválidos"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "INVALIDO",
    "nome": "",
    "documento": "123",
    "telefone": ""
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "INVALIDO",
    "nome": "",
    "documento": "123",
    "telefone": ""
  }'
echo -e "\n\n"

# 12. DESATIVAR DOADOR
echo "1️⃣2️⃣ DELETE - Desativar doador (ID = 2)"
echo "curl -X DELETE $BASE_URL/2"
curl -X DELETE $BASE_URL/2 | jq '.' 2>/dev/null || curl -X DELETE $BASE_URL/2
echo -e "\n\n"

# 13. TENTAR DELETAR DOADOR INEXISTENTE
echo "1️⃣3️⃣ DELETE - Tentar deletar doador inexistente (ID = 9999)"
echo "curl -X DELETE $BASE_URL/9999"
curl -X DELETE $BASE_URL/9999 | jq '.' 2>/dev/null || curl -X DELETE $BASE_URL/9999
echo -e "\n\n"

echo "✅ TODOS OS TESTES CONCLUÍDOS!"
echo "================================"