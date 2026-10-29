const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium, opCaixa } = require('./helpers/fixtures');

// Busca do Financeiro: "saídas" traz também o que saiu da gaveta no caixa (sangria,
// despesa, vale), que não fica na tabela financeiro. Pedido real (Jota 3): achar
// um "vale juliana" lançado como despesa no caixa.
describe('Busca de saídas no Financeiro', () => {
  test('"saídas" e termo livre acham sangria/despesa do caixa, sem lixeira', async () => {
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const auth = r => r.set('Authorization', `Bearer ${token}`);
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ ...opCaixa(token), valor_abertura: 300, nome: 'Caixa Saídas' });
    expect(caixa.status).toBe(201);
    expect((await auth(request(app).post(`/api/caixa/${caixa.body.id}/despesa`)).send({ valor: 200, observacao: 'vale juliana' })).status).toBeLessThan(300);
    expect((await auth(request(app).post(`/api/caixa/${caixa.body.id}/sangria`)).send({ valor: 50, observacao: 'cofre' })).status).toBeLessThan(300);
    await auth(request(app).post('/api/financeiro')).send({ tipo: 'saida', valor: 10, descricao: 'Gás', categoria: 'Outros', forma_pagamento: 'Pix', data: new Date().toISOString().slice(0, 10) });

    const todas = await auth(request(app).get('/api/financeiro?busca=saidas'));
    expect(todas.status).toBe(200);
    const descs = todas.body.movimentacoes.map(m => m.descricao);
    expect(descs.some(d => /Despesa do caixa .*vale juliana/.test(d))).toBe(true);
    expect(descs.some(d => /Sangria do caixa .*cofre/.test(d))).toBe(true);
    expect(descs).toContain('Gás');
    expect(todas.body.movimentacoes.every(m => m.tipo === 'saida')).toBe(true);

    const vale = await auth(request(app).get('/api/financeiro?busca=juliana'));
    expect(vale.body.movimentacoes).toHaveLength(1);
    expect(vale.body.movimentacoes[0].origem).toBe('caixa');
    expect(vale.body.movimentacoes[0].categoria).toMatch(/Caixa Saídas/);
  });
});
