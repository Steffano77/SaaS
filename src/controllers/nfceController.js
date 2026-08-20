// Orquestra a emissão de NFC-e: busca a comanda, monta o XML, assina, manda pra
// Sefaz-SP e grava o resultado. Por enquanto só em ambiente de HOMOLOGAÇÃO (teste) —
// não emite nada que valha legalmente ainda, é pra validar o fluxo inteiro com
// segurança antes de ligar pra produção.
const db = require('../database/connection');
const { carregarCertificado } = require('../fiscal/certificado');
const { montarXmlNFCe } = require('../fiscal/xmlNFCe');
const { assinarXmlNFCe } = require('../fiscal/assinatura');
const { enviarNFCe, interpretarResposta } = require('../fiscal/sefazSP');
const { montarInfNFeSupl } = require('../fiscal/qrcode');

exports.emitirParaComanda = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { comanda_id } = req.params;

  try {
    const [[padaria]] = await db.query(`SELECT * FROM padarias WHERE id = ?`, [padaria_id]);
    if (!padaria?.nfce_certificado_arquivo) {
      return res.status(400).json({ erro: 'Certificado digital ainda não configurado pra essa padaria.' });
    }
    if (!padaria.nfce_inscricao_estadual || !padaria.nfce_codigo_municipio_ibge) {
      return res.status(400).json({ erro: 'Dados fiscais (endereço/IE) ainda não configurados.' });
    }

    const cert = await carregarCertificado(padaria_id);
    if (!cert.ok) return res.status(400).json({ erro: cert.erro });
    if (!cert.cnpj) return res.status(400).json({ erro: 'Não consegui ler o CNPJ do certificado.' });

    const [[comanda]] = await db.query(`SELECT * FROM comandas WHERE id = ? AND padaria_id = ?`, [comanda_id, padaria_id]);
    if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
    const [itens] = await db.query(`SELECT * FROM itens_comanda WHERE comanda_id = ?`, [comanda_id]);
    if (!itens.length) return res.status(400).json({ erro: 'Comanda sem itens.' });

    const [pagamentos] = await db.query(`SELECT * FROM comanda_pagamentos WHERE comanda_id = ?`, [comanda_id]);
    if (!pagamentos.length) {
      return res.status(400).json({ erro: 'Comanda ainda não foi paga — feche o pagamento antes de emitir a nota.' });
    }

    const ambienteNum = padaria.nfce_ambiente || 2; // 2 = homologação por padrão, só muda depois de validar
    const numero = padaria.nfce_proximo_numero || 1;

    const { xml, chave, dhEmi } = montarXmlNFCe({
      padaria: { ...padaria, cnpj: cert.cnpj },
      comanda, itens, pagamentos, numero, ambiente: ambienteNum,
    });

    const { xmlAssinado: xmlComAssinatura, digestValue } = assinarXmlNFCe(xml, { certPem: cert.certPem, keyPem: cert.keyPem });

    const vNF = itens.reduce((s, i) => s + parseFloat(i.subtotal), 0) - parseFloat(comanda.desconto || 0) + parseFloat(comanda.acrescimo || 0);
    const infNFeSupl = montarInfNFeSupl({
      chave, ambiente: ambienteNum, dhEmi, vNF: vNF.toFixed(2), digestValue,
      csc: padaria.nfce_csc, idCsc: padaria.nfce_id_csc,
    });
    const xmlAssinado = xmlComAssinatura.replace('</NFe>', `${infNFeSupl}\n</NFe>`);

    const [notaResult] = await db.query(
      `INSERT INTO notas_fiscais (padaria_id, comanda_id, numero, serie, chave_acesso, status, ambiente, valor_total, xml_assinado)
       VALUES (?,?,?,?,?,?,?,?,?)`,
      [padaria_id, comanda_id, numero, padaria.nfce_serie || 1, chave, 'pendente', ambienteNum, comanda.total, xmlAssinado]
    );

    let respostaSefaz;
    try {
      respostaSefaz = await enviarNFCe({
        xmlAssinado,
        ambiente: ambienteNum === 1 ? 'producao' : 'homologacao',
        certPem: cert.certPem,
        keyPem: cert.keyPem,
      });
    } catch (erroRede) {
      await db.query(`UPDATE notas_fiscais SET status = 'erro', motivo_rejeicao = ? WHERE id = ?`,
        [`Erro de rede: ${erroRede.message}`, notaResult.insertId]);
      return res.status(502).json({ erro: `Não consegui falar com a Sefaz: ${erroRede.message}`, xmlGerado: xmlAssinado });
    }

    const interpretado = interpretarResposta(respostaSefaz.corpo);
    // cStat 100 = Autorizado o uso da NF-e (o único "sucesso" de verdade)
    const autorizada = interpretado.cStat === '100';

    await db.query(
      `UPDATE notas_fiscais SET status = ?, protocolo_autorizacao = ?, motivo_rejeicao = ?, autorizada_em = ? WHERE id = ?`,
      [
        autorizada ? 'autorizada' : 'rejeitada',
        interpretado.nProt || null,
        autorizada ? null : `${interpretado.cStat}: ${interpretado.xMotivo}`,
        autorizada ? new Date() : null,
        notaResult.insertId,
      ]
    );

    if (autorizada) {
      await db.query(`UPDATE padarias SET nfce_proximo_numero = nfce_proximo_numero + 1 WHERE id = ?`, [padaria_id]);
    }

    res.json({
      ok: autorizada,
      status: interpretado.cStat,
      motivo: interpretado.xMotivo,
      protocolo: interpretado.nProt,
      chave,
      ambiente: ambienteNum === 1 ? 'produção' : 'homologação (teste, não vale legalmente)',
      respostaCompleta: respostaSefaz.corpo, // útil pra debugar o primeiro teste
    });
  } catch (e) {
    console.error('Erro ao emitir NFC-e:', e);
    res.status(500).json({ erro: `Erro interno ao emitir: ${e.message}` });
  }
};

exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [notas] = await db.query(
    `SELECT id, comanda_id, numero, serie, status, ambiente, valor_total, criado_em, motivo_rejeicao
     FROM notas_fiscais WHERE padaria_id = ? ORDER BY criado_em DESC LIMIT 50`,
    [padaria_id]
  );
  res.json(notas);
};
