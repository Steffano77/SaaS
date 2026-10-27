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

    const baixa = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/liquidar`)).send({ forma: 'Dinheiro' });
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

  test('pagamento parcial abate do saldo sem precisar quitar tudo', async () => {
    const cnpj = '22333444000195';
    await auth(request(app).post('/api/clientes-faturado')).send({
      cnpj, nome: 'Oficina Teste LTDA', tipo: 'empresa',
    });

    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Parcial' });
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Parcial Teste' });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/itens`)).send({
      nome_produto: 'Pedido grande', quantidade: 1, preco_unitario: 200,
    });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 200, cliente_documento: cnpj, cliente_nome: 'Oficina Teste LTDA' }],
    });

    // Deve R$200, paga R$100 — saldo tem que ficar em R$100, não zerar
    const pagou = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 100, forma: 'Pix' });
    expect(pagou.status).toBe(200);
    expect(pagou.body.saldoAntes).toBeCloseTo(200, 2);
    expect(pagou.body.saldoDepois).toBeCloseTo(100, 2);

    const saldo1 = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(saldo1.body.saldoDevedor).toBeCloseTo(100, 2);

    // Paga o resto depois, em outra visita — saldo zera
    const pagouResto = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 100, forma: 'Dinheiro' });
    expect(pagouResto.status).toBe(200);
    const saldo2 = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(saldo2.body.saldoDevedor).toBeCloseTo(0, 2);

    // Não deixa pagar mais do que deve
    const pagouDemais = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 50, forma: 'Dinheiro' });
    expect(pagouDemais.status).toBe(400);
  });

  test('pagamento parcial aplica nas compras mais antigas primeiro (FIFO)', async () => {
    const cnpj = '33444555000106';
    await auth(request(app).post('/api/clientes-faturado')).send({
      cnpj, nome: 'Mercado Teste LTDA', tipo: 'empresa',
    });
    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa FIFO' });

    // Duas comandas de R$50 cada, uma depois da outra
    const c1 = await auth(request(app).post('/api/comandas')).send({ identificador: 'FIFO 1' });
    await auth(request(app).post(`/api/comandas/${c1.body.id}/itens`)).send({ nome_produto: 'Item A', quantidade: 1, preco_unitario: 50 });
    await auth(request(app).post(`/api/comandas/${c1.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 50, cliente_documento: cnpj, cliente_nome: 'Mercado Teste LTDA' }],
    });
    const c2 = await auth(request(app).post('/api/comandas')).send({ identificador: 'FIFO 2' });
    await auth(request(app).post(`/api/comandas/${c2.body.id}/itens`)).send({ nome_produto: 'Item B', quantidade: 1, preco_unitario: 50 });
    await auth(request(app).post(`/api/comandas/${c2.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 50, cliente_documento: cnpj, cliente_nome: 'Mercado Teste LTDA' }],
    });

    // Paga R$50 — deve quitar a comanda 1 (mais antiga) inteira, deixando a 2 intacta
    await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 50, forma: 'Pix' });
    const extrato = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/extrato`));
    const linha1 = extrato.body.find(l => l.comanda_id === c1.body.id);
    const linha2 = extrato.body.find(l => l.comanda_id === c2.body.id);
    expect(linha1.quitado_em).not.toBeNull();
    expect(linha1.forma_quitacao).toBe('Pix');
    expect(linha2.quitado_em).toBeNull();
  });

  test('forma de pagamento: obrigatória no caixa, opcional na retaguarda', async () => {
    const cnpj = '44555666000117';
    await auth(request(app).post('/api/clientes-faturado')).send({
      cnpj, nome: 'Padaria Teste LTDA', tipo: 'empresa',
    });
    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Forma' });
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Forma Teste' });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/itens`)).send({ nome_produto: 'Item', quantidade: 1, preco_unitario: 30 });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id,
      pagamentos: [{ forma_pagamento: 'Faturado', valor: 30, cliente_documento: cnpj, cliente_nome: 'Padaria Teste LTDA' }],
    });

    // No caixa (com caixa_id) a forma é obrigatória — entra no fechamento.
    const semFormaNoCaixa = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 10, caixa_id: abriuCaixa.body.id });
    expect(semFormaNoCaixa.status).toBe(400);
    const formaInvalida = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 30, forma: 'Bitcoin' });
    expect(formaInvalida.status).toBe(400);
    const ok = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 20, forma: 'Débito' });
    expect(ok.status).toBe(200);
    // Na retaguarda (sem caixa) dá baixa sem informar a forma, como era antes.
    const retaguarda = await auth(request(app).post(`/api/clientes-faturado/documento/${cnpj}/pagar-parcial`)).send({ valor: 10 });
    expect(retaguarda.status).toBe(200);
  });
});

describe('Limite de crédito de empresa (opcional)', () => {
  test('empresa sem limite não trava; com limite cadastrado, trava', async () => {
    const { appPronto, request } = require('./helpers/testApp');
    const { criarPadariaPremium } = require('./helpers/fixtures');
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const auth = r => r.set('Authorization', `Bearer ${token}`);
    const cnpj = '11222333000181';
    const criado = await auth(request(app).post('/api/clientes-faturado')).send({ cnpj, nome: 'Empresa Teste', tipo: 'empresa' });
    expect(criado.status).toBe(201);
    let s = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(s.body.limite).toBeNull();
    const up = await auth(request(app).put(`/api/clientes-faturado/${criado.body.id}`)).send({ nome: 'Empresa Teste', limite: '50' });
    expect(up.status).toBe(200);
    s = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(s.body.limite).toBe(50);
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Lim' });
    const c = await auth(request(app).post('/api/comandas')).send({ identificador: 'Lim 1' });
    await auth(request(app).post(`/api/comandas/${c.body.id}/itens`)).send({ nome_produto: 'X', quantidade: 1, preco_unitario: 80 });
    const f = await auth(request(app).post(`/api/comandas/${c.body.id}/fechar`)).send({ caixa_id: caixa.body.id, pagamentos: [{ forma_pagamento: 'Faturado', valor: 80, cliente_documento: cnpj, cliente_nome: 'Empresa Teste' }] });
    expect(f.status).toBe(400);
    await auth(request(app).put(`/api/clientes-faturado/${criado.body.id}`)).send({ nome: 'Empresa Teste', limite: '' });
    s = await auth(request(app).get(`/api/clientes-faturado/documento/${cnpj}/saldo`));
    expect(s.body.limite).toBeNull();
  });
});
