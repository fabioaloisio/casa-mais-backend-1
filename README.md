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

```bash
# Instalar dependências
npm install

# Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas credenciais do MySQL

# Criar banco de dados e tabelas
npm run setup-db

# Popular com dados de exemplo (opcional)
npm run populate-db
```

## 🎯 Scripts Disponíveis

- `npm run dev` - Inicia o servidor com nodemon (hot reload)
- `npm start` - Inicia o servidor em produção
- `npm run setup-db` - Cria o banco de dados e tabelas
- `npm run populate-db` - Popula o banco com dados de exemplo

## 🔧 Configuração

### Variáveis de Ambiente (.env)

```env
# Servidor
PORT=3003
NODE_ENV=development

# Banco de Dados MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=casamais_db
DB_PORT=3306

# Pool de Conexões
DB_CONNECTION_LIMIT=10
```

## 📁 Estrutura do Projeto

```
src/
├── app.js              # Configuração do Express
├── config/
│   └── database.js     # Configuração e pool de conexões MySQL
├── controllers/        # Controladores (lógica de negócio)
│   ├── medicamentoController.js
│   └── doacaoController.js
├── models/             # Modelos (validação e formatação)
│   ├── medicamento.js
│   └── doacao.js
├── repository/         # Camada de acesso a dados
│   ├── medicamentoRepository.js
│   └── doacaoRepository.js
└── routes/             # Definição de rotas
    ├── medicamentoRoutes.js
    └── doacaoRoutes.js
```

## 🛣️ Endpoints da API

### Base URL
```
http://localhost:3003/api
```

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
cd ../casa-mais-react
npm run dev
```

### Padrões de Código

- CommonJS modules (`require`/`module.exports`)
- Async/await para operações assíncronas
- Tratamento de erros centralizado
- Respostas padronizadas: `{ success: boolean, data?: any, error?: string }`

## 📊 Banco de Dados

### Tabelas Principais

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