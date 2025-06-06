# 📋 Documentos Válidos - CPF e CNPJ

Este documento explica como o sistema gera e valida CPF e CNPJ com dígitos verificadores corretos.

## 🆔 CPF (Cadastro de Pessoa Física)

### Regra de Validação
O CPF possui 11 dígitos, sendo os 9 primeiros aleatórios e os 2 últimos são dígitos verificadores calculados.

### Algoritmo de Cálculo

#### Primeiro Dígito Verificador:
1. Multiplica cada um dos 9 primeiros dígitos por pesos de 10 a 2
2. Soma todos os resultados
3. Calcula o resto da divisão por 11
4. Se resto < 2, dígito = 0; senão, dígito = 11 - resto

#### Segundo Dígito Verificador:
1. Multiplica cada um dos 10 primeiros dígitos (incluindo o primeiro verificador) por pesos de 11 a 2
2. Soma todos os resultados
3. Calcula o resto da divisão por 11
4. Se resto < 2, dígito = 0; senão, dígito = 11 - resto

### Exemplo de CPF Gerado:
```
CPF: 294.154.981-10
- Primeiros 9 dígitos: 294154981
- Primeiro dígito verificador: 1
- Segundo dígito verificador: 0
- CPF completo: 29415498110
```

## 🏢 CNPJ (Cadastro Nacional de Pessoa Jurídica)

### Regra de Validação
O CNPJ possui 14 dígitos, sendo os 12 primeiros que identificam a empresa + 2 dígitos verificadores.

### Estrutura do CNPJ:
- 8 primeiros dígitos: número base da empresa
- 4 dígitos seguintes: filial (geralmente 0001)
- 2 últimos dígitos: verificadores

### Algoritmo de Cálculo

#### Primeiro Dígito Verificador:
1. Multiplica cada um dos 12 primeiros dígitos pelos pesos: 5,4,3,2,9,8,7,6,5,4,3,2
2. Soma todos os resultados
3. Calcula o resto da divisão por 11
4. Se resto < 2, dígito = 0; senão, dígito = 11 - resto

#### Segundo Dígito Verificador:
1. Multiplica cada um dos 13 primeiros dígitos (incluindo o primeiro verificador) pelos pesos: 6,5,4,3,2,9,8,7,6,5,4,3,2
2. Soma todos os resultados
3. Calcula o resto da divisão por 11
4. Se resto < 2, dígito = 0; senão, dígito = 11 - resto

### Exemplo de CNPJ Gerado:
```
CNPJ: 65.642.019/0001-87
- Número base: 65642019
- Filial: 0001
- Primeiro dígito verificador: 8
- Segundo dígito verificador: 7
- CNPJ completo: 65642019000187
```

## 🧪 Testando a Validação

### Como executar:
```bash
# Popular doadores com documentos válidos
npm run populate-doadores

# Validar todos os documentos gerados
npm run validate-docs
```

### Resultado Esperado:
```
📊 Resultado da validação:
   ✅ CPFs válidos: 10
   ❌ CPFs inválidos: 0
   ✅ CNPJs válidos: 10
   ❌ CNPJs inválidos: 0
```

## 🔍 Verificação Manual

### Validar CPF manualmente:
```javascript
function validarCPF(cpf) {
  cpf = cpf.replace(/\D/g, '');
  
  if (cpf.length !== 11) return false;
  if (/^(\d)\1{10}$/.test(cpf)) return false; // Todos iguais
  
  // Primeiro dígito
  let soma = 0;
  for (let i = 0; i < 9; i++) {
    soma += parseInt(cpf.charAt(i)) * (10 - i);
  }
  let resto = soma % 11;
  const dig1 = resto < 2 ? 0 : 11 - resto;
  
  // Segundo dígito
  soma = 0;
  for (let i = 0; i < 10; i++) {
    soma += parseInt(cpf.charAt(i)) * (11 - i);
  }
  resto = soma % 11;
  const dig2 = resto < 2 ? 0 : 11 - resto;
  
  return (parseInt(cpf.charAt(9)) === dig1 && parseInt(cpf.charAt(10)) === dig2);
}
```

### Validar CNPJ manualmente:
```javascript
function validarCNPJ(cnpj) {
  cnpj = cnpj.replace(/\D/g, '');
  
  if (cnpj.length !== 14) return false;
  if (/^(\d)\1{13}$/.test(cnpj)) return false; // Todos iguais
  
  const pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  const pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
  
  // Primeiro dígito
  let soma = 0;
  for (let i = 0; i < 12; i++) {
    soma += parseInt(cnpj.charAt(i)) * pesos1[i];
  }
  let resto = soma % 11;
  const dig1 = resto < 2 ? 0 : 11 - resto;
  
  // Segundo dígito
  soma = 0;
  for (let i = 0; i < 13; i++) {
    soma += parseInt(cnpj.charAt(i)) * pesos2[i];
  }
  resto = soma % 11;
  const dig2 = resto < 2 ? 0 : 11 - resto;
  
  return (parseInt(cnpj.charAt(12)) === dig1 && parseInt(cnpj.charAt(13)) === dig2);
}
```

## 📊 Dados Gerados

O sistema gera automaticamente:

### 👤 Pessoa Física (10 doadores)
- CPFs válidos com 11 dígitos
- Nomes brasileiros realistas
- Endereços completos fake
- Telefones e emails

### 🏢 Pessoa Jurídica (10 doadores)  
- CNPJs válidos com 14 dígitos
- Nomes de empresas realistas
- Endereços comerciais fake
- Telefones e emails corporativos

### 🏠 Endereços Fake Incluem:
- **Endereço**: Tipo + Nome + Número (ex: "Rua das Flores, 123")
- **Cidade**: Cidades brasileiras reais
- **Estado**: Siglas de estados válidas (SP, RJ, MG, etc.)
- **CEP**: 8 dígitos aleatórios

## ✅ Vantagens dos Documentos Válidos

1. **Conformidade**: Respeita regras oficiais brasileiras
2. **Testes Realistas**: Dados que passam em validações
3. **Integração**: Funciona com sistemas que validam documentos
4. **Demonstração**: Mostra qualidade do desenvolvimento

## 🔧 Arquivos Relacionados

- `populate-doadores.js` - Gera dados com documentos válidos
- `validar-documentos.js` - Valida todos os documentos
- `src/models/doador.js` - Model com validações
- `src/controllers/doadorController.js` - Endpoints com validação