// Gera a chave de acesso de 44 dígitos da NFC-e (identificador único nacional)
// e o dígito verificador (módulo 11), seguindo o Manual de Orientação do Contribuinte.
function calcularDV(chave43) {
  let soma = 0, peso = 2;
  for (let i = chave43.length - 1; i >= 0; i--) {
    soma += parseInt(chave43[i], 10) * peso;
    peso = peso === 9 ? 2 : peso + 1;
  }
  const resto = soma % 11;
  return resto < 2 ? 0 : 11 - resto;
}

// cUF: código IBGE da UF (SP = 35) · dhEmi: Date da emissão · cnpj: só dígitos
// mod: 65 (NFC-e) · serie, numero: inteiros · tpEmi: 1 (normal) · cNF: 8 dígitos aleatórios
function gerarChaveAcesso({ cUF, dhEmi, cnpj, mod, serie, numero, tpEmi, cNF }) {
  const aamm = String(dhEmi.getFullYear()).slice(2) + String(dhEmi.getMonth() + 1).padStart(2, '0');
  const partes = [
    String(cUF),
    aamm,
    cnpj.padStart(14, '0'),
    String(mod).padStart(2, '0'),
    String(serie).padStart(3, '0'),
    String(numero).padStart(9, '0'),
    String(tpEmi),
    String(cNF).padStart(8, '0'),
  ];
  const chave43 = partes.join('');
  const dv = calcularDV(chave43);
  return chave43 + dv;
}

function gerarCodigoNumerico() {
  return Math.floor(10000000 + Math.random() * 89999999).toString();
}

module.exports = { gerarChaveAcesso, gerarCodigoNumerico, calcularDV };
