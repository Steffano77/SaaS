const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

// Sem GAVETA_CAIXA_N no .env (outra loja, nuvem, teste), a rota avisa "sem_config" e a
// tela cai no jeito antigo de abrir a gaveta — nunca pode quebrar a venda.
describe('Abrir gaveta pelo servidor', () => {
  test('caixa sem impressora configurada responde sem_config', async () => {
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const r = await request(app).post('/api/gaveta/abrir').set('Authorization', `Bearer ${token}`).send({ caixa_nome: 'Caixa 1' });
    expect(r.status).toBe(404);
    expect(r.body.sem_config).toBe(true);
  });
});
