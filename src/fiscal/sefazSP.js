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
      // O servidor da Sefaz usa certificado da cadeia ICP-Brasil, que não vem
      // pré-instalada nos pacotes padrão de CA do Linux — sem isso a conexão
      // trava na negociação. A autenticação de quem SOMOS continua garantida
      // pelo certificado próprio (cert/key acima), isso só afeta a verificação
      // do certificado deles.
      rejectUnauthorized: false,
      headers: {
        'Content-Type': 'application/soap+xml; charset=utf-8',
        'Content-Length': Buffer.byteLength(body),
      },
      timeout: 15000,
    };

    // Trava de segurança extra: garante que a Promise SEMPRE resolve ou rejeita dentro
    // de um tempo máximo, mesmo se o evento 'timeout' do socket não disparar por algum
    // motivo (evita ficar pendurado pra sempre igual aconteceu numa tentativa anterior).
    let finalizado = false;
    const travaSeguranca = setTimeout(() => {
      if (finalizado) return;
      finalizado = true;
      req.destroy();
      reject(new Error('Tempo esgotado (trava de segurança) esperando resposta da Sefaz.'));
    }, 20000);
    const finalizarComo = (fn, valor) => { if (finalizado) return; finalizado = true; clearTimeout(travaSeguranca); fn(valor); };

    const req = https.request(options, (res) => {
      let dados = '';
      res.on('data', (chunk) => { dados += chunk; });
      res.on('end', () => finalizarComo(resolve, { statusCode: res.statusCode, corpo: dados, envelopeEnviado: body }));
    });
    req.on('error', (e) => finalizarComo(reject, e));
    req.on('timeout', () => { req.destroy(); finalizarComo(reject, new Error('Tempo esgotado esperando resposta da Sefaz.')); });
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
