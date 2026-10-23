// Abre a gaveta de dinheiro mandando o comando ESC/POS direto pra impressora térmica do
// caixa (scripts/abrir-gaveta.ps1), sem imprimir nada. Assim o driver da impressora pode
// ficar SEM "abrir gaveta a cada impressão" — antes a gaveta abria até em venda no cartão,
// porque qualquer cupom impresso abria ela junto.
// Qual impressora é de qual caixa vem do .env (só existe no servidor da loja, Windows):
//   GAVETA_CAIXA_1=\\DESKTOP-98CNNAE\imp
//   GAVETA_CAIXA_2=\\localhost\IMP   (compartilhamento = caminho rápido; nome local = PowerShell)
const path = require('path');
const { execFile } = require('child_process');

const SCRIPT = path.join(__dirname, '../../scripts/abrir-gaveta.ps1');

function impressoraDoCaixa(nomeCaixa) {
  const numero = String(nomeCaixa || '').match(/\d+/)?.[0];
  return numero ? (process.env[`GAVETA_CAIXA_${numero}`] || '').trim() : '';
}

// Pulso ESC/POS de abrir gaveta (ESC p 0 25 250).
const PULSO = Buffer.from([0x1B, 0x70, 0x00, 0x19, 0xFA]);
// Um envio por impressora de cada vez: se a impressora/rede estiver lenta, não empilha
// comandos na fila (foi isso que, com o cabo de rede solto, abriu a gaveta várias vezes
// seguidas quando a rede voltou).
const emAndamento = new Set();

function comTimeout(promessa, ms) {
  return Promise.race([promessa, new Promise((_, rej) => setTimeout(() => rej(new Error(`demorou mais de ${ms}ms`)), ms))]);
}

// Caminho rápido: impressora compartilhada (\\PC\nome) recebe o comando gravado direto
// no compartilhamento, igual "copy /b" — sem abrir PowerShell (que levava segundos).
function viaCompartilhamento(impressora) {
  return comTimeout(require('fs').promises.writeFile(impressora, PULSO), 5000);
}

// Caminho antigo (nome de impressora local, ex: POS-80C): PowerShell + spooler RAW.
function viaPowershell(impressora) {
  return new Promise((resolve, reject) => {
    execFile('powershell', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', SCRIPT, '-Impressora', impressora],
      { timeout: 15000, windowsHide: true },
      (erro, stdout, stderr) => {
        const saida = String(stdout || '').trim();
        if (saida === 'OK') return resolve();
        reject(new Error(saida || String(stderr || '').trim() || erro?.message || 'falhou'));
      });
  });
}

exports.abrir = async (req, res) => {
  const impressora = impressoraDoCaixa(req.body.caixa_nome);
  // Sem configuração (ex: outra loja, ou servidor na nuvem): a tela cai no jeito antigo.
  if (!impressora || process.platform !== 'win32') {
    return res.status(404).json({ erro: 'Gaveta direta não configurada pra esse caixa.', sem_config: true });
  }
  if (emAndamento.has(impressora)) return res.json({ ok: true, ja_em_andamento: true });
  emAndamento.add(impressora);
  const inicio = Date.now();
  try {
    if (impressora.startsWith('\\\\')) {
      try { await viaCompartilhamento(impressora); }
      catch (e) {
        console.error(`[gaveta] Compartilhamento falhou (${impressora}): ${e.message} — tentando pelo PowerShell`);
        await viaPowershell(impressora);
      }
    } else {
      await viaPowershell(impressora);
    }
    res.json({ ok: true, ms: Date.now() - inicio });
  } catch (e) {
    console.error(`[gaveta] Falha ao abrir (${req.body.caixa_nome} -> ${impressora}): ${e.message}`);
    res.status(502).json({ erro: `Não consegui abrir a gaveta: ${e.message}` });
  } finally {
    emAndamento.delete(impressora);
  }
};
