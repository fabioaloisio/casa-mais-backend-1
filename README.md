# 🏠 Casa+ Backend

API REST completa para o sistema de gestão da Casa+, uma ONG dedicada ao cuidado de mulheres em situação de vulnerabilidade.

## 🚀 Funcionalidades Implementadas

### 👥 **Gestão de Doadores**

- ✅ CRUD completo de doadores (PF/PJ)
- ✅ CPF/CNPJ com dígitos verificadores válidos
- ✅ Endereços completos com dados brasileiros
- ✅ Histórico completo de doações por doador

### 💰 **Gestão de Doações**

- ✅ Sistema normalizado com relacionamento entre doadores e doações
- ✅ Compatibilidade com formato antigo (dadosDoador inline)
- ✅ Filtros avançados (período, tipo, doador)
- ✅ Estatísticas e relatórios
- ✅ Validações de negócio

### 💊 **Gestão de Medicamentos**

- ✅ Cadastro completo com validações
- ✅ Sistema de estoque

### 👩 **Gestão de Assistidas**

- ✅ Cadastro de mulheres assistidas
- ✅ Controle de internações
- ✅ Histórico de medicamentos utilizados

## 🛠️ Tecnologias

- **Node.js** - Runtime JavaScript
- **Express.js** - Framework web
- **MySQL** - Banco de dados relacional
- **mysql2** - Driver MySQL com suporte a promises
- **dotenv** - Gerenciamento de variáveis de ambiente
- **cors** - Middleware para CORS
- **nodemon** - Auto-reload em desenvolvimento

## 📦 Instalação e Setup

### 1. Pré-requisitos

```bash
# Node.js 18+
node --version

# MySQL 8.0+
mysql --version
```

### 2. Instalação

```bash
# Clone o repositório
git clone <url-do-repo>
cd casa_mais/backend

# Instale as dependências
npm install
```

### 3. Configuração do Banco

```bash
# Configure o arquivo .env
cp .env.example .env

# Edite o .env com suas credenciais MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=casamais_db
DB_PORT=3306
```

### 4. Setup do Banco de Dados

```bash
# Criar estrutura do banco
npm run db:create

# Popular com dados de exemplo
npm run db:populate

# Setup completo (criar + popular)
npm run db:setup

# Reset completo (limpar + criar + popular)
npm run db:full-reset

# Ou usar os scripts SQL diretamente
mysql -u root -psua_senha_aqui casamais_db < scripts/sql/create_tables.sql
mysql -u root -psua_senha_aqui casamais_db < scripts/sql/populate_data.sql
mysql -u root -psua_senha_aqui casamais_db < scripts/sql/reset_tables.sql
```

### 5. Iniciar o Servidor

```bash
# Desenvolvimento (auto-reload)
npm run dev

# Produção
npm start
```

Servidor rodando em: `http://localhost:3003`

## 📋 Scripts Disponíveis

| Script                       | Descrição                          |
| ---------------------------- | ---------------------------------- |
| `npm start`                  | Inicia servidor em produção        |
| `npm run dev`                | Inicia servidor em desenvolvimento |
| **Banco de Dados**           |                                    |
| `npm run db:create`          | Cria estrutura do banco            |
| `npm run db:populate`        | Popula dados de exemplo            |
| `npm run db:setup`           | Setup completo (criar + popular)   |
| `npm run db:reset`           | Remove todas as tabelas            |
| `npm run db:full-reset`      | Reset + setup completo             |
| `npm run db:insert-expenses` | Adiciona 20 despesas de exemplo    |

## 🌐 Endpoints da API

### 👥 Doadores (`/api/doadores`)

| Método   | Endpoint       | Descrição               |
| -------- | -------------- | ----------------------- |
| `GET`    | `/`            | Lista todos os doadores |
| `POST`   | `/`            | Cria novo doador        |
| `GET`    | `/:id`         | Busca doador por ID     |
| `PUT`    | `/:id`         | Atualiza doador         |
| `DELETE` | `/:id`         | Desativa doador         |
| `GET`    | `/:id/doacoes` | Histórico de doações    |

**Filtros disponíveis:**

- `?tipo_doador=PF/PJ` - Filtra por tipo
- `?search=nome` - Busca por nome
- `?ativo=true/false` - Filtra por status

### 💰 Doações (`/api/doacoes`)

| Método   | Endpoint        | Descrição              |
| -------- | --------------- | ---------------------- |
| `GET`    | `/`             | Lista todas as doações |
| `POST`   | `/`             | Cria nova doação       |
| `GET`    | `/:id`          | Busca doação por ID    |
| `PUT`    | `/:id`          | Atualiza doação        |
| `DELETE` | `/:id`          | Exclui doação          |
| `GET`    | `/doador/:id`   | Doações por doador     |
| `GET`    | `/estatisticas` | Dashboard              |

**Filtros disponíveis:**

- `?tipoDoador=PF/PJ` - Filtra por tipo de doador
- `?dataInicio=YYYY-MM-DD` - Data inicial
- `?dataFim=YYYY-MM-DD` - Data final
- `?doadorId=123` - Doações de um doador específico

### 💊 Medicamentos (`/api/medicamentos`)

| Método   | Endpoint | Descrição            |
| -------- | -------- | -------------------- |
| `GET`    | `/`      | Lista medicamentos   |
| `POST`   | `/`      | Cria medicamento     |
| `GET`    | `/:id`   | Busca por ID         |
| `PUT`    | `/:id`   | Atualiza medicamento |
| `DELETE` | `/:id`   | Exclui medicamento   |

### 👩 Assistidas (`/api/assistidas`)

| Método   | Endpoint | Descrição          |
| -------- | -------- | ------------------ |
| `GET`    | `/`      | Lista assistidas   |
| `POST`   | `/`      | Cria assistida     |
| `GET`    | `/:id`   | Busca por ID       |
| `PUT`    | `/:id`   | Atualiza assistida |
| `DELETE` | `/:id`   | Exclui assistida   |

### 📏 Unidades de Medida (`/api/unidades_medida`)

| Método   | Endpoint | Descrição             |
| -------- | -------- | --------------------- |
| `GET`    | `/`      | Lista unidades medida |
| `POST`   | `/`      | Cria unidade medida   |
| `GET`    | `/:id`   | Busca por ID          |
| `PUT`    | `/:id`   | Atualiza unidade      |
| `DELETE` | `/:id`   | Exclui unidade        |

### 💸 Tipos de Despesas (`/api/tipos-despesas`)

| Método   | Endpoint | Descrição               |
| -------- | -------- | ----------------------- |
| `GET`    | `/`      | Lista tipos de despesas |
| `POST`   | `/`      | Cria tipo de despesa    |
| `GET`    | `/:id`   | Busca por ID            |
| `PUT`    | `/:id`   | Atualiza tipo           |
| `DELETE` | `/:id`   | Exclui tipo             |

**Filtros disponíveis:**

- `?ativo=true/false` - Filtra por status
- `?search=nome` - Busca por nome

## 🧪 Testando a API

### Testes Manuais

### Exemplos de Uso

#### Criar Doador PF

```bash
curl -X POST http://localhost:3003/api/doadores \
  -H "Content-Type: application/json" \
  -d '{
    "tipo_doador": "PF",
    "nome": "João da Silva",
    "documento": "12345678901",
    "email": "joao@email.com",
    "telefone": "11999999999",
    "endereco": "Rua das Flores, 123",
    "cidade": "São Paulo",
    "estado": "SP",
    "cep": "01234567"
  }'
```

#### Criar Doação

```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "doadorId": 1,
    "valor": 250.75,
    "dataDoacao": "2025-06-05",
    "observacoes": "Doação mensal"
  }'
```

## 📊 Estrutura do Banco de Dados

### Tabelas Principais

#### `doadores`

- Informações completas dos doadores
- CPF/CNPJ com validação
- Endereço completo
- Status ativo/inativo

#### `doacoes`

- Relacionamento com doadores via `doador_id`
- Valores e datas das doações
- Observações

#### `medicamentos`

- Catálogo de medicamentos
- Controle de estoque e validade

#### `assistidas`

- Cadastro das mulheres assistidas
- Histórico de atendimentos

#### `tipos_despesas`

- Catálogo de tipos/categorias de despesas
- Classificação para organização financeira

### Relacionamentos

- `doacoes.doador_id` → `doadores.id` (FK)
- `internacoes.assistida_id` → `assistidas.id` (FK)
- `medicamentos_utilizados.medicamento_id` → `medicamentos.id` (FK)

## 🗄️ Scripts SQL

Os scripts SQL estão versionados e organizados na pasta `scripts/sql/`:

### Scripts Principais

| Script                | Descrição                                  | Uso                                                                          |
| --------------------- | ------------------------------------------ | ---------------------------------------------------------------------------- |
| **create_tables.sql** | Cria todas as tabelas do sistema           | `mysql -u root -psua_senha_aqui casamais_db < scripts/sql/create_tables.sql` |
| **populate_data.sql** | Insere dados iniciais para desenvolvimento | `mysql -u root -psua_senha_aqui casamais_db < scripts/sql/populate_data.sql` |
| **reset_tables.sql**  | Remove todas as tabelas (apenas DROP)      | `mysql -u root -psua_senha_aqui casamais_db < scripts/sql/reset_tables.sql`  |

### Estrutura das Tabelas

✅ **Tabelas Implementadas:**

- `doadores` - Gestão de doadores PF/PJ
- `doacoes` - Registro de doações
- `medicamentos` - Catálogo de medicamentos
- `assistidas` - Cadastro de mulheres assistidas
- `unidades_medida` - Unidades para medicamentos
- `tipos_despesas` - Categorias de despesas
- `internacoes` - Histórico de internações
- `medicamentos_utilizados` - Controle de medicamentos

## 📚 Documentação Adicional

- **[scripts/README.md](./scripts/README.md)** - Documentação dos scripts utilitários

### Variáveis de Ambiente

```env
# Servidor
PORT=3003
NODE_ENV=development

# Banco de Dados
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=casamais_db
DB_PORT=3306
DB_CONNECTION_LIMIT=10
```

### Estrutura de Arquivos

```
backend/
├── src/
│   ├── controllers/                # Lógica de controle
│   │   ├── assistidaController.js
│   │   ├── doacaoController.js
│   │   ├── doadorController.js
│   │   ├── medicamentoController.js
│   │   ├── tipoDespesaController.js
│   │   └── unidadeMedidaController.js
│   ├── models/                     # Modelos de dados
│   │   ├── assistida.js
│   │   ├── doacao.js
│   │   ├── doador.js
│   │   ├── medicamento.js
│   │   ├── tipoDespesa.js
│   │   └── unidadeMedida.js
│   ├── repository/                 # Acesso ao banco
│   │   ├── assistidasRepository.js
│   │   ├── doacaoRepository.js
│   │   ├── doadorRepository.js
│   │   ├── medicamentoRepository.js
│   │   ├── tipoDespesaRepository.js
│   │   └── unidadeMedidaRepository.js
│   ├── routes/                     # Definição de rotas
│   │   ├── assistidasRoutes.js
│   │   ├── doacaoRoutes.js
│   │   ├── doadorRoutes.js
│   │   ├── medicamentoRoutes.js
│   │   ├── tipoDespesaRoutes.js
│   │   └── unidadeMedidaRoutes.js
│   ├── config/                     # Configurações
│   │   └── database.js
│   └── app.js                      # Configuração do Express
├── scripts/                        # Scripts utilitários
│   ├── sql/                        # Scripts SQL
│   │   ├── create_tables.sql       # ✅ Cria todas as tabelas do sistema
│   │   ├── populate_data.sql       # ✅ Popula dados iniciais
│   │   ├── reset_tables.sql        # ✅ Remove todas as tabelas
│   ├── utils/
│   │   └── sql-executor.js         # ✅ Utilitário para executar SQL
│   ├── db-create.js                # ✅ Cria estrutura do banco
│   ├── db-populate.js              # ✅ Popula dados de exemplo
│   ├── db-reset.js                 # ✅ Reset das tabelas
│   ├── db-insert-expenses.js       # ✅ Insere despesas extras
│   └── README.md
├── .env.example                    # Exemplo de variáveis de ambiente
├── package.json                    # Dependências
├── package-lock.json               # Lock das dependências
├── index.js                        # Ponto de entrada
└── README.md                       # Este arquivo
```

## 🚨 Validações Implementadas

### Doadores

- ✅ CPF: 11 dígitos com verificadores válidos
- ✅ CNPJ: 14 dígitos com verificadores válidos
- ✅ Email: formato válido
- ✅ Telefone: obrigatório
- ✅ Documento único por doador

### Doações

- ✅ Valor maior que zero
- ✅ Data não pode ser futura
- ✅ Doador obrigatório e válido
- ✅ Relacionamento via foreign key

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'feat: add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença ISC.

---

**Desenvolvido com ❤️ para a Casa+ - Grupo 4 - UNOESTE**
