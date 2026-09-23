// Copia o estoque_atual de cada produto do servidor LOCAL pra nuvem (sobrescreve lá),
// um por um, casando pelo mesmo id de produto. Uso pontual, só quando os dois bancos
// ficaram desencontrados e o servidor local é quem tem os números certos.
// Roda no SERVIDOR LOCAL (usa as mesmas credenciais SYNC_CLOUD_* já configuradas no .env
// pra login na nuvem).
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const cloudUrl = process.env.SYNC_CLOUD_URL;
  const email = process.env.SYNC_CLOUD_EMAIL;
  const senha = process.env.SYNC_CLOUD_SENHA;
  if (!cloudUrl || !email || !senha) {
    console.error('Faltam as variáveis SYNC_CLOUD_URL / SYNC_CLOUD_EMAIL / SYNC_CLOUD_SENHA no .env deste servidor.');
    process.exit(1);
  }

  console.log('Fazendo login na nuvem...');
  const loginR = await fetch(`${cloudUrl}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, senha }),
  });
  if (!loginR.ok) {
    console.error('Login na nuvem falhou:', loginR.status);
    process.exit(1);
  }
  const { token } = await loginR.json();

  const [padariaLocal] = await db.query('SELECT id FROM padarias LIMIT 1');
  const padariaId = padariaLocal[0].id;
  const [produtos] = await db.query(
    'SELECT id, nome, estoque_atual FROM produtos WHERE padaria_id = ? AND ativo = 1',
    [padariaId]
  );
  console.log(`Enviando estoque de ${produtos.length} produtos ativos pra nuvem...`);

  let ok = 0, falhou = 0;
  for (const p of produtos) {
    const r = await fetch(`${cloudUrl}/api/produtos/${p.id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify({ estoque_atual: parseFloat(p.estoque_atual) || 0 }),
    }).catch(() => null);
    if (r && r.ok) ok++;
    else { falhou++; console.error(`Falhou: ${p.nome} (id ${p.id})`); }
  }

  console.log(`Concluído: ${ok} produtos atualizados na nuvem, ${falhou} falharam.`);
  process.exit(0);
})().catch(e => { console.error(e); process.exit(1); });
