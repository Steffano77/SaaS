// Criptografia simétrica (AES-256-GCM) só pra guardar a senha do certificado digital
// no banco sem deixar em texto puro. A chave mestra fica só no .env do servidor,
// nunca no banco nem no git — sem ela, o valor criptografado não serve pra nada.
const crypto = require('crypto');

function obterChave() {
  const chaveHex = process.env.FISCAL_ENC_KEY;
  if (!chaveHex || chaveHex.length !== 64) {
    throw new Error('FISCAL_ENC_KEY não configurada corretamente no .env (precisa ter 64 caracteres hex = 32 bytes).');
  }
  return Buffer.from(chaveHex, 'hex');
}

// Gera uma chave nova (rodar uma vez, colar o resultado no .env como FISCAL_ENC_KEY=...)
function gerarChaveNova() {
  return crypto.randomBytes(32).toString('hex');
}

function criptografar(textoPlano) {
  const chave = obterChave();
  const iv = crypto.randomBytes(12);
  const cipher = crypto.createCipheriv('aes-256-gcm', chave, iv);
  const criptografado = Buffer.concat([cipher.update(textoPlano, 'utf8'), cipher.final()]);
  const tag = cipher.getAuthTag();
  // Formato salvo: iv:tag:conteudo, tudo em base64
  return `${iv.toString('base64')}:${tag.toString('base64')}:${criptografado.toString('base64')}`;
}

function descriptografar(valorCriptografado) {
  const chave = obterChave();
  const [ivB64, tagB64, contB64] = String(valorCriptografado).split(':');
  if (!ivB64 || !tagB64 || !contB64) throw new Error('Valor criptografado em formato inválido.');
  const iv = Buffer.from(ivB64, 'base64');
  const tag = Buffer.from(tagB64, 'base64');
  const conteudo = Buffer.from(contB64, 'base64');
  const decipher = crypto.createDecipheriv('aes-256-gcm', chave, iv);
  decipher.setAuthTag(tag);
  return Buffer.concat([decipher.update(conteudo), decipher.final()]).toString('utf8');
}

module.exports = { criptografar, descriptografar, gerarChaveNova };
