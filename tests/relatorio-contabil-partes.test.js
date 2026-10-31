const { appPronto } = require('./helpers/testApp');
const db = require('../src/database/connection');
const { montarPartesDoMes } = require('../src/jobs/relatorioContabilMensal');

// Relatório da contabilidade: mês com muitas notas sai em vários ZIPs, cada um dentro
// do limite. Bug real (Jota 3, out/2026): 9.147 notas = ZIP de 35 MB, acima do limite
// do e-mail — o envio do dia 1º seria recusado.
describe('Relatório contábil dividido em partes', () => {
  test('cada parte cabe no limite e nenhuma nota fica de fora ou repete', async () => {
    await appPronto();
    const padaria = 900000 + Math.floor(Math.random() * 99999);
    const xmlGrande = () => '<NFe>' + require('crypto').randomBytes(3000).toString('hex') + '</NFe>'; // não comprime
    for (let i = 1; i <= 30; i++) {
      await db.query(
        `INSERT INTO notas_fiscais (padaria_id, numero, serie, chave_acesso, status, ambiente, valor_total, xml_assinado, autorizada_em)
         VALUES (?, ?, 1, ?, 'autorizada', 1, 10, ?, '2026-10-15 10:00:00')`,
        [padaria, i, String(i).padStart(44, '0'), xmlGrande()]
      );
    }
    // Uma nota de homologação e uma de novembro não podem entrar.
    await db.query(`INSERT INTO notas_fiscais (padaria_id, numero, serie, status, ambiente, valor_total, xml_assinado, autorizada_em) VALUES (?, 99, 1, 'autorizada', 2, 1, '<x/>', '2026-10-15 10:00:00')`, [padaria]);
    await db.query(`INSERT INTO notas_fiscais (padaria_id, numero, serie, status, ambiente, valor_total, xml_assinado, autorizada_em) VALUES (?, 98, 1, 'autorizada', 1, 1, '<x/>', '2026-11-01 08:00:00')`, [padaria]);

    const limite = 40 * 1024; // ~30 notas de ~6 KB cada: precisa de várias partes
    const { notas, partes } = await montarPartesDoMes(padaria, '2026', '10', limite);
    expect(notas).toHaveLength(30);
    expect(partes.length).toBeGreaterThan(1);
    for (const p of partes) expect(p.zipBuffer.length).toBeLessThanOrEqual(limite);
    const numeros = partes.flatMap(p => p.notas.map(n => n.numero));
    expect(numeros).toEqual(Array.from({ length: 30 }, (_, i) => i + 1));

    // Limite folgado: uma parte só, como sempre foi.
    const umaSo = await montarPartesDoMes(padaria, '2026', '10', 50 * 1024 * 1024);
    expect(umaSo.partes).toHaveLength(1);
  });
});
