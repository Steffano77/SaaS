// Orquestra a emissão de NFC-e: busca a comanda, monta o XML, assina, manda pra
// Sefaz-SP e grava o resultado. Por enquanto só em ambiente de HOMOLOGAÇÃO (teste) —
// não emite nada que valha legalmente ainda, é pra validar o fluxo inteiro com
// segurança antes de ligar pra produção.
const db = require('../database/connection');
const QRCode = require('qrcode');
const { carregarCertificado } = require('../fiscal/certificado');
const { montarXmlNFCe } = require('../fiscal/xmlNFCe');
const { assinarXmlNFCe } = require('../fiscal/assinatura');
const { enviarNFCe, interpretarResposta } = require('../fiscal/sefazSP');
const { montarInfNFeSupl } = require('../fiscal/qrcode');
const { descriptografar } = require('../fiscal/criptografia');

function fmtCnpj(cnpj) {
  const c = String(cnpj || '').replace(/\D/g, '').padStart(14, '0');
  return `${c.slice(0,2)}.${c.slice(2,5)}.${c.slice(5,8)}/${c.slice(8,12)}-${c.slice(12,14)}`;
}
function fmtChave(chave) {
  return String(chave || '').replace(/(\d{4})(?=\d)/g, '$1 ');
}
function fmtMoeda(v) {
  return parseFloat(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
}

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

    // Trava de segurança: se essa comanda já tem uma nota AUTORIZADA, nunca emite outra —
    // cada nota autorizada é um documento fiscal válido de verdade, então emitir de novo
    // criaria duas notas legítimas pra uma venda só (bug real encontrado: cliques repetidos
    // no botão de reemitir numa comanda já corrigida geraram várias notas autorizadas).
    const [[jaAutorizada]] = await db.query(
      `SELECT id, chave_acesso FROM notas_fiscais WHERE comanda_id = ? AND padaria_id = ? AND status = 'autorizada' LIMIT 1`,
      [comanda_id, padaria_id]
    );
    if (jaAutorizada) {
      return res.status(400).json({
        erro: 'Essa comanda já tem uma nota fiscal autorizada — não gera outra.',
        chave_ja_autorizada: jaAutorizada.chave_acesso,
      });
    }

    // Traz o NCM cadastrado no produto (join) — a nota usa ele quando tiver, e só cai
    // no código genérico (dentro do montarXmlNFCe) se o produto não tiver NCM definido.
    const [itens] = await db.query(
      `SELECT ic.*, p.ncm AS ncm_produto, p.origem_producao, p.situacao_icms, p.cest
       FROM itens_comanda ic
       LEFT JOIN produtos p ON p.id = ic.produto_id
       WHERE ic.comanda_id = ?`,
      [comanda_id]
    );
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

    // Ambiente 1 = produção usa o CSC de produção (separado); 2 = homologação usa o de teste.
    const cscBruto = ambienteNum === 1 ? padaria.nfce_csc_producao : padaria.nfce_csc;
    const idCscUsado = ambienteNum === 1 ? padaria.nfce_id_csc_producao : padaria.nfce_id_csc;
    const cscTexto = cscBruto ? descriptografar(cscBruto) : null;
    const infNFeSupl = montarInfNFeSupl({
      chave, ambiente: ambienteNum, csc: cscTexto, idCsc: idCscUsado,
    });
    // Ordem exigida pelo schema oficial: infNFe, infNFeSupl, Signature (nessa ordem) —
    // por isso insere logo depois de </infNFe>, empurrando a assinatura pra depois.
    const xmlAssinado = xmlComAssinatura.replace('</infNFe>', `</infNFe>${infNFeSupl}`);

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
    });
  } catch (e) {
    console.error('Erro ao emitir NFC-e:', e);
    res.status(500).json({ erro: `Erro interno ao emitir: ${e.message}` });
  }
};

// Monta o HTML do DANFE-NFCe (o recibo simplificado que sai na impressora térmica,
// com QR Code, chave de acesso e protocolo) pra imprimir depois que a nota foi autorizada.
exports.imprimirDanfe = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { comanda_id } = req.params;
  try {
    const [[padaria]] = await db.query(`SELECT * FROM padarias WHERE id = ?`, [padaria_id]);
    const [[nota]] = await db.query(
      `SELECT * FROM notas_fiscais WHERE comanda_id = ? AND padaria_id = ? AND status = 'autorizada' ORDER BY id DESC LIMIT 1`,
      [comanda_id, padaria_id]
    );
    if (!nota) return res.status(404).json({ erro: 'Nenhuma nota fiscal autorizada encontrada pra essa comanda.' });

    const [itens] = await db.query(`SELECT * FROM itens_comanda WHERE comanda_id = ?`, [comanda_id]);
    const [pagamentos] = await db.query(`SELECT * FROM comanda_pagamentos WHERE comanda_id = ?`, [comanda_id]);

    // Usa o CSC do ambiente em que a nota foi realmente emitida (nota.ambiente),
    // não o ambiente atual da padaria — senão uma nota velha de homologação
    // ficaria com QR Code errado se a padaria já tiver migrado pra produção.
    const cscBruto = nota.ambiente === 1 ? padaria.nfce_csc_producao : padaria.nfce_csc;
    const idCscUsado = nota.ambiente === 1 ? padaria.nfce_id_csc_producao : padaria.nfce_id_csc;
    const cscTexto = cscBruto ? descriptografar(cscBruto) : null;
    const { montarUrlQrCode, URL_CONSULTA } = require('../fiscal/qrcode');
    const qrUrl = montarUrlQrCode({
      chave: nota.chave_acesso, ambiente: nota.ambiente, csc: cscTexto, idCsc: idCscUsado,
    });
    // montarUrlQrCode já devolve a URL completa (com https://) — não duplicar aqui,
    // senão vira "https://https://..." e o QR Code aponta pra um endereço inválido
    // (bug real, achado escaneando o QR de uma nota de produção de verdade).
    const qrImgDataUrl = await QRCode.toDataURL(qrUrl, { margin: 1, width: 220 });

    const itensHtml = itens.map((i, idx) => {
      const cod = String(i.produto_id || '').padStart(3, '0');
      const qtd = parseFloat(i.quantidade).toLocaleString('pt-BR', { minimumFractionDigits: 3 });
      return `<div class="danfe-item-linha1">${String(idx + 1).padStart(3, '0')} ${cod} ${i.nome_produto}</div>
        <div class="danfe-linha danfe-item-linha2">
          <span>${qtd} ${i.unidade} x ${fmtMoeda(i.preco_unitario)}</span>
          <span>${fmtMoeda(i.subtotal)}</span>
        </div>`;
    }).join('');

    // Mostra o valor de cada forma separada (não só o nome) quando teve mais de uma —
    // ajuda a conferir na hora se bateu certo o que foi recebido em dinheiro/cartão/pix.
    // Quando teve troco (pagamento em dinheiro), mostra também quanto o cliente deu
    // e quanto voltou de troco — ajuda a conferir o caixa depois.
    const linhaPagamento = (p) => {
      const troco = parseFloat(p.troco) || 0;
      const base = pagamentos.length > 1
        ? `<div class="danfe-linha"><span>${p.forma_pagamento}</span><span>${fmtMoeda(p.valor)}</span></div>`
        : `<div class="danfe-linha"><span>Forma Pagamento</span><span>${p.forma_pagamento}</span></div>`;
      if (troco <= 0) return base;
      const valorRecebido = parseFloat(p.valor) + troco;
      return base + `
        <div class="danfe-linha"><span>Valor Recebido</span><span>${fmtMoeda(valorRecebido)}</span></div>
        <div class="danfe-linha"><strong>Troco</strong><strong>${fmtMoeda(troco)}</strong></div>`;
    };
    const pagamentosHtml = pagamentos.map(linhaPagamento).join('');

    const homolog = Number(nota.ambiente) === 2
      ? `<div class="danfe-homolog">EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO<br/>SEM VALOR FISCAL</div>` : '';

    const html = `<!doctype html><html><head><meta charset="utf-8"><title>DANFE NFC-e</title>
      <style>
        @page { margin: 0; }
        body { font-family: 'Courier New', monospace; font-size: 11px; width: 80mm; margin: 0 auto; padding: 8px; color:#000; }
        .danfe-center { text-align: center; }
        .danfe-linha { display:flex; justify-content:space-between; }
        .danfe-hr { border-top: 1px dashed #000; margin: 6px 0; }
        .danfe-item-linha1 { margin-top: 4px; }
        .danfe-item-linha2 { padding-left: 10px; color:#333; }
        .danfe-homolog { text-align:center; font-weight:bold; border:1px solid #000; padding:4px; margin:6px 0; }
        .danfe-titulo { text-align:center; font-weight:bold; margin: 6px 0; }
        .danfe-aviso { text-align:center; font-size: 10px; margin: 4px 0; }
        .danfe-chave { text-align:center; font-size:11px; word-break: break-all; margin: 4px 0; letter-spacing: 1px; }
        img { display:block; margin: 8px auto; }
        strong { font-weight: bold; }
        @media print { body { width: 80mm; } }
      </style></head>
      <body onload="window.print(); window.onafterprint = () => window.close(); setTimeout(() => window.close(), 2000);">
        <div class="danfe-center"><strong>${(padaria.nfce_razao_social || padaria.nome || '').toUpperCase()}</strong></div>
        <div class="danfe-center">${padaria.nfce_logradouro || ''}, ${padaria.nfce_numero || ''} ${padaria.nfce_bairro || ''}</div>
        <div class="danfe-center">${padaria.nfce_municipio || ''}/${padaria.nfce_uf || ''}</div>
        <div class="danfe-center">CNPJ: ${fmtCnpj(String(nota.chave_acesso || '').slice(6, 20))}</div>
        <div class="danfe-center">Inscricao Estadual: ${padaria.nfce_inscricao_estadual || ''}</div>
        <div class="danfe-hr"></div>
        <div class="danfe-titulo">DANFE NFC-e Documento Auxiliar de Nota Fiscal Eletronica<br/>para Consumidor Final</div>
        <div class="danfe-aviso">NFC-e não permite aproveitamento de crédito de ICMS</div>
        ${homolog}
        <div class="danfe-hr"></div>
        ${itensHtml}
        <div class="danfe-hr"></div>
        <div class="danfe-linha"><span>Qtd. Itens</span><span>${itens.length}</span></div>
        <div class="danfe-linha"><strong>Valor Total R$</strong><strong>${fmtMoeda(nota.valor_total)}</strong></div>
        ${pagamentosHtml}
        <div class="danfe-hr"></div>
        <div class="danfe-center">Numero: ${nota.numero}  Série: ${nota.serie}</div>
        <div class="danfe-center">${nota.autorizada_em ? new Date(nota.autorizada_em).toLocaleString('pt-BR') : ''}</div>
        <div class="danfe-center">Via Consumidor</div>
        <div class="danfe-hr"></div>
        <div class="danfe-center">CHAVE DE ACESSO</div>
        <div class="danfe-chave">${fmtChave(nota.chave_acesso)}</div>
        <img src="${qrImgDataUrl}" width="180" height="180"/>
        <div class="danfe-center">Consulte pela Chave de Acesso em<br/>${URL_CONSULTA[nota.ambiente].replace('/qrcode', '/consulta')}</div>
        <div class="danfe-center" style="margin-top:6px;">Protocolo de Autorização: ${nota.protocolo_autorizacao || ''}</div>
      </body></html>`;

    res.json({ ok: true, html });
  } catch (e) {
    console.error('Erro ao montar DANFE-NFCe:', e);
    res.status(500).json({ erro: 'Erro interno ao montar o recibo da nota fiscal.' });
  }
};

exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [notas] = await db.query(
    `SELECT id, comanda_id, numero, serie, status, ambiente, valor_total, criado_em, motivo_rejeicao,
       chave_acesso, protocolo_autorizacao, autorizada_em
     FROM notas_fiscais WHERE padaria_id = ? ORDER BY criado_em DESC LIMIT 50`,
    [padaria_id]
  );
  res.json(notas);
};

// ── Contingência: notas que falharam por falta de conexão/Sefaz fora do ar ──
// Fica registrado (status 'erro' ou presas em 'pendente') com o XML já assinado
// salvo — reenviar não gera nota nova, só tenta transmitir a mesma nota de novo.
exports.listarPendentes = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [notas] = await db.query(
    `SELECT n.id, n.comanda_id, n.numero, n.serie, n.status, n.ambiente, n.valor_total, n.criado_em, n.motivo_rejeicao,
       c.identificador AS comanda_identificador
     FROM notas_fiscais n
     LEFT JOIN comandas c ON c.id = n.comanda_id
     WHERE n.padaria_id = ? AND n.status IN ('erro', 'pendente', 'rejeitada', 'contingencia')
       -- Se essa comanda já tem uma nota autorizada (ex: foi reemitida corrigida com
       -- sucesso depois), a tentativa antiga rejeitada não conta mais como pendente —
       -- sem isso, notas já resolvidas continuavam aparecendo pra sempre na lista.
       AND NOT EXISTS (
         SELECT 1 FROM notas_fiscais n2
         WHERE n2.comanda_id = n.comanda_id AND n2.status = 'autorizada'
       )
     ORDER BY n.criado_em ASC`,
    [padaria_id]
  );
  res.json(notas);
};

// Notas de homologação (teste) nunca vão valer nada de verdade — em vez de apagar o
// histórico, só marca como "arquivada" pra sumir da lista de pendentes.
exports.arquivarHomologacao = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [result] = await db.query(
    `UPDATE notas_fiscais SET status = 'arquivada'
     WHERE padaria_id = ? AND ambiente = 2 AND status IN ('erro', 'pendente', 'rejeitada', 'contingencia')`,
    [padaria_id]
  );
  res.json({ ok: true, arquivadas: result.affectedRows });
};

exports.reenviar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { id } = req.params;
  try {
    const [[nota]] = await db.query(`SELECT * FROM notas_fiscais WHERE id = ? AND padaria_id = ?`, [id, padaria_id]);
    if (!nota) return res.status(404).json({ erro: 'Nota não encontrada.' });
    if (nota.status === 'autorizada') return res.status(400).json({ erro: 'Essa nota já foi autorizada — nada a fazer.' });
    if (!nota.xml_assinado) return res.status(400).json({ erro: 'Essa nota não tem XML assinado salvo — não dá pra reenviar, precisa emitir uma nova.' });

    const cert = await carregarCertificado(padaria_id);
    if (!cert.ok) return res.status(400).json({ erro: cert.erro });

    let respostaSefaz;
    try {
      respostaSefaz = await enviarNFCe({
        xmlAssinado: nota.xml_assinado,
        ambiente: nota.ambiente === 1 ? 'producao' : 'homologacao',
        certPem: cert.certPem,
        keyPem: cert.keyPem,
      });
    } catch (erroRede) {
      await db.query(`UPDATE notas_fiscais SET status = 'erro', motivo_rejeicao = ? WHERE id = ?`,
        [`Erro de rede: ${erroRede.message}`, nota.id]);
      return res.status(502).json({ erro: `Ainda sem conseguir falar com a Sefaz: ${erroRede.message}` });
    }

    const interpretado = interpretarResposta(respostaSefaz.corpo);
    const autorizada = interpretado.cStat === '100';

    await db.query(
      `UPDATE notas_fiscais SET status = ?, protocolo_autorizacao = ?, motivo_rejeicao = ?, autorizada_em = ? WHERE id = ?`,
      [
        autorizada ? 'autorizada' : 'rejeitada',
        interpretado.nProt || null,
        autorizada ? null : `${interpretado.cStat}: ${interpretado.xMotivo}`,
        autorizada ? new Date() : null,
        nota.id,
      ]
    );

    // Só avança o número se ninguém mais usou esse número entretanto — evita
    // "roubar" um número que já tenha sido consumido por outra nota emitida
    // enquanto esta ficava pendente.
    if (autorizada) {
      await db.query(
        `UPDATE padarias SET nfce_proximo_numero = nfce_proximo_numero + 1 WHERE id = ? AND nfce_proximo_numero = ?`,
        [padaria_id, nota.numero]
      );
    }

    res.json({ ok: autorizada, status: interpretado.cStat, motivo: interpretado.xMotivo, protocolo: interpretado.nProt });
  } catch (e) {
    console.error('Erro ao reenviar NFC-e:', e);
    res.status(500).json({ erro: `Erro interno ao reenviar: ${e.message}` });
  }
};
