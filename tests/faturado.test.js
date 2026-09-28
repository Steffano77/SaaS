const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

// "Faturado" é o fluxo de cliente que consome fiado e paga depois (empresa/CNPJ, ou
// funcionário/CPF com limite de R$500) — dinheiro real fica pendurado até "Dar baixa",
// então o saldo tem que bater exatamente com o que foi consumido, nem a mais nem a menos.
describe('Cliente Faturado (venda fiada)', () => {
  let app, token;

  beforeAll(async () => {
    app = await appPronto();
    ({ token } = await criarPadariaPremium(app, request));
  });

  function auth(req) { return req.set('Authorization', `Bearer ${token}`); }

  test('empresa (CNPJ) consome, saldo sobe, "Dar baixa" zera tudo', async () => {
    const cnpj = '11222333000181';
    const cliente = await auth(request(app).post('/api/clientes-faturado')).send({
      cnpj, nome: 'Pousada Teste LTDA', tipo: 'empresa',
    });
    expect(cliente.status).toBe(201);

    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Faturado' });
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Faturado Teste' });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/itens`)).send({
      nome_produto: 'Café da manhã', quantidade: 1, preco_unitario: 80,
    });
    const fechou = await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 80, cliente_documento: cnpj, cliente_nome: 'Pousada Teste LTDA' }],
    });
    expect(fechou.status).toBe(200);

    const saldoDepois = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(saldoDepois.body.saldoDevedor).toBeCloseTo(80, 2);

    const baixa = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/liquidar`));
    expect(baixa.status).toBe(200);

    const saldoFinal = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(saldoFinal.body.saldoDevedor).toBeCloseTo(0, 2);
  });

  test('funcionário (CPF) não passa do limite de R$500', async () => {
    const cpf = '52998224725'; // CPF válido (dígitos verificadores corretos)
    const cliente = await auth(request(app).post('/api/clientes-faturado')).send({
      cnpj: cpf, nome: 'Funcionário Teste', tipo: 'funcionario',
    });
    expect(cliente.status).toBe(201);
    expect(cliente.body.limite).toBe(500);

    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Limite' });
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Limite Teste' });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/itens`)).send({
      nome_produto: 'Compra grande', quantidade: 1, preco_unitario: 600,
    });
    const fechou = await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 600, cliente_documento: cpf, cliente_nome: 'Funcionário Teste' }],
    });
    // R$600 num limite de R$500 tem que ser recusado no servidor, não só escondido na tela
    expect(fechou.status).toBe(400);
  });
});
