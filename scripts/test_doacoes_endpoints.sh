#!/bin/bash

# Script para testar todos os endpoints de Doações
# Executar: chmod +x test_doacoes_endpoints.sh && ./test_doacoes_endpoints.sh

BASE_URL="http://localhost:3003/api/doacoes"
DOADORES_URL="http://localhost:3003/api/doadores"

echo "🎯 TESTANDO ENDPOINTS DE DOAÇÕES"
echo "================================"
echo ""

# 1. LISTAR TODAS AS DOAÇÕES
echo "1️⃣  GET - Listar todas as doações"
echo "curl -X GET $BASE_URL"
curl -X GET $BASE_URL | jq '.' 2>/dev/null || curl -X GET $BASE_URL
echo -e "\n\n"

# 2. CRIAR DOAÇÃO COM DOADOR EXISTENTE
echo "2️⃣  POST - Criar doação com doador existente (doadorId = 1)"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 250.75,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação teste via API"
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 250.75,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação teste via API"
  }'
echo -e "\n\n"

# 3. CRIAR DOAÇÃO COM NOVO DOADOR (dadosDoador)
echo "3️⃣  POST - Criar doação com novo doador"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
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
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
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
echo -e "\n\n"

# 4. BUSCAR DOAÇÃO POR ID
echo "4️⃣  GET - Buscar doação por ID (ID = 1)"
echo "curl -X GET $BASE_URL/1"
curl -X GET $BASE_URL/1 | jq '.' 2>/dev/null || curl -X GET $BASE_URL/1
echo -e "\n\n"

# 5. BUSCAR DOAÇÕES POR DOADOR
echo "5️⃣  GET - Buscar doações por doador (doadorId = 1)"
echo "curl -X GET $BASE_URL/doador/1"
curl -X GET $BASE_URL/doador/1 | jq '.' 2>/dev/null || curl -X GET $BASE_URL/doador/1
echo -e "\n\n"

# 6. FILTRAR DOAÇÕES POR PERÍODO
echo "6️⃣  GET - Filtrar doações por período"
echo "curl -X GET '$BASE_URL?dataInicio=2025-01-01&dataFim=2025-12-31'"
curl -X GET "$BASE_URL?dataInicio=2025-01-01&dataFim=2025-12-31" | jq '.' 2>/dev/null || curl -X GET "$BASE_URL?dataInicio=2025-01-01&dataFim=2025-12-31"
echo -e "\n\n"

# 7. FILTRAR DOAÇÕES POR TIPO DE DOADOR
echo "7️⃣  GET - Filtrar doações por tipo de doador (PF)"
echo "curl -X GET '$BASE_URL?tipoDoador=PF'"
curl -X GET "$BASE_URL?tipoDoador=PF" | jq '.' 2>/dev/null || curl -X GET "$BASE_URL?tipoDoador=PF"
echo -e "\n\n"

# 8. ATUALIZAR DOAÇÃO
echo "8️⃣  PUT - Atualizar doação (ID = 1)"
echo "curl -X PUT $BASE_URL/1 -H 'Content-Type: application/json' -d '{...}'"
curl -X PUT $BASE_URL/1 \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 300.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação ATUALIZADA via API"
  }' | jq '.' 2>/dev/null || curl -X PUT $BASE_URL/1 \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 300.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação ATUALIZADA via API"
  }'
echo -e "\n\n"

# 9. OBTER ESTATÍSTICAS
echo "9️⃣  GET - Obter estatísticas de doações"
echo "curl -X GET $BASE_URL/estatisticas"
curl -X GET $BASE_URL/estatisticas | jq '.' 2>/dev/null || curl -X GET $BASE_URL/estatisticas
echo -e "\n\n"

# 10. TENTAR CRIAR DOAÇÃO SEM DOADOR
echo "🔟 POST - Tentar criar doação sem doador"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "valor": 100.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação sem doador"
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "valor": 100.00,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação sem doador"
  }'
echo -e "\n\n"

# 11. TENTAR CRIAR DOAÇÃO COM DADOS INVÁLIDOS
echo "1️⃣1️⃣ POST - Tentar criar doação com dados inválidos"
echo "curl -X POST $BASE_URL -H 'Content-Type: application/json' -d '{...}'"
curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": -50,
    "dataDoacao": "2026-01-01",
    "observacoes": "Doação inválida"
  }' | jq '.' 2>/dev/null || curl -X POST $BASE_URL \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": -50,
    "dataDoacao": "2026-01-01",
    "observacoes": "Doação inválida"
  }'
echo -e "\n\n"

# 12. EXCLUIR DOAÇÃO
echo "1️⃣2️⃣ DELETE - Excluir doação (ID = 2)"
echo "curl -X DELETE $BASE_URL/2"
curl -X DELETE $BASE_URL/2 | jq '.' 2>/dev/null || curl -X DELETE $BASE_URL/2
echo -e "\n\n"

# 13. TENTAR EXCLUIR DOAÇÃO INEXISTENTE
echo "1️⃣3️⃣ DELETE - Tentar excluir doação inexistente (ID = 9999)"
echo "curl -X DELETE $BASE_URL/9999"
curl -X DELETE $BASE_URL/9999 | jq '.' 2>/dev/null || curl -X DELETE $BASE_URL/9999
echo -e "\n\n"

echo "✅ TODOS OS TESTES DE DOAÇÕES CONCLUÍDOS!"
echo "========================================"