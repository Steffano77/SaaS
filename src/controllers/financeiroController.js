const db = require('../database/connection');

// Garante que a tabela existe e coluna de PIN na padaria
async function criarTabela() {
  await db.query(`
    CREATE TABLE IF NOT EXISTS financeiro (
      id           INT AUTO_INCREMENT PRIMARY KEY,
      padaria_id   INT NOT NULL,
      tipo         ENUM('entrada','saida') NOT NULL,
      valor        DECIMAL(10,2) NOT NULL,
      descricao    VARCHAR(255) NOT NULL,
      categoria    VARCHAR(100) DEFAULT 'Outro',
      data         DATE NOT NULL,
      criado_em    DATETIME DEFAULT NOW(),
      INDEX idx_padaria_data (padaria_id, data)
    )
  `);
  try {
    await db.query(`ALTER TABLE padarias ADD COLUMN pin_financeiro VARCHAR(4) NOT NULL DEFAULT '1234'`);
  } catch(e) { /* coluna já existe */ }
  // Garante que linhas antigas com NULL recebam o padrão
  await db.query(`UPDATE padarias SET pin_financeiro = '1234' WHERE pin_financeiro IS NULL OR pin_financeiro = ''`).catch(() => {});
}
criarTabela().catch(console.error);

// Verificar PIN
exports.verificarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { pin } = req.body;
  if (!pin) return res.status(400).json({ erro: 'PIN obrigatório.' });
  const PIN_MASTER = process.env.PIN_FINANCEIRO_MASTER || '1392';
  const [[padaria]] = await db.query(`SELECT pin_financeiro FROM padarias WHERE id = ?`, [padaria_id]);
  const pinSalvo = (padaria?.pin_financeiro || '1234').trim();
  if (pin.trim() !== pinSalvo && pin.trim() !== PIN_MASTER)
    return res.status(401).json({ erro: 'PIN incorreto.' });
  res.json({ ok: true });
};

// Alterar PIN
exports.alterarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { pin_atual, pin_novo } = req.body;
  if (!pin_atual || !pin_novo) return res.status(400).json({ erro: 'Preencha todos os campos.' });
  if (!/^\d{4}$/.test(pin_novo)) return res.status(400).json({ erro: 'PIN deve ter 4 dígitos.' });
  const PIN_MASTER = process.env.PIN_FINANCEIRO_MASTER || '1392';
  const [[padaria]] = await db.query(`SELECT pin_financeiro FROM padarias WHERE id = ?`, [padaria_id]);
  const pinSalvo = (padaria?.pin_financeiro || '1234').trim();
  if (pin_atual.trim() !== pinSalvo && pin_atual.trim() !== PIN_MASTER)
    return res.status(401).json({ erro: 'PIN atual incorreto.' });
  await db.query(`UPDATE padarias SET pin_financeiro = ? WHERE id = ?`, [pin_novo, padaria_id]);
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
  const { tipo, valor, descricao, categoria, data } = req.body;

  if (!tipo || !valor || !descricao || !data)
    return res.status(400).json({ erro: 'Preencha todos os campos obrigatórios.' });
  if (!['entrada','saida'].includes(tipo))
    return res.status(400).json({ erro: 'Tipo inválido.' });
  if (parseFloat(valor) <= 0)
    return res.status(400).json({ erro: 'Valor deve ser maior que zero.' });

  const [r] = await db.query(
    `INSERT INTO financeiro (padaria_id, tipo, valor, descricao, categoria, data) VALUES (?,?,?,?,?,?)`,
    [padaria_id, tipo, parseFloat(valor), descricao.trim(), categoria || 'Outro', data]
  );
  res.json({ ok: true, id: r.insertId });
};

// Excluir movimentação
exports.excluir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { id } = req.params;
  await db.query(`DELETE FROM financeiro WHERE id = ? AND padaria_id = ?`, [id, padaria_id]);
  res.json({ ok: true });
};
