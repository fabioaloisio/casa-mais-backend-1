const express = require('express');
const medicamentoController = require('../controllers/medicamentoController');

const router = express.Router();

router.get('/', medicamentoController.getAll);

module.exports = router;