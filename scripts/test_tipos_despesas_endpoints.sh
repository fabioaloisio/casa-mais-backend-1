#!/bin/bash

# Script de teste para endpoints de Tipos de Despesas
# Casa+ Backend - Teste completo do CRUD

echo "🧪 Iniciando testes dos endpoints de Tipos de Despesas..."
echo "============================================================"

BASE_URL="http://localhost:3003/api/tipos-despesas"

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para imprimir resultados
print_result() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
    fi
}

# Teste 1: Listar todos os tipos de despesas
echo -e "${BLUE}📋 Teste 1: GET $BASE_URL${NC}"
response=$(curl -s -w "%{http_code}" -X GET "$BASE_URL")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    print_result 0 "Listagem de tipos de despesas"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Listagem de tipos de despesas (HTTP $http_code)"
fi
echo

# Teste 2: Criar um novo tipo de despesa
echo -e "${BLUE}➕ Teste 2: POST $BASE_URL${NC}"
new_tipo_data='{
  "nome": "Evento Beneficente",
  "descricao": "Gastos com organização de eventos para arrecadação de fundos",
  "ativo": true
}'

response=$(curl -s -w "%{http_code}" -X POST "$BASE_URL" \
  -H "Content-Type: application/json" \
  -d "$new_tipo_data")

http_code="${response: -3}"
if [ "$http_code" = "201" ]; then
    print_result 0 "Criação de tipo de despesa"
    created_tipo=$(echo "${response%???}" | jq -r '.data.id' 2>/dev/null)
    echo "ID criado: $created_tipo"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Criação de tipo de despesa (HTTP $http_code)"
    echo "${response%???}"
fi
echo

# Teste 3: Buscar tipo específico (usar ID 1 - deve existir)
echo -e "${BLUE}🔍 Teste 3: GET $BASE_URL/1${NC}"
response=$(curl -s -w "%{http_code}" -X GET "$BASE_URL/1")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    print_result 0 "Busca de tipo por ID"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Busca de tipo por ID (HTTP $http_code)"
fi
echo

# Teste 4: Atualizar tipo de despesa (usar ID 1)
echo -e "${BLUE}✏️ Teste 4: PUT $BASE_URL/1${NC}"
update_data='{
  "descricao": "Gastos com alimentação, merenda e suprimentos alimentícios - ATUALIZADO"
}'

response=$(curl -s -w "%{http_code}" -X PUT "$BASE_URL/1" \
  -H "Content-Type: application/json" \
  -d "$update_data")

http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    print_result 0 "Atualização de tipo de despesa"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Atualização de tipo de despesa (HTTP $http_code)"
    echo "${response%???}"
fi
echo

# Teste 5: Filtrar tipos ativos
echo -e "${BLUE}🔍 Teste 5: GET $BASE_URL?ativo=true${NC}"
response=$(curl -s -w "%{http_code}" -X GET "$BASE_URL?ativo=true")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    print_result 0 "Filtro por tipos ativos"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Filtro por tipos ativos (HTTP $http_code)"
fi
echo

# Teste 6: Buscar por nome
echo -e "${BLUE}🔍 Teste 6: GET $BASE_URL?search=Alimentação${NC}"
response=$(curl -s -w "%{http_code}" -X GET "$BASE_URL?search=Alimentação")
http_code="${response: -3}"
if [ "$http_code" = "200" ]; then
    print_result 0 "Busca por nome"
    echo "${response%???}" | jq '.' 2>/dev/null || echo "${response%???}"
else
    print_result 1 "Busca por nome (HTTP $http_code)"
fi
echo

# Teste 7: Tentar criar tipo duplicado (deve falhar)
echo -e "${BLUE}❌ Teste 7: POST $BASE_URL (nome duplicado)${NC}"
duplicate_data='{
  "nome": "Alimentação",
  "descricao": "Teste de duplicação"
}'

response=$(curl -s -w "%{http_code}" -X POST "$BASE_URL" \
  -H "Content-Type: application/json" \
  -d "$duplicate_data")

http_code="${response: -3}"
if [ "$http_code" = "409" ]; then
    print_result 0 "Validação de nome duplicado"
    echo "${response%???}"
else
    print_result 1 "Validação de nome duplicado (HTTP $http_code)"
    echo "${response%???}"
fi
echo

# Teste 8: Tentar criar com dados inválidos
echo -e "${BLUE}❌ Teste 8: POST $BASE_URL (dados inválidos)${NC}"
invalid_data='{
  "nome": "",
  "descricao": "Teste com nome vazio"
}'

response=$(curl -s -w "%{http_code}" -X POST "$BASE_URL" \
  -H "Content-Type: application/json" \
  -d "$invalid_data")

http_code="${response: -3}"
if [ "$http_code" = "400" ]; then
    print_result 0 "Validação de dados obrigatórios"
    echo "${response%???}"
else
    print_result 1 "Validação de dados obrigatórios (HTTP $http_code)"
    echo "${response%???}"
fi
echo

# Teste 9: Buscar tipo inexistente
echo -e "${BLUE}❌ Teste 9: GET $BASE_URL/99999${NC}"
response=$(curl -s -w "%{http_code}" -X GET "$BASE_URL/99999")
http_code="${response: -3}"
if [ "$http_code" = "404" ]; then
    print_result 0 "Busca de tipo inexistente"
    echo "${response%???}"
else
    print_result 1 "Busca de tipo inexistente (HTTP $http_code)"
fi
echo

# Limpar dados de teste (se foi criado)
if [ ! -z "$created_tipo" ] && [ "$created_tipo" != "null" ]; then
    echo -e "${BLUE}🗑️ Limpeza: DELETE $BASE_URL/$created_tipo${NC}"
    response=$(curl -s -w "%{http_code}" -X DELETE "$BASE_URL/$created_tipo")
    http_code="${response: -3}"
    if [ "$http_code" = "200" ]; then
        print_result 0 "Exclusão de tipo de despesa criado no teste"
    else
        print_result 1 "Exclusão de tipo de despesa (HTTP $http_code)"
    fi
    echo
fi

echo "============================================================"
echo -e "${GREEN}✅ Testes dos endpoints de Tipos de Despesas concluídos!${NC}"
echo "Para mais informações, consulte a documentação da API."