// Comunicação com o webservice da Sefaz-SP (autorização de NFC-e). Usa https nativo do
// Node (sem lib de SOAP externa) com o certificado como identidade mTLS, que é como a
// Sefaz autentica quem está mandando a nota.
const https = require('https');

const URLS = {
  homologacao: 'homologacao.nfe.fazenda.sp.gov.br',
  producao: 'nfe.fazenda.sp.gov.br',
};

function montarEnvelopeSoap(xmlAssinado, ambiente) {
  return `<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <nfeDadosMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeAutorizacao4">
      <enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="4.00">
        <idLote>${Date.now()}</idLote>
        <indSinc>1</indSinc>
        ${xmlAssinado.replace('<?xml version="1.0" encoding="UTF-8"?>', '')}
      </enviNFe>
    </nfeDadosMsg>
  </soap12:Body>
</soap12:Envelope>`;
}

// ambiente: 'homologacao' | 'producao' · certPem/keyPem: do certificado da padaria.
function enviarNFCe({ xmlAssinado, ambiente, certPem, keyPem }) {
  return new Promise((resolve, reject) => {
    const body = montarEnvelopeSoap(xmlAssinado, ambiente);
    const host = URLS[ambiente];
    const options = {
      hostname: host,
      path: '/ws/NFeAutorizacao4.asmx',
      method: 'POST',
      cert: certPem,
      key: keyPem,
      headers: {
        'Content-Type': 'application/soap+xml; charset=utf-8',
        'Content-Length': Buffer.byteLength(body),
      },
      timeout: 30000,
    };

    const req = https.request(options, (res) => {
      let dados = '';
      res.on('data', (chunk) => { dados += chunk; });
      res.on('end', () => resolve({ statusCode: res.statusCode, corpo: dados }));
    });
    req.on('error', reject);
    req.on('timeout', () => { req.destroy(); reject(new Error('Tempo esgotado esperando resposta da Sefaz.')); });
    req.write(body);
    req.end();
  });
}

// Extrai os campos principais da resposta (protocolo, status, motivo) sem precisar
// de uma lib de parsing XML completa — a resposta da Sefaz é bem previsível.
function interpretarResposta(corpoXml) {
  const pegar = (tag) => {
    const m = corpoXml.match(new RegExp(`<${tag}>([^<]*)</${tag}>`));
    return m ? m[1] : null;
  };
  return {
    cStat: pegar('cStat'),
    xMotivo: pegar('xMotivo'),
    nProt: pegar('nProt'),
    chNFe: pegar('chNFe'),
    dhRecbto: pegar('dhRecbto'),
  };
}

module.exports = { enviarNFCe, interpretarResposta, URLS };
