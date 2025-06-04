require('dotenv').config();
const app = require('./src/app.js');

const PORT = process.env.PORT || 3003;

app.listen(PORT, () => {
  console.log(`Servidor escutando em: http://localhost:${PORT}`);
})