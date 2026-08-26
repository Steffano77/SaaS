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

// Correção pontual: algumas colunas fiscais não foram criadas na migração automática
// (falhou silenciosamente). Roda de novo aqui, cada uma isolada, e reporta o que faltava.
exports.corrigirColunasFiscais = async (req, res) => {
  const colunas = [
    "ALTER TABLE padarias ADD COLUMN nfce_inscricao_estadual VARCHAR(20) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_regime_tributario TINYINT NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_logradouro VARCHAR(120) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_numero VARCHAR(20) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_bairro VARCHAR(80) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_municipio VARCHAR(80) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_codigo_municipio_ibge VARCHAR(10) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_cep VARCHAR(10) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_uf VARCHAR(2) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_serie INT NOT NULL DEFAULT 1",
    "ALTER TABLE padarias ADD COLUMN nfce_proximo_numero INT NOT NULL DEFAULT 1",
    "ALTER TABLE padarias ADD COLUMN nfce_ambiente TINYINT NOT NULL DEFAULT 2",
    "ALTER TABLE padarias ADD COLUMN nfce_ativo TINYINT(1) NOT NULL DEFAULT 0",
    "ALTER TABLE padarias ADD COLUMN nfce_csc VARCHAR(255) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_id_csc INT NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_razao_social VARCHAR(120) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_csc_producao VARCHAR(255) NULL",
    "ALTER TABLE padarias ADD COLUMN nfce_id_csc_producao INT NULL",
  ];
  const resultado = [];
  for (const sql of colunas) {
    try { await db.query(sql); resultado.push({ sql, ok: true }); }
    catch (e) { resultado.push({ sql, ok: false, erro: e.code === 'ER_DUP_FIELDNAME' ? 'já existia' : e.message }); }
  }
  res.json({ resultado });
};

// Ativa o ambiente de PRODUÇÃO — a partir daqui, toda nota emitida vale
// legalmente de verdade (não é mais teste). Trava de segurança: exige uma
// frase de confirmação exata, digitada manualmente, e confere que tanto o
// certificado quanto o CSC de produção já estão configurados antes de deixar
// trocar — evita ativação sem querer ou incompleta.
exports.ativarProducao = async (req, res) => {
  try {
    const padaria_id = req.padaria.id;
    const { confirmar } = req.body;
    if (confirmar !== 'ATIVAR PRODUCAO') {
      return res.status(400).json({ erro: 'Confirmação inválida. Envie exatamente "ATIVAR PRODUCAO".' });
    }
    const [[padaria]] = await db.query('SELECT * FROM padarias WHERE id = ?', [padaria_id]);
    if (!padaria) return res.status(404).json({ erro: 'Padaria não encontrada.' });
    if (!padaria.nfce_certificado_arquivo) return res.status(400).json({ erro: 'Certificado digital ainda não configurado.' });
    if (!padaria.nfce_csc_producao || !padaria.nfce_id_csc_producao) {
      return res.status(400).json({ erro: 'CSC de produção ainda não configurado.' });
    }
    if (padaria.nfce_ambiente === 1) return res.json({ ok: true, mensagem: 'Já estava em produção.' });

    await db.query('UPDATE padarias SET nfce_ambiente = 1 WHERE id = ?', [padaria_id]);
    res.json({ ok: true, mensagem: 'Ambiente alterado pra PRODUÇÃO. A partir de agora, as notas emitidas valem legalmente.' });
  } catch (e) {
    console.error('Erro ao ativar produção:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

// Salva os dados fiscais da padaria (endereço, IE, regime tributário) — obrigatórios
// pra Sefaz aceitar a nota. Nenhum desses dados é segredo (são públicos, tipo o que
// já está no cartão CNPJ ou no alvará), então não precisa de criptografia.
exports.salvarDadosFiscais = async (req, res) => {
  try {
    const padaria_id = req.padaria.id;
    const {
      inscricao_estadual, regime_tributario, logradouro, numero, bairro,
      municipio, codigo_municipio_ibge, cep, uf, razao_social,
    } = req.body;

    const campos = {
      nfce_inscricao_estadual: inscricao_estadual,
      nfce_regime_tributario: regime_tributario,
      nfce_logradouro: logradouro,
      nfce_numero: numero,
      nfce_bairro: bairro,
      nfce_municipio: municipio,
      nfce_codigo_municipio_ibge: codigo_municipio_ibge,
      nfce_cep: cep,
      nfce_uf: uf,
      nfce_razao_social: razao_social,
    };
    const sets = []; const vals = [];
    for (const [coluna, valor] of Object.entries(campos)) {
      if (valor !== undefined) { sets.push(`${coluna} = ?`); vals.push(valor); }
    }
    if (!sets.length) return res.status(400).json({ erro: 'Nenhum campo enviado.' });
    vals.push(padaria_id);
    await db.query(`UPDATE padarias SET ${sets.join(', ')} WHERE id = ?`, vals);

    res.json({ ok: true, mensagem: 'Dados fiscais salvos com sucesso!' });
  } catch (e) {
    console.error('Erro ao salvar dados fiscais:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

// Configura o CSC (Código de Segurança do Contribuinte) — token separado do
// certificado, gerado no Portal da Sefaz-SP, usado só pra montar/validar o QR Code
// da NFC-e. Funciona tipo senha: nunca fica em texto puro no banco.
exports.configurarCsc = async (req, res) => {
  try {
    const padaria_id = req.padaria.id;
    const { csc, id_csc, ambiente } = req.body;
    if (!csc || !id_csc) return res.status(400).json({ erro: 'Informe o CSC e o idCSC.' });

    // ambiente: 'producao' grava nas colunas separadas de produção, sem mexer
    // no CSC de homologação que os testes de hoje continuam usando.
    const colunaCsc = ambiente === 'producao' ? 'nfce_csc_producao' : 'nfce_csc';
    const colunaIdCsc = ambiente === 'producao' ? 'nfce_id_csc_producao' : 'nfce_id_csc';

    const cscCriptografado = criptografar(csc);
    await db.query(
      `UPDATE padarias SET ${colunaCsc} = ?, ${colunaIdCsc} = ? WHERE id = ?`,
      [cscCriptografado, id_csc, padaria_id]
    );
    res.json({ ok: true, mensagem: `CSC de ${ambiente === 'producao' ? 'produção' : 'homologação'} configurado com sucesso!` });
  } catch (e) {
    console.error('Erro ao configurar CSC:', e);
    res.status(500).json({ erro: 'Erro interno.' });
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
