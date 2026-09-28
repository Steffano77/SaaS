const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

// Fluxo completo de uma venda de balcão: abrir caixa -> cadastrar produto -> abrir
// comanda -> adicionar item -> fechar comanda cobrando -> fechar caixa -> conferir que
// o dinheiro esperado bate com abertura + vendas em dinheiro. É o caminho que a
// atendente faz várias vezes por dia — não pode quebrar.
describe('Venda de balcão (caixa -> comanda -> pagamento -> fechamento)', () => {
  let app, token;

  beforeAll(async () => {
    app = await appPronto();
    ({ token } = await criarPadariaPremium(app, request));
  });

  function auth(req) { return req.set('Authorization', `Bearer ${token}`); }

  test('abre caixa, vende e fecha batendo o dinheiro esperado', async () => {
    // 1) Abre o caixa com R$100 de fundo de troco
    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 100, nome: 'Caixa Teste' });
    expect(abriuCaixa.status).toBe(201);
    const caixaId = abriuCaixa.body.id;

    // 2) Cadastra um produto pra vender
    const produto = await auth(request(app).post('/api/produtos')).send({ nome: 'Pão Francês (teste)', preco_venda: 12.5 });
    expect(produto.status).toBe(201);

    // 3) Abre uma comanda de balcão
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Balcão Teste 1' });
    expect(comanda.status).toBe(201);
    const comandaId = comanda.body.id;

    // 4) Adiciona 2 unidades do produto
    const item = await auth(request(app).post(`/api/comandas/${comandaId}/itens`)).send({
      produto_id: produto.body.id, quantidade: 2, preco_unitario: 12.5,
    });
    expect(item.status).toBe(201);

    // 5) Fecha a comanda cobrando em Dinheiro (total esperado: 2 x 12,50 = 25,00)
    const fechouComanda = await auth(request(app).post(`/api/comandas/${comandaId}/fechar`)).send({
      caixa_id: caixaId, forma_pagamento: 'Dinheiro',
    });
    expect(fechouComanda.status).toBe(200);

    // 6) Fecha o caixa e confere o esperado em dinheiro: 100 (abertura) + 25 (venda) = 125
    const fechouCaixa = await auth(request(app).post(`/api/caixa/${caixaId}/fechar`)).send({ valor_fechamento: 125 });
    expect(fechouCaixa.status).toBe(200);
    expect(fechouCaixa.body.esperado).toBeCloseTo(125, 2);
    expect(fechouCaixa.body.diferenca).toBeCloseTo(0, 2);
  });

  test('não deixa fechar comanda sem item', async () => {
    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Teste Vazia' });
    const caixaId = abriuCaixa.body.id;
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Balcão Teste Vazia' });
    const fechou = await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({ caixa_id: caixaId });
    expect(fechou.status).toBe(400);
  });

  test('não deixa abrir dois caixas com o mesmo nome ao mesmo tempo', async () => {
    await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Duplicada' });
    const segunda = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Duplicada' });
    expect(segunda.status).toBe(409);
  });
});
