// Abre a gaveta de dinheiro mandando o comando ESC/POS direto pra impressora térmica do
// caixa (scripts/abrir-gaveta.ps1), sem imprimir nada. Assim o driver da impressora pode
// ficar SEM "abrir gaveta a cada impressão" — antes a gaveta abria até em venda no cartão,
// porque qualquer cupom impresso abria ela junto.
// Qual impressora é de qual caixa vem do .env (só existe no servidor da loja, Windows):
//   GAVETA_CAIXA_1=\\DESKTOP-98CNNAE\imp
//   GAVETA_CAIXA_2=POS-80C
const path = require('path');
const { execFile } = require('child_process');

const SCRIPT = path.join(__dirname, '../../scripts/abrir-gaveta.ps1');

function impressoraDoCaixa(nomeCaixa) {
  const numero = String(nomeCaixa || '').match(/\d+/)?.[0];
  return numero ? (process.env[`GAVETA_CAIXA_${numero}`] || '').trim() : '';
}

exports.abrir = (req, res) => {
  const impressora = impressoraDoCaixa(req.body.caixa_nome);
  // Sem configuração (ex: outra loja, ou servidor na nuvem): a tela cai no jeito antigo.
  if (!impressora || process.platform !== 'win32') {
    return res.status(404).json({ erro: 'Gaveta direta não configurada pra esse caixa.', sem_config: true });
  }
  execFile('powershell', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', SCRIPT, '-Impressora', impressora],
    { timeout: 15000, windowsHide: true },
    (erro, stdout) => {
      const saida = String(stdout || '').trim();
      if (erro || saida !== 'OK') {
        console.error(`[gaveta] Falha ao abrir (${req.body.caixa_nome} -> ${impressora}):`, saida || erro?.message);
        return res.status(502).json({ erro: `Não consegui abrir a gaveta: ${saida || erro?.message}` });
      }
      res.json({ ok: true });
    });
};
