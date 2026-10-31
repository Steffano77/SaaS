// "Média por produto" (Relatórios): quanto um produto — ou uma categoria inteira de
// produtos (ex: "Almoço") — vende em média por dia, por dia da semana e por horário,
// num período — mais a sugestão de produção pra amanhã e exportação em PDF.
// O dia de hoje nunca entra (ainda não acabou — no Saurus isso fazia parecer queda de venda).
// Consumo interno (Padaria) e Cortesia não contam: não são venda.
const db = require('../database/connection');
const PDFDocument = require('pdfkit');

const FOLGA_PRODUCAO = 0.10; // +10% em cima da média, pra não faltar
const FAIXAS = [ // faixas de horário da sugestão de produção
  { rotulo: 'Até 9h', de: 0, ate: 8 },
  { rotulo: '9h–13h', de: 9, ate: 12 },
  { rotulo: '13h–16h', de: 13, ate: 15 },
  { rotulo: '16h em diante', de: 16, ate: 23 },
];
const MP_DIAS = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
const MP_ORDEM = [1, 2, 3, 4, 5, 6, 0]; // mostra de segunda a domingo

const ymd = d => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
const paraData = s => { const [a, m, d] = s.split('-').map(Number); return new Date(a, m - 1, d); };
const somaDias = (d, n) => { const x = new Date(d); x.setDate(x.getDate() + n); return x; };

async function vendasDoPeriodo(padaria_id, filtro, de, ate) {
  const condFiltro = filtro.produto_id ? 'i.produto_id = ?' : 'p.categoria_id = ?';
  const valorFiltro = filtro.produto_id || filtro.categoria_id;
  const [linhas] = await db.query(
    `SELECT DAYOFWEEK(c.fechada_em) - 1 AS dow, HOUR(c.fechada_em) AS hora,
            SUM(i.quantidade) AS qtd, SUM(i.subtotal) AS valor, COUNT(DISTINCT c.id) AS vendas
     FROM itens_comanda i
     JOIN comandas c ON c.id = i.comanda_id
     JOIN produtos p ON p.id = i.produto_id
     WHERE c.padaria_id = ? AND c.status = 'fechada' AND ${condFiltro}
       AND DATE(c.fechada_em) BETWEEN ? AND ?
       AND COALESCE(c.forma_pagamento, '') NOT LIKE 'Padaria%' AND COALESCE(c.forma_pagamento, '') NOT LIKE 'Cortesia%'
     GROUP BY dow, hora`,
    [padaria_id, valorFiltro, de, ate]
  );
  return linhas.map(l => ({ dow: Number(l.dow), hora: Number(l.hora), qtd: parseFloat(l.qtd) || 0, valor: parseFloat(l.valor) || 0, vendas: Number(l.vendas) || 0 }));
}

// Monta o relatório inteiro (produto único OU categoria) — usado tanto pela tela
// (JSON) quanto pelo PDF, pra nunca ficar duas contas desencontradas.
async function montarRelatorio(padaria_id, query) {
  const produto_id = Number(query.produto_id) || null;
  const categoria_id = Number(query.categoria_id) || null;
  if (!produto_id && !categoria_id) { const e = new Error('Escolha um produto ou categoria.'); e.status = 400; throw e; }

  let alvo;
  if (produto_id) {
    const [[produto]] = await db.query(
      `SELECT id, nome, unidade, custo_unitario, preco_venda FROM produtos WHERE id = ? AND padaria_id = ?`, [produto_id, padaria_id]);
    if (!produto) { const e = new Error('Produto não encontrado.'); e.status = 404; throw e; }
    alvo = { tipo: 'produto', produto_id, nome: produto.nome, unidade: produto.unidade, custo_unitario: parseFloat(produto.custo_unitario) || 0, preco_venda: parseFloat(produto.preco_venda) || 0 };
  } else {
    const [[categoria]] = await db.query(`SELECT id, nome FROM categorias WHERE id = ? AND padaria_id = ?`, [categoria_id, padaria_id]);
    if (!categoria) { const e = new Error('Categoria não encontrada.'); e.status = 404; throw e; }
    alvo = { tipo: 'categoria', categoria_id, nome: categoria.nome, unidade: 'un', custo_unitario: 0, preco_venda: 0 };
  }

  const hoje0 = new Date(); hoje0.setHours(0, 0, 0, 0);
  const ontem = somaDias(hoje0, -1);
  const valida = s => /^\d{4}-\d{2}-\d{2}$/.test(String(s || ''));
  let ate = valida(query.ate) ? paraData(query.ate) : ontem;
  if (ate > ontem) ate = ontem; // hoje nunca entra
  let de = valida(query.de) ? paraData(query.de) : somaDias(ate, -29);
  if (de > ate) de = ate;
  const nDias = Math.round((ate - de) / 86400000) + 1;
  if (nDias > 400) { const e = new Error('Período grande demais (máximo 400 dias).'); e.status = 400; throw e; }

  const filtro = produto_id ? { produto_id } : { categoria_id };

  // Quantas vezes cada dia da semana aparece no período (pra média por dia da semana).
  const ocorrencias = [0, 0, 0, 0, 0, 0, 0];
  for (let d = new Date(de); d <= ate; d = somaDias(d, 1)) ocorrencias[d.getDay()]++;

  const atual = await vendasDoPeriodo(padaria_id, filtro, ymd(de), ymd(ate));
  const antAte = somaDias(de, -1), antDe = somaDias(antAte, -(nDias - 1));
  const anterior = await vendasDoPeriodo(padaria_id, filtro, ymd(antDe), ymd(antAte));

  const soma = (ls, k) => ls.reduce((s, l) => s + l[k], 0);
  const qtdTotal = soma(atual, 'qtd'), valorTotal = soma(atual, 'valor'), vendasTotal = soma(atual, 'vendas');
  const qtdAnt = soma(anterior, 'qtd'), valorAnt = soma(anterior, 'valor');

  const porDiaSemana = [0, 1, 2, 3, 4, 5, 6].map(dow => {
    const q = atual.filter(l => l.dow === dow).reduce((s, l) => s + l.qtd, 0);
    return { dow, media: ocorrencias[dow] ? q / ocorrencias[dow] : 0, dias: ocorrencias[dow] };
  });
  const porHorario = [0, 1, 2, 3, 4, 5, 6].map(dow => {
    const horas = {};
    for (const l of atual.filter(x => x.dow === dow)) horas[l.hora] = (horas[l.hora] || 0) + l.qtd;
    for (const h of Object.keys(horas)) horas[h] = ocorrencias[dow] ? horas[h] / ocorrencias[dow] : 0;
    return { dow, horas };
  });

  // Sugestão pra amanhã: média do mesmo dia da semana + folga, dividida por faixa de horário
  // na mesma proporção em que esse dia costuma vender.
  const amanha = somaDias(hoje0, 1).getDay();
  const hAmanha = porHorario[amanha].horas;
  const somaAmanha = Object.values(hAmanha).reduce((s, v) => s + v, 0);
  const totalSugerido = porDiaSemana[amanha].media * (1 + FOLGA_PRODUCAO);
  const faixas = FAIXAS.map(f => {
    let q = 0; for (const [h, v] of Object.entries(hAmanha)) if (Number(h) >= f.de && Number(h) <= f.ate) q += v;
    return { rotulo: f.rotulo, qtd: somaAmanha ? totalSugerido * (q / somaAmanha) : 0 };
  });

  const custo = alvo.custo_unitario;
  const precoMedio = qtdTotal ? valorTotal / qtdTotal : 0;
  return {
    alvo,
    produto: { id: alvo.produto_id || null, nome: alvo.nome, unidade: alvo.unidade, custo_unitario: custo, preco_venda: alvo.preco_venda },
    periodo: { de: ymd(de), ate: ymd(ate), dias: nDias, anterior_de: ymd(antDe), anterior_ate: ymd(antAte) },
    totais: { qtd: qtdTotal, valor: valorTotal, vendas: vendasTotal, media_qtd_dia: qtdTotal / nDias, media_valor_dia: valorTotal / nDias, preco_medio: precoMedio },
    anterior: { qtd: qtdAnt, valor: valorAnt, media_qtd_dia: qtdAnt / nDias, media_valor_dia: valorAnt / nDias },
    margem: alvo.tipo === 'produto' && custo > 0 && precoMedio > 0 ? (precoMedio - custo) / precoMedio : null,
    por_dia_semana: porDiaSemana,
    por_horario: porHorario,
    sugestao: { dow: amanha, folga: FOLGA_PRODUCAO, total: totalSugerido, faixas },
  };
}

exports.media = async (req, res) => {
  try {
    const r = await montarRelatorio(req.padaria.id, req.query);
    res.json(r);
  } catch (e) {
    res.status(e.status || 500).json({ erro: e.message });
  }
};

exports.mediaPdf = async (req, res) => {
  let r;
  try {
    r = await montarRelatorio(req.padaria.id, req.query);
  } catch (e) {
    return res.status(e.status || 500).json({ erro: e.message });
  }

  const un = String(r.produto.unidade || 'un').toLowerCase();
  const q = v => `${(v || 0).toLocaleString('pt-BR', { minimumFractionDigits: 1, maximumFractionDigits: 1 })} ${un}`;
  const moeda = v => 'R$ ' + Number(v || 0).toFixed(2).replace('.', ',');
  const dataBR = s => { const [a, m, d] = s.split('-'); return `${d}/${m}/${a}`; };

  const nomeArquivo = `media-${r.alvo.tipo}-${r.alvo.nome.replace(/[^a-z0-9]+/gi, '-').toLowerCase()}.pdf`;
  res.setHeader('Content-Type', 'application/pdf');
  res.setHeader('Content-Disposition', `attachment; filename="${nomeArquivo}"`);

  const doc = new PDFDocument({ margin: 50, size: 'A4' });
  doc.pipe(res);

  const rotulo = r.alvo.tipo === 'categoria' ? 'Categoria' : 'Produto';
  doc.fontSize(18).font('Helvetica-Bold').text(`Média por Produto — ${rotulo}: ${r.alvo.nome}`, { align: 'center' });
  doc.fontSize(11).font('Helvetica').fillColor('#555')
    .text(`Período: ${dataBR(r.periodo.de)} até ${dataBR(r.periodo.ate)} (${r.periodo.dias} dias)`, { align: 'center' });
  doc.moveDown(1.2);
  doc.fillColor('#000');

  if (!r.totais.qtd) {
    doc.fontSize(12).text(`Sem vendas de ${r.alvo.nome} nesse período.`, { align: 'center' });
    doc.end();
    return;
  }

  // KPIs
  doc.fontSize(13).font('Helvetica-Bold').text('Resumo do período');
  doc.moveDown(0.3);
  doc.fontSize(10).font('Helvetica');
  const kpis = [
    [`Média por dia: ${q(r.totais.media_qtd_dia)}`, `Faturamento médio/dia: ${moeda(r.totais.media_valor_dia)}`],
    [`Total no período: ${q(r.totais.qtd)}`, `Preço médio: ${moeda(r.totais.preco_medio)}`],
    [`Vendas (comandas): ${r.totais.vendas}`, r.margem != null ? `Margem: ${Math.round(r.margem * 100)}%` : ''],
  ];
  for (const [a, b] of kpis) {
    doc.text(a, 50, doc.y, { continued: false });
    if (b) doc.text(b, 300, doc.y - doc.currentLineHeight());
    doc.moveDown(0.3);
  }
  doc.moveDown(0.6);

  // Média por dia da semana
  doc.fontSize(13).font('Helvetica-Bold').text('Média por dia da semana');
  doc.moveDown(0.3);
  doc.fontSize(10).font('Helvetica');
  const linhaDias = MP_ORDEM.map(dow => `${MP_DIAS[dow]}: ${q(r.por_dia_semana[dow].media)}`).join('   |   ');
  doc.text(linhaDias, { width: 495 });
  doc.moveDown(0.8);

  // Sugestão de produção
  doc.fontSize(13).font('Helvetica-Bold').text(`Sugestão de produção pra amanhã (${MP_DIAS[r.sugestao.dow]})`);
  doc.moveDown(0.3);
  doc.fontSize(10).font('Helvetica').text(`Total sugerido: ${q(r.sugestao.total)} (média + 10% de folga)`);
  doc.moveDown(0.2);
  for (const f of r.sugestao.faixas) doc.text(`${f.rotulo}: ${q(f.qtd)}`);
  doc.moveDown(0.8);

  // Média por horário
  if (doc.y > 600) doc.addPage();
  doc.fontSize(13).font('Helvetica-Bold').text('Média por horário (unidade)');
  doc.moveDown(0.3);
  doc.fontSize(9).font('Helvetica');
  for (const dow of MP_ORDEM) {
    const horas = r.por_horario[dow].horas;
    const partes = Object.keys(horas).length
      ? Object.entries(horas).sort((a, b) => Number(a[0]) - Number(b[0])).map(([h, v]) => `${h}h: ${v.toLocaleString('pt-BR', { minimumFractionDigits: 1, maximumFractionDigits: 1 })}`).join('  ')
      : '—';
    if (doc.y > 720) doc.addPage();
    doc.font('Helvetica-Bold').text(`${MP_DIAS[dow]}: `, { continued: true }).font('Helvetica').text(partes);
    doc.moveDown(0.15);
  }

  doc.end();
};
