const db = require('../database/connection');
const fs = require('fs');
const path = require('path');
const { criptografar } = require('../fiscal/criptografia');
const { carregarCertificado, PASTA_CERTIFICADOS } = require('../fiscal/certificado');

// Configura o certificado digital dessa padaria. O arquivo .pfx precisa já estar
// dentro da pasta certificados/ do servidor (subido por SCP/SFTP direto, nunca
// por upload web) — aqui só registramos o nome do arquivo + a senha (criptografada).
exports.configurarCertificado = async (req, res) => {
  try {
    const padaria_id = req.padaria.id;
    const { arquivo, senha } = req.body;
    if (!arquivo || !senha) return res.status(400).json({ erro: 'Informe o nome do arquivo e a senha do certificado.' });

    // Só o nome do arquivo, sem caminho — trava contra path traversal (ex: "../../etc/passwd").
    const nomeArquivo = path.basename(arquivo);
    const caminhoCompleto = path.join(PASTA_CERTIFICADOS, nomeArquivo);
    if (!fs.existsSync(caminhoCompleto)) {
      return res.status(400).json({
        erro: `Arquivo "${nomeArquivo}" não encontrado em certificados/ no servidor. Envie o .pfx por SCP/SFTP direto pra lá primeiro (nunca pelo navegador).`
      });
    }

    const senhaCriptografada = criptografar(senha);
    await db.query(
      `UPDATE padarias SET nfce_certificado_arquivo = ?, nfce_certificado_senha_criptografada = ? WHERE id = ?`,
      [nomeArquivo, senhaCriptografada, padaria_id]
    );

    // Valida na hora — tenta abrir o certificado de verdade com a senha informada.
    const resultado = await carregarCertificado(padaria_id);
    if (!resultado.ok) {
      // Reverte o cadastro se a validação falhar, pra não deixar configuração quebrada salva.
      await db.query(`UPDATE padarias SET nfce_certificado_arquivo = NULL, nfce_certificado_senha_criptografada = NULL WHERE id = ?`, [padaria_id]);
      return res.status(400).json({ erro: resultado.erro });
    }

    res.json({
      ok: true,
      mensagem: 'Certificado validado e configurado com sucesso!',
      cnpj: resultado.cnpj,
      validoAte: resultado.validoAte,
    });
  } catch (e) {
    console.error('Erro ao configurar certificado fiscal:', e);
    res.status(500).json({ erro: 'Erro interno ao configurar certificado.' });
  }
};

// Mostra o status atual (sem nunca devolver a senha)
exports.statusCertificado = async (req, res) => {
  try {
    const padaria_id = req.padaria.id;
    const [[padaria]] = await db.query(
      `SELECT nfce_certificado_arquivo, nfce_ativo, nfce_ambiente FROM padarias WHERE id = ?`,
      [padaria_id]
    );
    if (!padaria?.nfce_certificado_arquivo) {
      return res.json({ configurado: false });
    }
    const resultado = await carregarCertificado(padaria_id);
    res.json({
      configurado: true,
      valido: resultado.ok,
      erro: resultado.ok ? null : resultado.erro,
      cnpj: resultado.cnpj || null,
      validoAte: resultado.validoAte || null,
      ativo: !!padaria.nfce_ativo,
      ambiente: padaria.nfce_ambiente === 1 ? 'producao' : 'homologacao',
    });
  } catch (e) {
    console.error('Erro ao checar status do certificado:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};
