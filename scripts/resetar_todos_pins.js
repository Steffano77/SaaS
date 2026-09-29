// Reseta o PIN de TODOS os atendentes ativos pra números novos, gerados na hora e
// garantidamente únicos entre si (evita de vez qualquer colisão que já existisse nos
// PINs antigos — usado depois de um caso real onde duas pessoas tinham por coincidência
// o mesmo PIN e o login "reconhecia" a pessoa errada). Imprime a lista final pra
// anotar/distribuir. Roda no SERVIDOR LOCAL ou no VPS, o que for usado de verdade.
require('dotenv').config();
const bcrypt = require('bcryptjs');
const db = require('../src/database/connection');

(async () => {
  const [atendentes] = await db.query(
    `SELECT id, nome FROM atendentes WHERE ativo = 1 ORDER BY nome`
  );
  if (!atendentes.length) { console.log('Nenhum atendente ativo encontrado.'); process.exit(0); }

  const pinsUsados = new Set();
  function gerarPinUnico() {
    let pin;
    do { pin = String(Math.floor(Math.random() * 10000)).padStart(4, '0'); }
    while (pinsUsados.has(pin));
    pinsUsados.add(pin);
    return pin;
  }

  console.log(`Resetando o PIN de ${atendentes.length} atendente(s)...\n`);
  const resultado = [];
  for (const a of atendentes) {
    const pin = gerarPinUnico();
    const pin_hash = await bcrypt.hash(pin, 10);
    await db.query(`UPDATE atendentes SET pin_hash = ? WHERE id = ?`, [pin_hash, a.id]);
    resultado.push({ nome: a.nome, pin });
  }

  console.log('Nome'.padEnd(30) + 'PIN novo');
  console.log('-'.repeat(40));
  for (const r of resultado) console.log(r.nome.padEnd(30) + r.pin);

  console.log('\nPronto! Anota/distribui esses PINs novos pra cada pessoa.');
  process.exit(0);
})().catch(e => { console.error(e); process.exit(1); });
