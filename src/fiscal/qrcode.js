// Monta o bloco <infNFeSupl> (QR Code) exigido especificamente na NFC-e (modelo 65) —
// diferente da NF-e comum, que não tem esse bloco. Sem ele a Sefaz rejeita por schema.
//
// IMPORTANTE: o hash do QR Code (cHashQRCode) depende do CSC (Código de Segurança do
// Contribuinte) — um token que NÃO vem no certificado digital, precisa ser gerado
// separado no portal da Sefaz-SP (Portal NFC-e → Credenciamento → CSC). Enquanto não
// tivermos esse valor, o QR Code fica estruturalmente presente mas com hash inválido —
// resolve o erro de schema, mas o QR Code em si só funciona de verdade depois de
// configurar o CSC real.
const crypto = require('crypto');

const URL_CONSULTA = {
  1: 'https://www.nfce.fazenda.sp.gov.br/qrcode',
  2: 'https://www.homologacao.nfce.fazenda.sp.gov.br/qrcode',
};

function montarInfNFeSupl({ chave, ambiente, dhEmi, vNF, digestValue, csc, idCsc }) {
  const dhEmiHex = Math.floor(dhEmi.getTime() / 1000).toString(16);
  const partes = [chave, '100', String(ambiente), '', dhEmiHex, vNF, '0.00', digestValue || '', String(idCsc || 1).padStart(6, '0')];
  const p = partes.join('|');
  const cHashQRCode = crypto.createHash('sha1').update(p + (csc || '')).digest('hex').toUpperCase();
  const qrCode = `${URL_CONSULTA[ambiente]}?p=${p}|${cHashQRCode}`;

  return `
  <infNFeSupl>
    <qrCode><![CDATA[${qrCode}]]></qrCode>
    <urlChave>${URL_CONSULTA[ambiente].replace('/qrcode', '/consulta')}</urlChave>
  </infNFeSupl>`;
}

module.exports = { montarInfNFeSupl };
