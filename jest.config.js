module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/tests/**/*.test.js'],
  // Sequencial (não paralelo): vários arquivos rodando a lista inteira de migrations
  // ao mesmo tempo no MESMO banco de teste trava por lock de metadados (mesmo problema
  // já documentado dentro do próprio src/index.js) — mais devagar, mas sem flakiness.
  maxWorkers: 1,
  testTimeout: 20000,
};
