// Teste do jeito RÁPIDO de abrir a gaveta: o Node grava o comando ESC/POS direto no
// compartilhamento da impressora (igual "copy /b arquivo \\PC\impressora"), sem abrir
// PowerShell. Mede quanto tempo leva.
// Uso: node scripts\testar-gaveta.js \\DESKTOP-98CNNAE\imp     (ou \\localhost\IMP)
const fs = require('fs');
const alvo = process.argv[2];
if (!alvo) { console.log('Uso: node scripts\\testar-gaveta.js \\\\PC\\compartilhamento'); process.exit(1); }
const inicio = Date.now();
fs.writeFile(alvo, Buffer.from([0x1B, 0x70, 0x00, 0x19, 0xFA]), (erro) => {
  const ms = Date.now() - inicio;
  if (erro) { console.log(`ERRO em ${ms}ms: ${erro.code || ''} ${erro.message}`); process.exit(1); }
  console.log(`OK em ${ms}ms`);
});
