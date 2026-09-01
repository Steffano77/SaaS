const bcrypt = require('bcryptjs');
const db = require('../database/connection');

// Lista todos os caixas abertos da padaria (pode haver mais de um — um por tablet/aparelho)
exports.abertos = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'aberto' ORDER BY aberto_em`,
    [padaria_id]
  );
  res.json(caixas);
};

// Detalhe de um caixa específico (com resumo), usado pelo tablet que já sabe qual é o seu
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado.' });
  const resumo = await montarResumoCaixa(caixa);
  res.json({ ...caixa, resumo });
};

// Histórico de caixas já fechados
exports.historico = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'fechado' ORDER BY fechado_em DESC LIMIT 30`,
    [padaria_id]
  );
  res.json(caixas);
};

// Pausa o caixa (a pessoa saiu pro intervalo) — trava a venda até alguém retomar.
exports.pausar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(`SELECT atendente FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]);
  await db.query(
    `UPDATE caixas SET pausado = 1, pausado_por = ? WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [caixa?.atendente || null, req.params.id, padaria_id]
  );
  res.json({ ok: true });
};

// Retoma o caixa — exige login de atendente (papel caixa ou gerente), via o middleware
// exigirFuncionario aplicado na rota. Pode ser a mesma pessoa ou outra, tanto faz —
// o que importa é confirmar que é alguém autorizado a mexer no caixa.
exports.retomar = async (req, res) => {
  const padaria_id = req.padaria.id;
  await db.query(
    `UPDATE caixas SET pausado = 0, pausado_por = NULL WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [req.params.id, padaria_id]
  );
  res.json({ ok: true, retomado_por: req.funcionario?.nome || null });
};

exports.abrir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_abertura, atendente_id, pin, observacao } = req.body;
  const nome = String(req.body.nome || '').trim() || 'Caixa 1';

  let atendenteNome = null;
  if (atendente_id) {
    const [[atendente]] = await db.query(
      `SELECT id, nome, pin_hash FROM atendentes WHERE id = ? AND padaria_id = ? AND ativo = 1`,
      [atendente_id, padaria_id]
    );
    if (!atendente) return res.status(404).json({ erro: 'Atendente não encontrado.' });
    if (atendente.pin_hash) {
      const ok = await bcrypt.compare(String(pin || ''), atendente.pin_hash);
      if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
    }
    atendenteNome = atendente.nome;
  }

  const [r] = await db.query(
    `INSERT INTO caixas (padaria_id, nome, atendente, valor_abertura, observacao) VALUES (?,?,?,?,?)`,
    [padaria_id, nome, atendenteNome, parseFloat(valor_abertura) || 0, observacao || null]
  );
  res.status(201).json({ id: r.insertId, nome, atendente: atendenteNome });
};

async function montarResumoCaixa(caixa) {
  const [porForma] = await db.query(
    `SELECT cp.forma_pagamento, COUNT(*) AS qtd, COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ?
     GROUP BY cp.forma_pagamento`,
    [caixa.id]
  );
  // "Padaria" (consumo interno) e "Cortesia" não são receita de verdade — exclui do
  // Total Vendido pra bater exatamente com o Financeiro (mesma regra de lá), evitando
  // dois números diferentes de "total vendido" pro mesmo turno.
  const [[totalVendas]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ? AND cp.forma_pagamento NOT IN ('Padaria', 'Cortesia')`,
    [caixa.id]
  );
  const [[totalDinheiro]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ? AND cp.forma_pagamento = 'Dinheiro'`,
    [caixa.id]
  );
  const [movimentos] = await db.query(
    `SELECT * FROM caixa_movimentos WHERE caixa_id = ? ORDER BY criado_em`, [caixa.id]
  );
  const totalSangrias = movimentos.filter(m => m.tipo === 'sangria').reduce((s, m) => s + parseFloat(m.valor), 0);
  const totalSuprimentos = movimentos.filter(m => m.tipo === 'suprimento').reduce((s, m) => s + parseFloat(m.valor), 0);
  // Despesas — sangria com motivo detalhado, lançada pela atendente na hora de fechar.
  // Sai da gaveta igual sangria, mas fica listada uma a uma no relatório (não só o total).
  const despesas = movimentos.filter(m => m.tipo === 'despesa');
  const totalDespesas = despesas.reduce((s, m) => s + parseFloat(m.valor), 0);

  const [[ajustes]] = await db.query(
    `SELECT COALESCE(SUM(desconto), 0) AS totalDescontos, COALESCE(SUM(acrescimo), 0) AS totalAcrescimos
     FROM comandas WHERE caixa_id = ? AND status = 'fechada'`,
    [caixa.id]
  );

  // Contagem de vendas (comandas fechadas nesse caixa) e total de itens vendidos —
  // igual ao "Qtd. Vendas" e "Total Itens" do relatório de fechamento do Saurus.
  const [[contagem]] = await db.query(
    `SELECT COUNT(DISTINCT c.id) AS qtdVendas, COALESCE(SUM(i.quantidade), 0) AS totalItens
     FROM comandas c
     LEFT JOIN itens_comanda i ON i.comanda_id = c.id
     WHERE c.caixa_id = ? AND c.status = 'fechada'`,
    [caixa.id]
  );

  const esperadoEmDinheiro = parseFloat(caixa.valor_abertura) + parseFloat(totalDinheiro.total)
    + totalSuprimentos - totalSangrias - totalDespesas;

  return {
    porForma,
    totalVendas: parseFloat(totalVendas.total),
    totalDinheiro: parseFloat(totalDinheiro.total),
    totalDescontos: parseFloat(ajustes.totalDescontos),
    totalAcrescimos: parseFloat(ajustes.totalAcrescimos),
    totalSangrias, totalSuprimentos,
    totalDespesas,
    despesas: despesas.map(d => ({ descricao: d.observacao || '(sem descrição)', valor: parseFloat(d.valor) })),
    movimentos,
    esperadoEmDinheiro,
    qtdVendas: contagem.qtdVendas,
    totalItens: parseFloat(contagem.totalItens),
  };
}

// Conferência por forma de pagamento: pra cada forma que teve movimento (mais
// "Dinheiro" sempre, mesmo sem venda, porque a gaveta sempre tem o troco de
// abertura pra conferir), calcula quanto o sistema lançou ("em caixa") e compara
// com o que a atendente digitou que contou/bateu do extrato ("fechado"). Forma
// não preenchida assume que bateu certinho — só a que ela digitar é conferida.
// Compartilhada entre fechar() e reimprimirFechamento() (mesma conta, os dois).
function calcularConferencia(caixa, resumo, formasInformadas) {
  const formasParaConferir = [...(resumo.porForma || [])];
  if (!formasParaConferir.some(f => f.forma_pagamento === 'Dinheiro')) {
    formasParaConferir.unshift({ forma_pagamento: 'Dinheiro', total: 0 });
  }
  return formasParaConferir.map(f => {
    const ehDinheiro = f.forma_pagamento === 'Dinheiro';
    const emCaixa = ehDinheiro
      ? parseFloat(caixa.valor_abertura) + parseFloat(f.total) + resumo.totalSuprimentos - resumo.totalSangrias - (resumo.totalDespesas || 0)
      : parseFloat(f.total);
    const bruto = formasInformadas[f.forma_pagamento];
    const fechado = (bruto !== undefined && bruto !== null && bruto !== '') ? (parseFloat(bruto) || 0) : emCaixa;
    return { forma_pagamento: f.forma_pagamento, em_caixa: emCaixa, fechado, diferenca: fechado - emCaixa };
  });
}

exports.fechar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_fechamento, observacao, fechamento_formas } = req.body;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  // Despesas lançadas pela atendente na hora de fechar — grava ANTES de montar o
  // resumo, pra já entrarem na conta do "esperado em dinheiro" e na conferência.
  const despesas = Array.isArray(req.body.despesas) ? req.body.despesas : [];
  for (const d of despesas) {
    const valor = parseFloat(d.valor) || 0;
    const descricao = String(d.descricao || '').trim();
    if (valor <= 0 || !descricao) continue;
    await db.query(
      `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'despesa', ?, ?)`,
      [caixa.id, valor, descricao]
    );
  }

  const resumo = await montarResumoCaixa(caixa);
  const formasInformadas = fechamento_formas && typeof fechamento_formas === 'object' ? fechamento_formas : {};
  const conferencia = calcularConferencia(caixa, resumo, formasInformadas);
  const diferencaTotal = conferencia.reduce((s, c) => s + c.diferenca, 0);
  const informadoDinheiro = conferencia.find(c => c.forma_pagamento === 'Dinheiro')?.fechado
    ?? (parseFloat(valor_fechamento) || 0);

  await db.query(
    `UPDATE caixas SET status = 'fechado', valor_fechamento = ?, valor_esperado = ?, fechamento_formas = ?, observacao = COALESCE(?, observacao), fechado_em = NOW()
     WHERE id = ?`,
    [informadoDinheiro, resumo.esperadoEmDinheiro, JSON.stringify(formasInformadas), observacao || null, caixa.id]
  );

  res.json({
    ok: true,
    esperado: resumo.esperadoEmDinheiro,
    informado: informadoDinheiro,
    diferenca: diferencaTotal,
    conferencia,
    resumo,
  });
};

// Refaz o mesmo comprovante de fechamento pra reimprimir depois — usado quando a
// impressão travou/foi bloqueada na hora. Funciona pra caixa aberto ou já fechado
// (nesse caso usa o que ficou salvo em fechamento_formas na hora do fechamento).
exports.reimprimirFechamento = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado.' });

  const resumo = await montarResumoCaixa(caixa);
  let formasInformadas = {};
  if (caixa.fechamento_formas) {
    try { formasInformadas = JSON.parse(caixa.fechamento_formas) || {}; } catch { formasInformadas = {}; }
  }
  const conferencia = calcularConferencia(caixa, resumo, formasInformadas);
  const diferencaTotal = conferencia.reduce((s, c) => s + c.diferenca, 0);

  res.json({ caixa: { ...caixa, resumo }, conferencia, diferenca: diferencaTotal });
};

exports.sangria = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'sangria', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};

exports.suprimento = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'suprimento', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};
