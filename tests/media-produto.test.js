const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');
const db = require('../src/database/connection');

// Média por produto: vende 2 un ontem às 7h e 4 un anteontem às 17h — média de 7 dias
// = 6/7 por dia; o dia de hoje (venda de 100 un) nunca pode entrar.
describe('Média por produto', () => {
  test('calcula média por dia, ignora hoje e consumo interno', async () => {
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const auth = r => r.set('Authorization', `Bearer ${token}`);
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Media' });
    const prod = await auth(request(app).post('/api/produtos')).send({ nome: 'Pão Média Teste', preco_venda: 10 });
    const vender = async (qtd, forma) => {
      const c = await auth(request(app).post('/api/comandas')).send({ identificador: `M ${Math.random()}` });
      await auth(request(app).post(`/api/comandas/${c.body.id}/itens`)).send({ produto_id: prod.body.id, quantidade: qtd, preco_unitario: 10 });
      const f = await auth(request(app).post(`/api/comandas/${c.body.id}/fechar`)).send({ caixa_id: caixa.body.id, pagamentos: [{ forma_pagamento: forma, valor: qtd * 10 }] });
      expect(f.status).toBe(200);
      return c.body.id;
    };
    const ontem = await vender(2, 'Dinheiro');
    const anteontem = await vender(4, 'Pix');
    await vender(100, 'Dinheiro'); // hoje: não entra
    const interno = await vender(50, 'Padaria'); // consumo interno: não entra
    await db.query(`UPDATE comandas SET fechada_em = DATE_SUB(CURDATE(), INTERVAL 1 DAY) + INTERVAL 7 HOUR WHERE id IN (?, ?)`, [ontem, interno]);
    await db.query(`UPDATE comandas SET fechada_em = DATE_SUB(CURDATE(), INTERVAL 2 DAY) + INTERVAL 17 HOUR WHERE id = ?`, [anteontem]);

    const f = d => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, '0')}-${String(d.getDate()).padStart(2, '0')}`;
    const hoje = new Date(); const ini = new Date(); ini.setDate(ini.getDate() - 7);
    const r = await auth(request(app).get(`/api/relatorios/produto-media?produto_id=${prod.body.id}&de=${f(ini)}&ate=${f(hoje)}`));
    expect(r.status).toBe(200);
    expect(r.body.periodo.dias).toBe(7); // "até hoje" vira "até ontem"
    expect(r.body.totais.qtd).toBe(6);
    expect(r.body.totais.media_qtd_dia).toBeCloseTo(6 / 7, 5);
    expect(r.body.totais.preco_medio).toBeCloseTo(10, 5);
    const dowOntem = new Date(Date.now() - 86400000).getDay();
    expect(r.body.por_horario[dowOntem].horas['7']).toBeCloseTo(2, 5);
  });
});
