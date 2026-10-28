const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium, opCaixa } = require('./helpers/fixtures');
const db = require('../src/database/connection');

// Bug real (Balcão C57, 21/10): item bipado no mesmo instante da cobrança entrava numa
// comanda já cobrada sem pagar — total 19,29 com só 16,00 pago, e a NFC-e era rejeitada
// pra sempre (865). Dispara as duas coisas juntas várias vezes e confere que nunca sobra
// comanda fechada com pagamento menor que os itens.
describe('Item bipado bem na hora de cobrar', () => {
  let app, token, caixaId;
  function auth(req) { return req.set('Authorization', `Bearer ${token}`); }

  beforeAll(async () => {
    app = await appPronto();
    ({ token } = await criarPadariaPremium(app, request));
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ ...opCaixa(token), valor_abertura: 0, nome: 'Caixa Corrida' });
    caixaId = caixa.body.id;
  });

  test('nunca fecha comanda com item sem pagar', async () => {
    for (let i = 0; i < 15; i++) {
      const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: `Corrida ${i}` });
      const id = comanda.body.id;
      await auth(request(app).post(`/api/comandas/${id}/itens`)).send({ nome_produto: 'Pão de Frios', quantidade: 1, preco_unitario: 16 });

      const [fechou, item] = await Promise.all([
        auth(request(app).post(`/api/comandas/${id}/fechar`)).send({ caixa_id: caixaId, pagamentos: [{ forma_pagamento: 'Voucher', valor: 16 }] }),
        auth(request(app).post(`/api/comandas/${id}/itens`)).send({ nome_produto: 'Pão Francês', quantidade: 1, preco_unitario: 3.29 }),
      ]);

      const [[c]] = await db.query(`SELECT status FROM comandas WHERE id = ?`, [id]);
      const [[{ itens }]] = await db.query(`SELECT COALESCE(SUM(subtotal),0) AS itens FROM itens_comanda WHERE comanda_id = ?`, [id]);
      const [[{ pago }]] = await db.query(`SELECT COALESCE(SUM(valor),0) AS pago FROM comanda_pagamentos WHERE comanda_id = ?`, [id]);
      if (c.status === 'fechada') {
        expect(fechou.status).toBe(200);
        expect(item.status).toBe(400);
        expect(parseFloat(pago)).toBeCloseTo(parseFloat(itens), 2);
      } else {
        expect(item.status).toBe(201);
        // 409 = item entrou no meio da cobrança; 400 = item entrou antes e a soma não bateu.
        expect([400, 409]).toContain(fechou.status);
        expect(parseFloat(itens)).toBeCloseTo(19.29, 2);
      }
    }
  });
});
