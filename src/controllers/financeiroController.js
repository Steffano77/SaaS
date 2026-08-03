const db     = require('../database/connection');
const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');
const crypto = require('crypto');

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

// Resumo de um dia (padrão: hoje), com entradas separadas por forma de pagamento
exports.resumoDia = async (req, res) => {
  const padaria_id = req.padaria.id;
  const dia = /^\d{4}-\d{2}-\d{2}$/.test(req.query.data || '')
    ? req.query.data
    : new Date().toISOString().slice(0, 10);

  const [porForma] = await db.query(
    `SELECT forma_pagamento, COALESCE(SUM(valor),0) AS total
     FROM financeiro WHERE padaria_id = ? AND tipo = 'entrada' AND data = ?
     GROUP BY forma_pagamento ORDER BY total DESC`,
    [padaria_id, dia]
  );
  const [[totais]] = await db.query(
    `SELECT
       COALESCE(SUM(CASE WHEN tipo='entrada' THEN valor ELSE 0 END),0) AS total_entradas,
       COALESCE(SUM(CASE WHEN tipo='saida'   THEN valor ELSE 0 END),0) AS total_saidas
     FROM financeiro WHERE padaria_id = ? AND data = ?`,
    [padaria_id, dia]
  );

  res.json({
    data: dia,
    total_entradas: parseFloat(totais.total_entradas),
    total_saidas: parseFloat(totais.total_saidas),
    saldo: parseFloat(totais.total_entradas) - parseFloat(totais.total_saidas),
    entradas_por_forma: porForma.map(p => ({ forma_pagamento: p.forma_pagamento, total: parseFloat(p.total) })),
  });
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

// Solicitar reset de PIN — envia e-mail com link
exports.solicitarResetPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[padaria]] = await db.query(`SELECT email, nome FROM padarias WHERE id = ?`, [padaria_id]);
  if (!padaria) return res.status(404).json({ erro: 'Conta não encontrada.' });

  const secret = process.env.JWT_SECRET;
  if (!secret) return res.status(500).json({ erro: 'Configuração inválida.' });

  const token = jwt.sign({ id: padaria_id, tipo: 'reset_pin', jti: crypto.randomUUID() }, secret, { expiresIn: '1h' });
  const expires = new Date(Date.now() + 60 * 60 * 1000);
  await db.query(`UPDATE padarias SET reset_token = ?, reset_expires = ? WHERE id = ?`, [token, expires, padaria_id]);

  const appUrl = process.env.APP_URL || 'https://panificapro-erp.onrender.com';
  const link = `${appUrl}/?reset_pin=${token}`;

  if (process.env.RESEND_API_KEY) {
    const { Resend } = require('resend');
    const resend = new Resend(process.env.RESEND_API_KEY);
    await resend.emails.send({
      from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
      to: padaria.email,
      subject: 'Redefinição de PIN financeiro — PanificaPro',
      html: `
        <div style="font-family:Inter,sans-serif;max-width:480px;margin:0 auto;padding:32px;">
          <img src="${appUrl}/img/logosem%20fundo.png" width="64" style="margin-bottom:16px;"/>
          <h2 style="color:#1e3a5f;">Olá, ${padaria.nome}!</h2>
          <p style="color:#475569;">Recebemos uma solicitação para redefinir o PIN do módulo financeiro.</p>
          <a href="${link}" style="display:inline-block;margin:20px 0;background:#f97316;color:#fff;padding:14px 28px;border-radius:10px;text-decoration:none;font-weight:600;">Redefinir meu PIN</a>
          <p style="color:#94a3b8;font-size:13px;">Link válido por 1 hora. Se não foi você, ignore este e-mail.</p>
        </div>`
    }).catch(e => console.error('Erro ao enviar e-mail de reset PIN:', e.message));
  } else {
    console.log(`[DEV] Link reset PIN para ${padaria.email}: ${link}`);
  }

  res.json({ ok: true });
};

// Confirmar reset de PIN via token do e-mail (rota pública)
exports.confirmarResetPin = async (req, res) => {
  const { token } = req.body;
  if (!token) return res.status(400).json({ erro: 'Token obrigatório.' });

  const secret = process.env.JWT_SECRET;
  let payload;
  try {
    payload = jwt.verify(token, secret);
  } catch {
    return res.status(400).json({ erro: 'Link inválido ou expirado.' });
  }

  if (payload.tipo !== 'reset_pin') return res.status(400).json({ erro: 'Token inválido.' });

  const [rows] = await db.query(
    `SELECT id FROM padarias WHERE id = ? AND reset_token = ? AND reset_expires > NOW()`,
    [payload.id, token]
  );
  if (!rows.length) return res.status(400).json({ erro: 'Link inválido, já utilizado ou expirado.' });

  await db.query(
    `UPDATE padarias SET pin_financeiro = NULL, reset_token = NULL, reset_expires = NULL WHERE id = ?`,
    [payload.id]
  );

  res.json({ ok: true });
};
