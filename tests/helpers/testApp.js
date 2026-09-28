// Carrega o .env.test ANTES de tudo (sobrescrevendo qualquer coisa que já esteja em
// process.env), pra garantir que src/index.js conecta no banco de TESTE, nunca no real.
require('dotenv').config({ path: require('path').join(__dirname, '../../.env.test'), override: true });

const request = require('supertest');

let appProntoPromise = null;

// Garante que o app só é montado (e as migrations só rodam) uma vez por arquivo de
// teste, mesmo que vários testes desse arquivo chamem essa função.
function appPronto() {
  if (!appProntoPromise) {
    const { app, migracoesProntas } = require('../../src/index.js');
    appProntoPromise = migracoesProntas.then(() => app);
  }
  return appProntoPromise;
}

module.exports = { appPronto, request };
