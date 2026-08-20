// Carrega o certificado digital A1 (.pfx) de uma padaria e extrai o par
// certificado+chave privada pronto pra assinar XML de NFC-e.
//
// O arquivo .pfx NUNCA fica no banco nem no git — só dentro da pasta
// `certificados/` no servidor (fora do repositório, ver .gitignore), com
// permissão de leitura restrita (chmod 600). A senha fica criptografada no
// banco (ver criptografia.js) e só é decifrada em memória, na hora do uso.
const fs = require('fs');
const path = require('path');
const forge = require('node-forge');
const db = require('../database/connection');
const { descriptografar } = require('./criptografia');

const PASTA_CERTIFICADOS = path.join(__dirname, '..', '..', 'certificados');

// Retorna { ok:true, certPem, keyPem, cnpj, validoAte } ou { ok:false, erro }.
// Nunca lança exceção — sempre retorna um objeto, pra quem chama decidir o que fazer.
async function carregarCertificado(padaria_id) {
  try {
    const [[padaria]] = await db.query(
      `SELECT nfce_certificado_arquivo, nfce_certificado_senha_criptografada
       FROM padarias WHERE id = ?`,
      [padaria_id]
    );
    if (!padaria || !padaria.nfce_certificado_arquivo) {
      return { ok: false, erro: 'Nenhum certificado configurado pra essa padaria ainda.' };
    }

    const caminhoArquivo = path.join(PASTA_CERTIFICADOS, padaria.nfce_certificado_arquivo);
    // Trava contra path traversal — o nome do arquivo tem que ficar dentro da pasta certificados/.
    if (!caminhoArquivo.startsWith(PASTA_CERTIFICADOS)) {
      return { ok: false, erro: 'Caminho de certificado inválido.' };
    }
    if (!fs.existsSync(caminhoArquivo)) {
      return { ok: false, erro: `Arquivo do certificado não encontrado no servidor (esperado em certificados/${padaria.nfce_certificado_arquivo}).` };
    }

    const senha = descriptografar(padaria.nfce_certificado_senha_criptografada);
    const pfxBuffer = fs.readFileSync(caminhoArquivo);
    const pfxAsn1 = forge.asn1.fromDer(forge.util.createBuffer(pfxBuffer.toString('binary')));
    const pfx = forge.pkcs12.pkcs12FromAsn1(pfxAsn1, false, senha);

    const bagsChave = pfx.getBags({ bagType: forge.pki.oids.pkcs8ShroudedKeyBag });
    const bagsCert = pfx.getBags({ bagType: forge.pki.oids.certBag });
    const chaveBag = bagsChave[forge.pki.oids.pkcs8ShroudedKeyBag]?.[0];
    const certBag = bagsCert[forge.pki.oids.certBag]?.[0];
    if (!chaveBag || !certBag) {
      return { ok: false, erro: 'Não foi possível ler o certificado — verifique se o arquivo e a senha estão corretos.' };
    }

    const keyPem = forge.pki.privateKeyToPem(chaveBag.key);
    const certPem = forge.pki.certificateToPem(certBag.cert);

    const validoAte = certBag.cert.validity.notAfter;
    const agora = new Date();
    if (validoAte < agora) {
      return { ok: false, erro: `Certificado vencido em ${validoAte.toLocaleDateString('pt-BR')}. Precisa renovar antes de emitir notas.` };
    }

    // Tenta achar o CNPJ dentro do certificado (vem no campo de assunto, formato "NOME:CNPJ")
    const assunto = certBag.cert.subject.getField('CN')?.value || '';
    const matchCnpj = assunto.match(/:(\d{14})$/);

    return {
      ok: true,
      certPem,
      keyPem,
      cnpj: matchCnpj ? matchCnpj[1] : null,
      validoAte,
    };
  } catch (e) {
    // Senha errada costuma cair aqui como erro genérico do forge — deixa a mensagem clara.
    const senhaErrada = /mac verify failure|invalid password|pkcs12/i.test(e.message || '');
    return {
      ok: false,
      erro: senhaErrada
        ? 'Senha do certificado incorreta (ou arquivo corrompido).'
        : `Erro ao carregar certificado: ${e.message}`,
    };
  }
}

module.exports = { carregarCertificado, PASTA_CERTIFICADOS };
