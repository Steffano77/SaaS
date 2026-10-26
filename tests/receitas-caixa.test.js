const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

// Pagamento de fiado recebido no caixa entra no fechamento: "Receita", "Resumo Receitas"
// e no "Em Caixa" da forma em que foi pago (antes aparecia como sobra no dinheiro).
describe('Recebimento de fiado no fechamento de caixa', () => {
  test('pagamento parcial em dinheiro soma no em caixa do dinheiro', async () => {
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const auth = r => r.set('Authorization', `Bearer ${token}`);
    const cnpj = '11444777000161';
    await auth(request(app).post('/api/clientes-faturado')).send({ cnpj, nome: 'Empresa Receita', tipo: 'empresa' });
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 100, nome: 'Caixa Receita' });
    const c = await auth(request(app).post('/api/comandas')).send({ identificador: 'Rec 1' });
    await auth(request(app).post(`/api/comandas/${c.body.id}/itens`)).send({ nome_produto: 'X', quantidade: 1, preco_unitario: 80 });
    const f = await auth(request(app).post(`/api/comandas/${c.body.id}/fechar`)).send({ caixa_id: caixa.body.id, pagamentos: [{ forma_pagamento: 'Faturado', valor: 80, cliente_documento: cnpj, cliente_nome: 'Empresa Receita' }] });
    expect(f.status).toBe(200);

    const pg = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 30, forma: 'Dinheiro', caixa_id: caixa.body.id });
    expect(pg.status).toBe(200);
    // Sem caixa (ex: tela de Financeiro) não entra em nenhum fechamento.
    await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 10, forma: 'Pix' });

    const fechou = await auth(request(app).post(`/api/caixa/${caixa.body.id}/fechar`)).send({ fechamento_formas: {} });
    expect(fechou.status).toBe(200);
    expect(fechou.body.resumo.totalReceitas).toBeCloseTo(30, 2);
    expect(fechou.body.resumo.receitas).toHaveLength(1);
    expect(fechou.body.resumo.receitas[0].cliente_nome).toBe('Empresa Receita');
    const din = fechou.body.conferencia.find(x => x.forma_pagamento === 'Dinheiro');
    expect(din.em_caixa).toBeCloseTo(130, 2); // 100 de abertura + 30 recebidos
  });
});
