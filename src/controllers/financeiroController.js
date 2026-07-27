const db     = require('../database/connection');
const bcrypt = require('bcryptjs');

async function criarTabela() {
  await db.query(`
    CREATE TABLE IF NOT EXISTS financeiro (
      id               INT AUTO_INCREMENT PRIMARY KEY,
      padaria_id       INT NOT NULL,
      tipo             ENUM('entrada','saida') NOT NULL,
      valor            DECIMAL(10,2) NOT NULL,
      descricao        VARCHAR(255) NOT NULL,
      categoria        VARCHAR(100) DEFAULT 'Outro',
      forma_pagamento  VARCHAR(50) DEFAULT 'Dinheiro',
      data             DATE NOT NULL,
      criado_em        DATETIME DEFAULT NOW(),
      INDEX idx_padaria_data (padaria_id, data)
    )
  `);
  // Adiciona forma_pagamento se não existir
  await db.query(`ALTER TABLE financeiro ADD COLUMN forma_pagamento VARCHAR(50) DEFAULT 'Dinheiro'`).catch(() => {});

  await db.query(`
    CREATE TABLE IF NOT EXISTS contas_pagar (
      id          INT AUTO_INCREMENT PRIMARY KEY,
      padaria_id  INT NOT NULL,
      descricao   VARCHAR(255) NOT NULL,
      categoria   VARCHAR(100) DEFAULT 'Outro',
      valor       DECIMAL(10,2) NOT NULL,
      vencimento  DATE NOT NULL,
      status      ENUM('aberto','pago','atrasado') DEFAULT 'aberto',
      criado_em   DATETIME DEFAULT NOW(),
      INDEX idx_cp_padaria (padaria_id, vencimento)
    )
  `);

  try {
    await db.query(`ALTER TABLE padarias ADD COLUMN pin_financeiro VARCHAR(255) NULL`);
  } catch(e) {}
}
criarTabela().catch(console.error);

// Verificar PIN
exports.verificarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { pin } = req.body;
  if (!pin || !/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'PIN obrigatório (4 dígitos).' });

  const [[padaria]] = await db.query(`SELECT pin_financeiro FROM padarias WHERE id = ?`, [padaria_id]);

  // Se não tem PIN cadastrado ainda, bloqueia e pede para definir
  if (!padaria?.pin_financeiro) return res.status(401).json({ erro: 'PIN não configurado. Acesse "Alterar PIN" para definir.', sem_pin: true });

  // Verifica PIN master (variável de ambiente obrigatória — sem fallback hardcoded)
  const PIN_MASTER = process.env.PIN_FINANCEIRO_MASTER;
  if (PIN_MASTER && pin === PIN_MASTER) return res.json({ ok: true });

  const ok = await bcrypt.compare(pin, padaria.pin_financeiro);
  if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
  res.json({ ok: true });
};

// Alterar PIN
exports.alterarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { pin_atual, pin_novo } = req.body;
  if (!pin_novo) return res.status(400).json({ erro: 'Preencha todos os campos.' });
  if (!/^\d{4}$/.test(pin_novo)) return res.status(400).json({ erro: 'PIN deve ter 4 dígitos.' });

  const [[padaria]] = await db.query(`SELECT pin_financeiro FROM padarias WHERE id = ?`, [padaria_id]);

  // Se já tem PIN cadastrado, valida o atual
  if (padaria?.pin_financeiro) {
    if (!pin_atual) return res.status(400).json({ erro: 'PIN atual obrigatório.' });
    const PIN_MASTER = process.env.PIN_FINANCEIRO_MASTER;
    const masterOk = PIN_MASTER && pin_atual === PIN_MASTER;
    const pinOk = await bcrypt.compare(pin_atual, padaria.pin_financeiro);
    if (!masterOk && !pinOk) return res.status(401).json({ erro: 'PIN atual incorreto.' });
  }

  const hash = await bcrypt.hash(pin_novo, 10);
  await db.query(`UPDATE padarias SET pin_financeiro = ? WHERE id = ?`, [hash, padaria_id]);
  res.json({ ok: true });
};

// Listar movimentações
exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { periodo = 'mes', data_inicio, data_fim } = req.query;

  let inicio, fim;
  const hoje = new Date();

  if (data_inicio && data_fim) {
    inicio = data_inicio;
    fim = data_fim;
  } else if (periodo === 'hoje') {
    inicio = fim = hoje.toISOString().split('T')[0];
  } else if (periodo === 'semana') {
    const d = new Date(hoje);
    d.setDate(d.getDate() - 6);
    inicio = d.toISOString().split('T')[0];
    fim = hoje.toISOString().split('T')[0];
  } else if (periodo === 'ano') {
    inicio = `${hoje.getFullYear()}-01-01`;
    fim = hoje.toISOString().split('T')[0];
  } else {
    // mês
    inicio = `${hoje.getFullYear()}-${String(hoje.getMonth()+1).padStart(2,'0')}-01`;
    fim = hoje.toISOString().split('T')[0];
  }

  const [movs] = await db.query(
    `SELECT * FROM financeiro WHERE padaria_id = ? AND data BETWEEN ? AND ? ORDER BY data DESC, criado_em DESC`,
    [padaria_id, inicio, fim]
  );

  const [resumo] = await db.query(
    `SELECT
       COALESCE(SUM(CASE WHEN tipo='entrada' THEN valor ELSE 0 END), 0) AS total_entradas,
       COALESCE(SUM(CASE WHEN tipo='saida'   THEN valor ELSE 0 END), 0) AS total_saidas
     FROM financeiro WHERE padaria_id = ? AND data BETWEEN ? AND ?`,
    [padaria_id, inicio, fim]
  );

  const { total_entradas, total_saidas } = resumo[0];
  res.json({
    movimentacoes: movs,
    total_entradas: parseFloat(total_entradas),
    total_saidas:   parseFloat(total_saidas),
    saldo:          parseFloat(total_entradas) - parseFloat(total_saidas),
    periodo: { inicio, fim }
  });
};

// Criar movimentação
exports.criar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { tipo, valor, descricao, categoria, data, forma_pagamento, conta_pagar_id } = req.body;

  if (!tipo || !valor || !descricao || !data)
    return res.status(400).json({ erro: 'Preencha todos os campos obrigatórios.' });
  if (!['entrada','saida'].includes(tipo))
    return res.status(400).json({ erro: 'Tipo inválido.' });
  if (parseFloat(valor) <= 0)
    return res.status(400).json({ erro: 'Valor deve ser maior que zero.' });

  const [r] = await db.query(
    `INSERT INTO financeiro (padaria_id, tipo, valor, descricao, categoria, forma_pagamento, data) VALUES (?,?,?,?,?,?,?)`,
    [padaria_id, tipo, parseFloat(valor), descricao.trim(), categoria || 'Outro', forma_pagamento || 'Dinheiro', data]
  );

  // Baixa a conta a pagar se vinculada
  if (conta_pagar_id) {
    await db.query(`UPDATE contas_pagar SET status='pago' WHERE id=? AND padaria_id=?`, [conta_pagar_id, padaria_id]).catch(() => {});
  }

  res.json({ ok: true, id: r.insertId });
};

// Excluir movimentação
exports.excluir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { id } = req.params;
  await db.query(`DELETE FROM financeiro WHERE id = ? AND padaria_id = ?`, [id, padaria_id]);
  res.json({ ok: true });
};

// Gráfico últimos 6 meses
exports.grafico = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [rows] = await db.query(`
    SELECT
      DATE_FORMAT(data, '%Y-%m') AS mes,
      COALESCE(SUM(CASE WHEN tipo='entrada' THEN valor ELSE 0 END),0) AS entradas,
      COALESCE(SUM(CASE WHEN tipo='saida'   THEN valor ELSE 0 END),0) AS saidas
    FROM financeiro
    WHERE padaria_id = ?
      AND data >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    GROUP BY mes ORDER BY mes ASC
  `, [padaria_id]);
  res.json(rows);
};

// ── Contas a Pagar ──────────────────────────────────────────
exports.listarContasPagar = async (req, res) => {
  const padaria_id = req.padaria.id;
  // Atualiza status atrasado automaticamente
  await db.query(`UPDATE contas_pagar SET status='atrasado' WHERE padaria_id=? AND vencimento < CURDATE() AND status='aberto'`, [padaria_id]).catch(() => {});
  const [rows] = await db.query(
    `SELECT * FROM contas_pagar WHERE padaria_id=? AND status != 'pago' ORDER BY vencimento ASC`,
    [padaria_id]
  );
  const [totais] = await db.query(
    `SELECT COALESCE(SUM(valor),0) AS total, COUNT(*) AS qtd FROM contas_pagar WHERE padaria_id=? AND status != 'pago'`,
    [padaria_id]
  );
  res.json({ contas: rows, total: parseFloat(totais[0].total), qtd: totais[0].qtd });
};

exports.criarContaPagar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { descricao, categoria, valor, vencimento } = req.body;
  if (!descricao || !valor || !vencimento)
    return res.status(400).json({ erro: 'Preencha todos os campos.' });
  const [r] = await db.query(
    `INSERT INTO contas_pagar (padaria_id, descricao, categoria, valor, vencimento) VALUES (?,?,?,?,?)`,
    [padaria_id, descricao.trim(), categoria || 'Outro', parseFloat(valor), vencimento]
  );
  res.json({ ok: true, id: r.insertId });
};

exports.pagarConta = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { id } = req.params;
  await db.query(`UPDATE contas_pagar SET status='pago' WHERE id=? AND padaria_id=?`, [id, padaria_id]);
  res.json({ ok: true });
};

exports.excluirContaPagar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { id } = req.params;
  await db.query(`DELETE FROM contas_pagar WHERE id=? AND padaria_id=?`, [id, padaria_id]);
  res.json({ ok: true });
};
