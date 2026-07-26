const db = require('../database/connection');

// Garante que a tabela existe
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
}
criarTabela().catch(console.error);

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
