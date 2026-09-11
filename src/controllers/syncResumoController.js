const db = require('../database/connection');

// Recebe o resumo do dia mandado pelo servidor LOCAL (rodando na padaria) — não é
// dado bruto (comanda por comanda), só os números finais. Idempotente: pode mandar
// de novo o mesmo dia várias vezes (a cada X minutos), sempre sobrescreve com o
// valor mais atual em vez de somar/duplicar.
exports.salvar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas } = req.body;

  const dia = data || new Date().toISOString().slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(dia)) return res.status(400).json({ erro: 'Data inválida.' });

  await db.query(
    `INSERT INTO sync_resumo_local (padaria_id, data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas)
     VALUES (?, ?, ?, ?, ?)
     ON DUPLICATE KEY UPDATE
       total_vendas = VALUES(total_vendas),
       qtd_comandas_fechadas = VALUES(qtd_comandas_fechadas),
       qtd_comandas_abertas = VALUES(qtd_comandas_abertas),
       atualizado_em = NOW()`,
    [padaria_id, dia, parseFloat(total_vendas) || 0, parseInt(qtd_comandas_fechadas) || 0, parseInt(qtd_comandas_abertas) || 0]
  );

  res.json({ ok: true });
};

// Devolve o resumo mais recente (hoje, por padrão) — usado pelo dono acompanhando
// de casa/celular, logado normal na nuvem.
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const dia = req.query.data || new Date().toISOString().slice(0, 10);

  const [[resumo]] = await db.query(
    `SELECT data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas, atualizado_em
     FROM sync_resumo_local WHERE padaria_id = ? AND data = ?`,
    [padaria_id, dia]
  );

  if (!resumo) return res.json({ existe: false, data: dia });
  res.json({ existe: true, ...resumo });
};
