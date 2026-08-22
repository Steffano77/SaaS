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

// Emissão online (não é modo de contingência) — formato mais simples do QR Code v2:
// chave|versão|ambiente|idCSC, com o hash calculado sobre isso + o CSC.
function montarUrlQrCode({ chave, ambiente, csc, idCsc }) {
  const partes = [chave, '2', String(ambiente), String(idCsc || 1)];
  const p = partes.join('|');
  const cHashQRCode = crypto.createHash('sha1').update(p + (csc || '')).digest('hex').toUpperCase();
  return `${URL_CONSULTA[ambiente]}?p=${p}|${cHashQRCode}`;
}

function montarInfNFeSupl({ chave, ambiente, csc, idCsc }) {
  const qrCode = montarUrlQrCode({ chave, ambiente, csc, idCsc });
  return `
  <infNFeSupl>
    <qrCode><![CDATA[${qrCode}]]></qrCode>
    <urlChave>${URL_CONSULTA[ambiente].replace('/qrcode', '/consulta')}</urlChave>
  </infNFeSupl>`;
}

module.exports = { montarInfNFeSupl, montarUrlQrCode, URL_CONSULTA };
