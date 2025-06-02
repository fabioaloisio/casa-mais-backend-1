# Configuração do MySQL para Casa Mais

## 1. Instalação do MySQL

### Windows

- Baixe o MySQL Installer em: https://dev.mysql.com/downloads/installer/
- Execute o instalador e siga as instruções
- Durante a instalação, defina a senha do usuário root

### macOS

```bash
# Usando Homebrew
brew install mysql
brew services start mysql
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
```

## 2. Configuração Rápida (Recomendada)

### Método Automatizado

```bash
# 1. Instalar dependências
npm install

# 2. Copiar arquivo de configuração
cp .env.example .env

# 3. Editar .env com suas credenciais MySQL
# (veja seção 3 abaixo)

# 4. Criar banco e tabelas automaticamente
npm run setup-db

# 5. (Opcional) Popular com dados de exemplo
npm run populate-db
```

## 3. Configurar Variáveis de Ambiente

### Editar o arquivo .env

```env
# Configurações do Servidor
PORT=3003
NODE_ENV=development

# Configurações do Banco de Dados MySQL
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha    # Altere para sua senha do MySQL
DB_NAME=casamais_db
DB_PORT=3306

# Pool de Conexões
DB_CONNECTION_LIMIT=10
```

## 4. Estrutura do Banco de Dados

### Tabelas Criadas Automaticamente

O script `setup-db` cria automaticamente:

1. **Banco de dados**: `casamais_db`
2. **Tabela `medicamentos`**: Controle de estoque
3. **Tabela `doacoes`**: Gestão de doações com comentários descritivos

### Arquivos SQL

- `sql/setup_database.sql` - Criação do banco e todas as tabelas
- `sql/populate_data.sql` - Dados de exemplo para testes

## 5. Iniciar o Servidor

### Desenvolvimento (com hot reload)

```bash
npm run dev   # Usa nodemon para reiniciar automaticamente
```

### Produção

```bash
npm start
```

Você deve ver a mensagem: "Conectado com sucesso ao banco de dados"

## 6. Testar a API de Doações

### Criar uma doação

```bash
curl -X POST http://localhost:3003/api/doacoes \
  -H "Content-Type: application/json" \
  -d '{
    "tipoDoador": "PF",
    "nomeDoador": "João Silva",
    "documento": "12345678901",
    "email": "joao@email.com",
    "telefone": "11999999999",
    "valor": 100.00,
    "dataDoacao": "2025-01-06",
    "observacoes": "Doação mensal"
  }'
```

### Listar doações

```bash
curl http://localhost:3003/api/doacoes
```

### Obter estatísticas

```bash
curl http://localhost:3003/api/doacoes/estatisticas
```

### Buscar por doador

```bash
curl http://localhost:3003/api/doacoes/doador/12345678901
```

## 7. Integração com Frontend

O frontend React já está configurado para consumir a API:

1. **Frontend**: http://localhost:5173
2. **Backend API**: http://localhost:3003/api

### Módulos Integrados

- ✅ **Doações** - Totalmente integrado com MySQL
- ✅ **Medicamentos** - Totalmente integrado com MySQL
- 🔄 **Demais módulos** - Ainda usando localStorage

## 8. Troubleshooting

### Erro de conexão

- Verifique se o MySQL está rodando:

  ```bash
  # Windows
  net start mysql

  # macOS
  brew services list

  # Linux
  sudo systemctl status mysql
  ```

### Erro de autenticação

- Verifique as credenciais no arquivo .env
- Certifique-se que o usuário tem permissões no banco:
  ```sql
  GRANT ALL PRIVILEGES ON casamais_db.* TO 'root'@'localhost';
  FLUSH PRIVILEGES;
  ```

### Porta em uso

- Se a porta 3306 estiver em uso, altere no .env:
  ```env
  DB_PORT=3307
  ```

### Erro "process is not defined" no frontend

- O frontend usa Vite, que requer `import.meta.env` ao invés de `process.env`
- Variáveis de ambiente devem começar com `VITE_`

## 9. Backup e Restauração

### Fazer backup

```bash
mysqldump -u root -p casamais_db > backup_casamais_$(date +%Y%m%d).sql
```

### Restaurar backup

```bash
mysql -u root -p casamais_db < backup_casamais_20250106.sql
```

## 10. Scripts Disponíveis

- `npm run dev` - Inicia servidor com nodemon (hot reload)
- `npm start` - Inicia servidor em produção
- `npm run setup-db` - Cria banco e tabelas
- `npm run populate-db` - Popula com dados de exemplo

## 11. Estrutura de Arquivos SQL

```
sql/
├── setup_database.sql    # Criação do banco e tabelas com comentários
└── populate_data.sql     # Dados de exemplo para testes
```

**Nota**: Toda alteração na estrutura do banco deve ser feita no arquivo `setup_database.sql` para manter consistência.