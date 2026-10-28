const crypto = require('crypto');
const db = require('../../src/database/connection');

// Cria uma padaria nova de teste (plano premium, pra liberar Comandas/Caixa/Faturado)
// e já loga, devolvendo o token pronto pra usar. Cada chamada usa um email/código
// únicos, então testes podem rodar em paralelo sem pisar um no outro.
async function criarPadariaPremium(app, request) {
  const sufixo = `${Date.now()}_${crypto.randomBytes(4).toString('hex')}`;
  const codigo = `TESTE${sufixo}`.toUpperCase().slice(0, 32);
  await db.query(
    "INSERT INTO codigos_ativacao (codigo, plano, meses) VALUES (?, 'premium', 12)",
    [codigo]
  );
  const email = `teste_${sufixo}@example.com`;
  const registro = await request(app).post('/api/auth/registrar').send({
    nome: 'Padaria Teste Automatizado',
    email,
    senha: 'senha12345',
    codigo,
  });
  if (registro.status !== 201) {
    throw new Error(`Falha ao registrar padaria de teste: ${registro.status} ${JSON.stringify(registro.body)}`);
  }
  // Caixa só abre com operador (papel Caixa + PIN) — cria um pra cada padaria de teste.
  const token = registro.body.token;
  const op = await request(app).post('/api/atendentes').set('Authorization', `Bearer ${token}`)
    .send({ nome: 'Operador Teste', pin: '4321', role: 'caixa' });
  if (op.status !== 201) throw new Error(`Falha ao criar operador de teste: ${op.status} ${JSON.stringify(op.body)}`);
  operadores.set(token, { atendente_id: op.body.id, pin: '4321' });
  return { token, padaria: registro.body.padaria, email };
}

// Campos de operador pra mandar junto no /api/caixa/abrir dos testes.
const operadores = new Map();
function opCaixa(token) { return operadores.get(token) || {}; }

module.exports = { criarPadariaPremium, opCaixa };
