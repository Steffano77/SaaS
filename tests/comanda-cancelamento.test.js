const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

// Cancelar/excluir comanda é uma ação sensível (mexe em dinheiro já registrado) — só
// atendente com papel "gerente" pode, e só depois de logar com o PIN dele (X-Func-Token).
// Foi exatamente esse caminho que usamos pra apagar a comanda duplicada da Pousada
// Stand Up outro dia — esse teste garante que continua funcionando do jeito certo.
describe('Cancelar / excluir comanda (ação de gerente)', () => {
  let app, token, funcToken;

  beforeAll(async () => {
    app = await appPronto();
    ({ token } = await criarPadariaPremium(app, request));
    function auth(req) { return req.set('Authorization', `Bearer ${token}`); }

    await auth(request(app).post('/api/atendentes')).send({ nome: 'Gerente Teste', pin: '1234', role: 'gerente' });
    const login = await auth(request(app).post('/api/atendentes/login')).send({ pin: '1234' });
    expect(login.status).toBe(200);
    funcToken = login.body.token;
  });

  function auth(req) { return req.set('Authorization', `Bearer ${token}`); }
  function comoGerente(req) { return auth(req).set('X-Func-Token', funcToken); }

  test('cancelar comanda aberta sem PIN de gerente é recusado', async () => {
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Cancelar Sem PIN' });
    const cancelou = await auth(request(app).post(`/api/comandas/${comanda.body.id}/cancelar`));
    expect(cancelou.status).toBe(401);
    expect(cancelou.body.precisa_login_funcionario).toBe(true);
  });

  test('cancelar comanda aberta com PIN de gerente funciona', async () => {
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Cancelar Com PIN' });
    const cancelou = await comoGerente(request(app).post(`/api/comandas/${comanda.body.id}/cancelar`));
    expect(cancelou.status).toBe(200);

    const buscou = await auth(request(app).get(`/api/comandas/${comanda.body.id}`));
    expect(buscou.body.status).toBe('cancelada');
  });

  test('excluir de vez uma comanda já fechada some do histórico', async () => {
    const abriuCaixa = await auth(request(app).post('/api/caixa/abrir')).send({ valor_abertura: 0, nome: 'Caixa Exclusão' });
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Excluir Teste' });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/itens`)).send({
      nome_produto: 'Item qualquer', quantidade: 1, preco_unitario: 10,
    });
    await auth(request(app).post(`/api/comandas/${comanda.body.id}/fechar`)).send({
      caixa_id: abriuCaixa.body.id, forma_pagamento: 'Dinheiro',
    });

    const excluiu = await comoGerente(request(app).delete(`/api/comandas/${comanda.body.id}`));
    expect(excluiu.status).toBe(200);

    const buscou = await auth(request(app).get(`/api/comandas/${comanda.body.id}`));
    expect(buscou.status).toBe(404);
  });

  test('não deixa excluir uma comanda ainda aberta (precisa fechar/cancelar antes)', async () => {
    const comanda = await auth(request(app).post('/api/comandas')).send({ identificador: 'Excluir Aberta' });
    const excluiu = await comoGerente(request(app).delete(`/api/comandas/${comanda.body.id}`));
    expect(excluiu.status).toBe(400);
  });
});
