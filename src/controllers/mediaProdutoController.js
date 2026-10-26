// "Média por produto" (Relatórios): quanto um produto vende em média por dia, por dia da
// semana e por horário, num período — mais a sugestão de produção pra amanhã.
// O dia de hoje nunca entra (ainda não acabou — no Saurus isso fazia parecer queda de venda).
// Consumo interno (Padaria) e Cortesia não contam: não são venda.
const db = require('../database/connection');

const FOLGA_PRODUCAO = 0.10; // +10% em cima da média, pra não faltar
const FAIXAS = [ // faixas de horário da sugestão de produção
  { rotulo: 'Até 9h', de: 0, ate: 8 },
  { rotulo: '9h–13h', de: 9, ate: 12 },
  { rotulo: '13h–16h', de: 13, ate: 15 },
  { rotulo: '16h em diante', de: 16, ate: 23 },
];

const ymd = d => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
const paraData = s => { const [a, m, d] = s.split('-').map(Number); return new Date(a, m - 1, d); };
const somaDias = (d, n) => { const x = new Date(d); x.setDate(x.getDate() + n); return x; };

async function vendasDoPeriodo(padaria_id, produto_id, de, ate) {
  const [linhas] = await db.query(
    `SELECT DAYOFWEEK(c.fechada_em) - 1 AS dow, HOUR(c.fechada_em) AS hora,
            SUM(i.quantidade) AS qtd, SUM(i.subtotal) AS valor, COUNT(DISTINCT c.id) AS vendas
     FROM itens_comanda i JOIN comandas c ON c.id = i.comanda_id
     WHERE c.padaria_id = ? AND c.status = 'fechada' AND i.produto_id = ?
       AND DATE(c.fechada_em) BETWEEN ? AND ?
       AND COALESCE(c.forma_pagamento, '') NOT LIKE 'Padaria%' AND COALESCE(c.forma_pagamento, '') NOT LIKE 'Cortesia%'
     GROUP BY dow, hora`,
    [padaria_id, produto_id, de, ate]
  );
  return linhas.map(l => ({ dow: Number(l.dow), hora: Number(l.hora), qtd: parseFloat(l.qtd) || 0, valor: parseFloat(l.valor) || 0, vendas: Number(l.vendas) || 0 }));
}

exports.media = async (req, res) => {
  const padaria_id = req.padaria.id;
  const produto_id = Number(req.query.produto_id);
  if (!produto_id) return res.status(400).json({ erro: 'Escolha um produto.' });
  const [[produto]] = await db.query(
    `SELECT id, nome, unidade, custo_unitario, preco_venda FROM produtos WHERE id = ? AND padaria_id = ?`, [produto_id, padaria_id]);
  if (!produto) return res.status(404).json({ erro: 'Produto não encontrado.' });

  const hoje0 = new Date(); hoje0.setHours(0, 0, 0, 0);
  const ontem = somaDias(hoje0, -1);
  const valida = s => /^\d{4}-\d{2}-\d{2}$/.test(String(s || ''));
  let ate = valida(req.query.ate) ? paraData(req.query.ate) : ontem;
  if (ate > ontem) ate = ontem; // hoje nunca entra
  let de = valida(req.query.de) ? paraData(req.query.de) : somaDias(ate, -29);
  if (de > ate) de = ate;
  const nDias = Math.round((ate - de) / 86400000) + 1;
  if (nDias > 400) return res.status(400).json({ erro: 'Período grande demais (máximo 400 dias).' });

  // Quantas vezes cada dia da semana aparece no período (pra média por dia da semana).
  const ocorrencias = [0, 0, 0, 0, 0, 0, 0];
  for (let d = new Date(de); d <= ate; d = somaDias(d, 1)) ocorrencias[d.getDay()]++;

  const atual = await vendasDoPeriodo(padaria_id, produto_id, ymd(de), ymd(ate));
  const antAte = somaDias(de, -1), antDe = somaDias(antAte, -(nDias - 1));
  const anterior = await vendasDoPeriodo(padaria_id, produto_id, ymd(antDe), ymd(antAte));

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

  const custo = parseFloat(produto.custo_unitario) || 0;
  const precoMedio = qtdTotal ? valorTotal / qtdTotal : 0;
  res.json({
    produto: { id: produto.id, nome: produto.nome, unidade: produto.unidade, custo_unitario: custo, preco_venda: parseFloat(produto.preco_venda) || 0 },
    periodo: { de: ymd(de), ate: ymd(ate), dias: nDias, anterior_de: ymd(antDe), anterior_ate: ymd(antAte) },
    totais: { qtd: qtdTotal, valor: valorTotal, vendas: vendasTotal, media_qtd_dia: qtdTotal / nDias, media_valor_dia: valorTotal / nDias, preco_medio: precoMedio },
    anterior: { qtd: qtdAnt, valor: valorAnt, media_qtd_dia: qtdAnt / nDias, media_valor_dia: valorAnt / nDias },
    margem: custo > 0 && precoMedio > 0 ? (precoMedio - custo) / precoMedio : null,
    por_dia_semana: porDiaSemana,
    por_horario: porHorario,
    sugestao: { dow: amanha, folga: FOLGA_PRODUCAO, total: totalSugerido, faixas },
  });
};
