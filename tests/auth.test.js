const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium } = require('./helpers/fixtures');

describe('Autenticação (dono da padaria)', () => {
  let app;
  beforeAll(async () => { app = await appPronto(); });

  test('registrar + login com a senha certa funciona', async () => {
    const { email } = await criarPadariaPremium(app, request);
    const login = await request(app).post('/api/auth/login').send({ email, senha: 'senha12345' });
    expect(login.status).toBe(200);
    expect(login.body.token).toBeTruthy();
    expect(login.body.padaria.plano).toBe('premium');
  });

  test('login com senha errada é rejeitado', async () => {
    const { email } = await criarPadariaPremium(app, request);
    const login = await request(app).post('/api/auth/login').send({ email, senha: 'senha-errada' });
    expect(login.status).toBe(401);
  });

  test('rota protegida sem token é rejeitada', async () => {
    const r = await request(app).get('/api/produtos');
    expect(r.status).toBe(401);
  });

  test('rota protegida com token inválido é rejeitada', async () => {
    const r = await request(app).get('/api/produtos').set('Authorization', 'Bearer token-invalido');
    expect(r.status).toBe(401);
  });

  test('rota protegida com token válido funciona', async () => {
    const { token } = await criarPadariaPremium(app, request);
    const r = await request(app).get('/api/produtos').set('Authorization', `Bearer ${token}`);
    expect(r.status).toBe(200);
    expect(Array.isArray(r.body)).toBe(true);
  });
});
