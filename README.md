# Casa Mais - Backend

API REST para o sistema de gestão da organização social Casa de Lázaro de Betânia.

## 🚀 Tecnologias

- **Node.js** - Runtime JavaScript
- **Express 5.1.0** - Framework web
- **MySQL2 3.14.1** - Driver MySQL com suporte a Promises
- **CORS 2.8.5** - Middleware para Cross-Origin Resource Sharing
- **Dotenv 16.5.0** - Gerenciamento de variáveis de ambiente
- **Nodemon 3.1.10** - Hot reload para desenvolvimento

## 📦 Instalação

### Pré-requisitos
- Node.js 16+ instalado
- MySQL 8.0+ instalado e rodando
- Ver detalhes em: `CONFIGURACAO_MYSQL.md`

```bash
# Instalar dependências
npm install

# Configurar banco de dados (edite src/config/database.js se necessário)
# Por padrão usa: host=localhost, user=root, password=admin, database=casamais_db

# Criar banco de dados e tabelas
node setup-db.js

# Popular com dados de exemplo (opcional)
node populate-db.js

# Iniciar servidor
npm start
```

## 🎯 Scripts Disponíveis

- `npm start` - Inicia o servidor em produção (porta 3003)
- `node setup-db.js` - Cria o banco de dados e tabelas
- `node populate-db.js` - Popula o banco com dados de exemplo
- `node index.js` - Forma alternativa de iniciar o servidor

## 🔧 Configuração

### Configuração do Banco de Dados

**Arquivo**: `src/config/database.js`

```javascript
// Configuração atual (hardcoded)
host: 'localhost',
user: 'root', 
password: 'admin',
database: 'casamais_db',
port: 3306
```

**⚠️ Para produção**: Configure variáveis de ambiente no `database.js`

```env
# Exemplo para produção
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=casamais_db
DB_PORT=3306
```

Para instruções detalhadas: [CONFIGURACAO_MYSQL.md](./CONFIGURACAO_MYSQL.md)

## 📁 Estrutura do Projeto

```
.
├── index.js            # Ponto de entrada da aplicação
├── setup-db.js         # Script para criar banco e tabelas
├── populate-db.js      # Script para popular dados de exemplo
├── sql/                # Scripts SQL
│   ├── setup_database.sql
│   └── populate_data.sql
└── src/
    ├── app.js          # Configuração do Express
    ├── config/
    │   └── database.js # Configuração e pool de conexões MySQL
    ├── controllers/    # Controladores (lógica de negócio)
    │   ├── assistidaController.js
    │   ├── doacaoController.js
    │   └── medicamentoController.js
    ├── models/         # Modelos (validação e formatação)
    │   ├── assistida.js
    │   ├── doacao.js
    │   └── medicamento.js
    ├── repository/     # Camada de acesso a dados
    │   ├── assistidasRepository.js
    │   ├── doacaoRepository.js
    │   └── medicamentoRepository.js
    └── routes/         # Definição de rotas
        ├── assistidasRoutes.js
        ├── doacaoRoutes.js
        └── medicamentoRoutes.js
```

## 🛣️ Endpoints da API

### Base URL
```
http://localhost:3003/api
```

### Assistidas
- `GET /api/assistidas` - Listar todas as assistidas
- `GET /api/assistidas/:id` - Buscar assistida por ID
- `POST /api/assistidas` - Criar nova assistida
- `PUT /api/assistidas/:id` - Atualizar assistida
- `DELETE /api/assistidas/:id` - Excluir assistida

### Medicamentos
- `GET /api/medicamentos` - Listar todos os medicamentos
- `GET /api/medicamentos/:id` - Buscar medicamento por ID
- `POST /api/medicamentos` - Criar novo medicamento
- `PUT /api/medicamentos/:id` - Atualizar medicamento
- `DELETE /api/medicamentos/:id` - Excluir medicamento

### Doações
- `GET /api/doacoes` - Listar todas as doações
  - Query params: `tipo_doador`, `data_inicio`, `data_fim`, `limit`, `offset`
- `GET /api/doacoes/:id` - Buscar doação por ID
- `GET /api/doacoes/doador/:documento` - Buscar doações por CPF/CNPJ
- `GET /api/doacoes/estatisticas` - Obter estatísticas
- `POST /api/doacoes` - Criar nova doação
- `PUT /api/doacoes/:id` - Atualizar doação
- `DELETE /api/doacoes/:id` - Excluir doação

## 🏗️ Arquitetura

O projeto segue o padrão **MVC + Repository Pattern**:

1. **Routes** → Define os endpoints e mapeia para controllers
2. **Controllers** → Recebe requisições, valida e retorna respostas
3. **Models** → Define estrutura e validações de negócio
4. **Repository** → Acesso ao banco de dados
5. **Database** → Pool de conexões MySQL

### Fluxo de Dados

```
Request → Route → Controller → Model (validação) → Repository → Database
                      ↓
                   Response ← Controller ← Repository ←
```

## 🔒 Segurança

- Validação de entrada em todos os endpoints
- Prepared statements para prevenir SQL Injection
- CORS configurado para aceitar requisições do frontend
- Variáveis sensíveis em arquivo .env (não commitado)

## 🧪 Desenvolvimento

### Iniciando em modo desenvolvimento

```bash
# Backend com hot reload
npm run dev

# Em outro terminal, frontend
cd ../frontend
npm run dev
```

### Padrões de Código

- CommonJS modules (`require`/`module.exports`)
- Async/await para operações assíncronas
- Tratamento de erros centralizado
- Respostas padronizadas: `{ success: boolean, data?: any, error?: string }`

## 📊 Banco de Dados

### Tabelas Principais

**assistidas**
```sql
- id (INT, PK, AUTO_INCREMENT)
- nome_completo (VARCHAR 255)
- cpf (VARCHAR 11, UNIQUE)
- data_nascimento (DATE)
- telefone (VARCHAR 15)
- email (VARCHAR 255)
- endereco (VARCHAR 255)
- cep (VARCHAR 8)
- cidade (VARCHAR 100)
- estado (VARCHAR 2)
- estado_civil (ENUM)
- profissao (VARCHAR 100)
- renda_familiar (DECIMAL 10,2)
- numero_filhos (INT)
- situacao_habitacional (ENUM)
- beneficios_sociais (TEXT)
- condicoes_saude (TEXT)
- medicamentos_uso (TEXT)
- historico_atendimento (TEXT)
- observacoes (TEXT)
- data_cadastro (DATETIME)
- data_atualizacao (DATETIME)
```

**drogas_utilizadas** (relacionada com assistidas)
```sql
- id (INT, PK, AUTO_INCREMENT)
- assistida_id (INT, FK)
- droga (VARCHAR 100)
- frequencia (VARCHAR 50)
- observacoes (TEXT)
```

**internacoes** (relacionada com assistidas)
```sql
- id (INT, PK, AUTO_INCREMENT) 
- assistida_id (INT, FK)
- data_internacao (DATE)
- motivo (VARCHAR 255)
- instituicao (VARCHAR 255)
- data_alta (DATE)
- observacoes (TEXT)
```

**medicamentos**
```sql
- id (INT, PK, AUTO_INCREMENT)
- nome (VARCHAR 100)
- tipo (VARCHAR 45)
- quantidade (INT)
- validade (DATE)
- createdAt (TIMESTAMP)
- updatedAt (TIMESTAMP)
```

**doacoes**
```sql
- id (INT, PK, AUTO_INCREMENT)
- tipo_doador (ENUM 'PF', 'PJ')
- nome_doador (VARCHAR 255)
- documento (VARCHAR 14)
- email (VARCHAR 255)
- telefone (VARCHAR 15)
- valor (DECIMAL 10,2)
- data_doacao (DATE)
- observacoes (TEXT)
- data_cadastro (DATETIME)
- data_atualizacao (DATETIME)
```

**drogas_utilizadas** (relacionada com assistidas)
```sql
- id (INT, PK, AUTO_INCREMENT)
- assistida_id (INT, FK)
- tipo (VARCHAR 100)
- idade_inicio (INT)
- tempo_uso (VARCHAR 100)
- intensidade (VARCHAR 100)
- createdAt, updatedAt (TIMESTAMPS)
```

**internacoes** (relacionada com assistidas)
```sql
- id (INT, PK, AUTO_INCREMENT)
- assistida_id (INT, FK)
- local (VARCHAR 255)
- duracao (VARCHAR 100)
- data (DATE)
- createdAt, updatedAt (TIMESTAMPS)
```

## 🚀 Deploy

Para deploy em produção:

1. Configure as variáveis de ambiente no servidor
2. Execute `npm install --production`
3. Configure um processo manager (PM2, systemd, etc.)
4. Configure proxy reverso (Nginx, Apache)
5. Configure SSL/TLS

## 👥 Contribuindo

1. Crie uma branch para sua feature (`git checkout -b feature/NovaFuncionalidade`)
2. Commit suas mudanças (`git commit -m 'Add: nova funcionalidade'`)
3. Push para a branch (`git push origin feature/NovaFuncionalidade`)
4. Abra um Pull Request

## 📝 Licença

ISC - Grupo 4