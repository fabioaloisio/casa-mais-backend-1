const express = require('express');
const cors = require('cors');
const medicamentoRoutes = require('./routes/medicamentoRoutes');

const app = express();

//middlewares
app.use(cors());
app.use(express.json());


//routes
app.use('/api/medicamentos', medicamentoRoutes);

app.get('/', (req, res) => {
  res.json({ message: 'API Casa+ funcionando!' });
})

module.exports = app;
