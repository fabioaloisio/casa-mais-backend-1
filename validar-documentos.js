const mysql = require('mysql2/promise');
require('dotenv').config();

// Função para validar CPF
function validarCPF(cpf) {
  // Remove caracteres não numéricos
  cpf = cpf.replace(/\D/g, '');
  
  if (cpf.length !== 11) return false;
  
  // Verifica se todos os dígitos são iguais
  if (/^(\d)\1{10}$/.test(cpf)) return false;
  
  // Calcula primeiro dígito verificador
  let soma = 0;
  for (let i = 0; i < 9; i++) {
    soma += parseInt(cpf.charAt(i)) * (10 - i);
  }
  let resto = soma % 11;
  const dig1 = resto < 2 ? 0 : 11 - resto;
  
  // Calcula segundo dígito verificador
  soma = 0;
  for (let i = 0; i < 10; i++) {
    soma += parseInt(cpf.charAt(i)) * (11 - i);
  }
  resto = soma % 11;
  const dig2 = resto < 2 ? 0 : 11 - resto;
  
  // Verifica se os dígitos calculados conferem
  return (parseInt(cpf.charAt(9)) === dig1 && parseInt(cpf.charAt(10)) === dig2);
}

// Função para validar CNPJ
function validarCNPJ(cnpj) {
  // Remove caracteres não numéricos
  cnpj = cnpj.replace(/\D/g, '');
  
  if (cnpj.length !== 14) return false;
  
  // Verifica se todos os dígitos são iguais
  if (/^(\d)\1{13}$/.test(cnpj)) return false;
  
  // Pesos para cálculo dos dígitos verificadores
  const pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  
  // Calcula primeiro dígito verificador
  let soma = 0;
  for (let i = 0; i < 12; i++) {
    soma += parseInt(cnpj.charAt(i)) * pesos1[i];
  }
  let resto = soma % 11;
  const dig1 = resto < 2 ? 0 : 11 - resto;
  
  // Calcula segundo dígito verificador
  soma = 0;
  for (let i = 0; i < 13; i++) {
    soma += parseInt(cnpj.charAt(i)) * pesos2[i];
  }
  resto = soma % 11;
  const dig2 = resto < 2 ? 0 : 11 - resto;
  
  // Verifica se os dígitos calculados conferem
  return (parseInt(cnpj.charAt(12)) === dig1 && parseInt(cnpj.charAt(13)) === dig2);
}

async function validarDocumentos() {
  let connection;

  try {
    connection = await mysql.createConnection({
      host: process.env.DB_HOST || 'localhost',
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME || 'casamais_db'
    });

    console.log('🔍 Validando documentos gerados...\n');

    // Buscar todos os doadores
    const [doadores] = await connection.execute('SELECT * FROM doadores ORDER BY tipo_doador, id');
    
    let cpfsValidos = 0;
    let cpfsInvalidos = 0;
    let cnpjsValidos = 0;
    let cnpjsInvalidos = 0;

    doadores.forEach(doador => {
      const isValid = doador.tipo_doador === 'PF' 
        ? validarCPF(doador.documento) 
        : validarCNPJ(doador.documento);
      
      if (doador.tipo_doador === 'PF') {
        if (isValid) {
          cpfsValidos++;
        } else {
          cpfsInvalidos++;
          console.log(`❌ CPF INVÁLIDO: ${doador.nome} - ${doador.documento}`);
        }
      } else {
        if (isValid) {
          cnpjsValidos++;
        } else {
          cnpjsInvalidos++;
          console.log(`❌ CNPJ INVÁLIDO: ${doador.nome} - ${doador.documento}`);
        }
      }
    });

    console.log('📊 Resultado da validação:');
    console.log(`   ✅ CPFs válidos: ${cpfsValidos}`);
    console.log(`   ❌ CPFs inválidos: ${cpfsInvalidos}`);
    console.log(`   ✅ CNPJs válidos: ${cnpjsValidos}`);
    console.log(`   ❌ CNPJs inválidos: ${cnpjsInvalidos}`);
    
    console.log('\n🔍 Exemplos de documentos válidos:');
    
    // Mostrar alguns exemplos
    const exemplosPF = doadores.filter(d => d.tipo_doador === 'PF').slice(0, 3);
    console.log('\n📋 CPFs:');
    exemplosPF.forEach(d => {
      const valido = validarCPF(d.documento);
      console.log(`   ${d.nome}: ${d.documento} ${valido ? '✅' : '❌'}`);
    });
    
    const exemplosPJ = doadores.filter(d => d.tipo_doador === 'PJ').slice(0, 3);
    console.log('\n🏢 CNPJs:');
    exemplosPJ.forEach(d => {
      const valido = validarCNPJ(d.documento);
      console.log(`   ${d.nome}: ${d.documento} ${valido ? '✅' : '❌'}`);
    });

    console.log('\n🏠 Exemplos de endereços gerados:');
    doadores.slice(0, 5).forEach(d => {
      console.log(`   ${d.nome}: ${d.endereco}, ${d.cidade}/${d.estado} - CEP: ${d.cep}`);
    });

  } catch (error) {
    console.error('❌ Erro:', error.message);
  } finally {
    if (connection) {
      await connection.end();
    }
  }
}

validarDocumentos();