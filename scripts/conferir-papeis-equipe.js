// Só leitura — lista os atendentes ativos, o papel de cada um e se têm PIN cadastrado.
// Uso ANTES de aplicar o commit que exige papel Caixa/Gerente + PIN pra abrir caixa —
// confirma que ninguém vai ficar travado sem conseguir abrir o caixa.
// Uso: node scripts\conferir-papeis-equipe.js
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const [atendentes] = await db.query(
    `SELECT id, nome, role, gestor, (pin_hash IS NOT NULL) AS tem_pin, ativo
     FROM atendentes WHERE ativo = 1 ORDER BY role, nome`
  );
  console.log('\n== ATENDENTES ATIVOS ==');
  console.table(atendentes);

  const semPapel = atendentes.filter(a => !['caixa', 'gerente'].includes(a.role));
  const semPin = atendentes.filter(a => ['caixa', 'gerente'].includes(a.role) && !a.tem_pin);

  console.log(`\nTotal de atendentes ativos: ${atendentes.length}`);
  console.log(`Com papel Caixa ou Gerente: ${atendentes.length - semPapel.length}`);
  if (semPapel.length) {
    console.log(`\n⚠️  SEM papel Caixa/Gerente (não vão conseguir abrir caixa depois do fix):`);
    console.table(semPapel.map(a => ({ nome: a.nome, role: a.role })));
  }
  if (semPin.length) {
    console.log(`\n⚠️  TÊM papel Caixa/Gerente mas SEM PIN cadastrado (também vão ficar travados):`);
    console.table(semPin.map(a => ({ nome: a.nome, role: a.role })));
  }
  if (!semPapel.length && !semPin.length) {
    console.log('\n✅ Todo mundo com papel Caixa/Gerente já tem PIN — seguro aplicar o fix.');
  }
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
