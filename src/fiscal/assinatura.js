// Assina digitalmente o XML da NFC-e usando o certificado da padaria (padrão
// XMLDSig exigido pela Sefaz — assinatura no elemento <infNFe> dentro do <NFe>).
const { SignedXml } = require('xml-crypto');

// certPem/keyPem vêm do certificado.js (carregarCertificado). xml: string do montarXmlNFCe.
// Remove espaços/quebras de linha entre tags (só entre '>' e '<', nunca dentro de
// texto de verdade) — XML com bastante formatação/indentação às vezes confunde o
// processo de assinatura na hora de recompor o documento.
function compactarXml(xml) {
  return xml.replace(/>\s+</g, '><').trim();
}

function assinarXmlNFCe(xmlOriginal, { certPem, keyPem }) {
  const xml = compactarXml(xmlOriginal);
  const idMatch = xml.match(/<infNFe Id="([^"]+)"/);
  if (!idMatch) throw new Error('Não achei o Id do infNFe pra assinar — XML mal formado.');
  const id = idMatch[1];

  const sig = new SignedXml({
    privateKey: keyPem,
    publicCert: certPem,
    getKeyInfoContent: () => `<X509Data><X509Certificate>${certPem.replace(/-----[^-]+-----|\n/g, '')}</X509Certificate></X509Data>`,
  });

  sig.addReference({
    xpath: `//*[@Id='${id}']`,
    transforms: [
      'http://www.w3.org/2000/09/xmldsig#enveloped-signature',
      'http://www.w3.org/TR/2001/REC-xml-c14n-20010315',
    ],
    digestAlgorithm: 'http://www.w3.org/2000/09/xmldsig#sha1',
    uri: `#${id}`,
  });
  sig.signatureAlgorithm = 'http://www.w3.org/2000/09/xmldsig#rsa-sha1';
  sig.canonicalizationAlgorithm = 'http://www.w3.org/TR/2001/REC-xml-c14n-20010315';

  sig.computeSignature(xml, {
    location: { reference: `//*[local-name(.)='infNFe']`, action: 'after' },
  });

  const xmlAssinado = sig.getSignedXml();
  const digestMatch = xmlAssinado.match(/<DigestValue>([^<]+)<\/DigestValue>/);
  return { xmlAssinado, digestValue: digestMatch ? digestMatch[1] : '' };
}

module.exports = { assinarXmlNFCe };
