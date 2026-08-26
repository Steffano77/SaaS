const API = '/api';

// Força logout via ?logout=1 (usado no e-mail de boas-vindas)
(function() {
  if (new URLSearchParams(window.location.search).get('logout') === '1') {
    localStorage.removeItem('pptoken');
    sessionStorage.removeItem('pptoken');
    window.location.replace('/');
  }
})();

let TOKEN = localStorage.getItem('pptoken') || sessionStorage.getItem('pptoken') || '';
let PLANO_ATUAL = '';
let ROLE_ATUAL = '';
let todosProds = [];
let _prodFornecedorMap = {}; // produto_id → nome do fornecedor

// ── Redefinição de senha via link ───────────────────────────────
(function() {
  const params = new URLSearchParams(window.location.search);

  const resetToken = params.get('token');
  if (resetToken && window.location.pathname.includes('redefinir-senha')) {
    document.getElementById('tela-auth').classList.add('hidden');
    document.getElementById('tela-redefinir').classList.remove('hidden');
    window._resetToken = resetToken;
  }
  // Abre aba de cadastro via ?cadastro=1
  if (params.get('cadastro') === '1' && !TOKEN) {
    window.addEventListener('DOMContentLoaded', () => mostrarTab('registro'));
  }
  // Reset de PIN via link de e-mail — salva token para processar após login
  const resetPinToken = params.get('reset_pin');
  if (resetPinToken) {
    sessionStorage.setItem('pp_reset_pin_token', resetPinToken);
    window.history.replaceState({}, '', '/');
  }
  // Modo Balcão (tablet do caixa) — ?balcao=1 trava a tela só em Comandas.
  // Fica salvo no aparelho; usar ?balcao=0 uma vez pra desativar.
  if (params.get('balcao') === '1') localStorage.setItem('pp_modo_balcao', '1');
  if (params.get('balcao') === '0') localStorage.removeItem('pp_modo_balcao');
  // Modo Lançamento (tablet do salão) — ?lancamento=1 esconde cobrança e controle de caixa,
  // só permite abrir comanda e lançar itens. A cobrança fica só nos PCs do caixa.
  if (params.get('lancamento') === '1') localStorage.setItem('pp_modo_lancamento', '1');
  if (params.get('lancamento') === '0') localStorage.removeItem('pp_modo_lancamento');
})();
const MODO_BALCAO = localStorage.getItem('pp_modo_balcao') === '1';
const MODO_LANCAMENTO = localStorage.getItem('pp_modo_lancamento') === '1';

// ── Aparelho fixado pro login de caixa ────────────────────────────
// Quando fixado (configurado uma vez em "Este aparelho" com login de dono),
// esse aparelho específico mostra direto a tela de login simples (nome+PIN)
// em vez do login normal — sem precisar de e-mail/senha de dono toda vez.
const APARELHO_FIXADO_ID = localStorage.getItem('pp_aparelho_fixado_id');
const APARELHO_FIXADO_NOME = localStorage.getItem('pp_aparelho_fixado_nome');
// Função própria (em vez de só preencher uma vez no carregamento) porque essa tela
// também reaparece depois de "Sair" — sem isso, o nome da padaria ficava em
// branco na segunda vez que a tela era mostrada (bug real, achado em teste).
function mostrarTelaLoginCaixa() {
  document.getElementById('tela-auth').classList.add('hidden');
  document.getElementById('tela-login-caixa').classList.remove('hidden');
  const elNome = document.getElementById('login-caixa-padaria-nome');
  if (elNome) elNome.textContent = localStorage.getItem('pp_aparelho_fixado_nome') || '';
}
if (APARELHO_FIXADO_ID && !TOKEN) {
  window.addEventListener('DOMContentLoaded', mostrarTelaLoginCaixa);
}
// Ativado por padrão em todo aparelho — só desativa se a pessoa desmarcar
// explicitamente em "Este aparelho" (aí salva '0' no lugar de simplesmente apagar).
const TELA_CHEIA_AUTO = localStorage.getItem('pp_tela_cheia_auto') !== '0';

// ── Tela cheia automática (por aparelho) ──────────────────────────
// Entra em tela cheia especificamente ao clicar em "Comandas" no menu — pra se
// comportar feito um app de verdade, sem sair sozinho por acidente (só com Esc).
function entrarTelaCheiaSeAtivo() {
  if (!TELA_CHEIA_AUTO) return;
  if (!document.fullscreenElement && document.documentElement.requestFullscreen) {
    document.documentElement.requestFullscreen().catch(() => {});
  }
}

// ── Dark Mode ──────────────────────────────────────────────────
(function() {
  const saved = localStorage.getItem('pp-theme');
  if (saved === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    _setThemeIcons('dark');
  }
})();

function _setThemeIcons(theme) {
  const emoji = theme === 'dark' ? '☀️' : '🌙';
  ['auth','redef','mobile','sidebar','exp'].forEach(id => {
    const el = document.getElementById('icon-theme-' + id);
    if (el) el.textContent = emoji;
  });
  const label = document.getElementById('theme-toggle-label');
  if (label) label.textContent = theme === 'dark' ? 'Modo claro' : 'Modo escuro';
}

function togglePass(inputId, btn) {
  const input = document.getElementById(inputId);
  const showing = input.type === 'text';
  input.type = showing ? 'password' : 'text';
  btn.querySelector('.eye-open').classList.toggle('hidden', !showing);
  btn.querySelector('.eye-off').classList.toggle('hidden', showing);
}

// Configuração do aparelho — alternativa mais amigável aos links ?balcao=1&lancamento=1
function abrirModalConfigAparelho() {
  document.getElementById('cfg-modo-balcao').checked = MODO_BALCAO;
  document.getElementById('cfg-modo-lancamento').checked = MODO_LANCAMENTO;
  document.getElementById('cfg-tela-cheia').checked = TELA_CHEIA_AUTO;
  const fixado = !!APARELHO_FIXADO_ID;
  document.getElementById('bloco-fixar-caixa-off').classList.toggle('hidden', fixado);
  document.getElementById('bloco-fixar-caixa-on').classList.toggle('hidden', !fixado);
  if (fixado) document.getElementById('fixar-caixa-nome-atual').textContent = APARELHO_FIXADO_NOME || '';
  document.getElementById('modal-config-aparelho').classList.remove('hidden');
}

async function fixarAparelhoParaCaixa() {
  const perfil = await api('/auth/perfil');
  if (!perfil) return;
  if (!(await confirmarBonito(`Fixar este aparelho pra "${perfil.nome}"? A partir de agora, ele vai mostrar direto o login de caixa (nome + PIN) em vez do login normal.`))) return;
  localStorage.setItem('pp_aparelho_fixado_id', perfil.id);
  localStorage.setItem('pp_aparelho_fixado_nome', perfil.nome);
  // Sem isso, a sessão de dono continuaria "logada" e o recarregamento cairia
  // direto no sistema completo de novo — a fixação só valeria na próxima vez
  // que essa sessão expirasse. Desloga na hora pra já passar pela tela de caixa.
  localStorage.removeItem('pptoken');
  sessionStorage.removeItem('pptoken');
  location.reload();
}

function desfixarAparelhoCaixa(semConfirmar) {
  const feito = () => {
    localStorage.removeItem('pp_aparelho_fixado_id');
    localStorage.removeItem('pp_aparelho_fixado_nome');
    sessionStorage.removeItem('pp_modo_caixa_restrito');
    location.reload();
  };
  if (semConfirmar) { feito(); return; }
  confirmarBonito('Desfazer a fixação desse aparelho? Ele volta a pedir login normal de dono.').then(ok => { if (ok) feito(); });
}

async function fazerLoginCaixa(e) {
  e.preventDefault();
  const el = document.getElementById('erro-login-caixa');
  el.classList.add('hidden');
  try {
    const r = await fetch(`${API}/auth/login-caixa`, {
      method: 'POST', headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        padaria_id: APARELHO_FIXADO_ID,
        nome: document.getElementById('login-caixa-nome').value,
        pin: document.getElementById('login-caixa-pin').value,
      })
    });
    const d = await r.json();
    if (!r.ok) { el.textContent = d.erro; el.classList.remove('hidden'); return; }
    TOKEN = d.token;
    sessionStorage.setItem('pptoken', TOKEN); // sessão de caixa não fica "lembrada" além do turno
    // Guarda o papel do atendente pra restringir a interface (só Comandas, sem menu completo).
    sessionStorage.setItem('pp_modo_caixa_restrito', d.atendente?.role || 'atendente');
    document.getElementById('sidebar-nome').textContent = d.padaria.nome;
    const _planoLabelsCx = { trial: '⏳ Trial', essencial: '⚡ Essencial', pro: '⭐ Pro', premium: '💎 Premium' };
    const _planoElCx = document.getElementById('sidebar-plano');
    if (_planoElCx) _planoElCx.textContent = _planoLabelsCx[d.padaria.plano] || d.padaria.plano || '—';
    atualizarAvisoExpiracao(d.padaria.plano, d.padaria.plano_expira_em);
    PLANO_ATUAL = d.padaria.plano || 'trial';
    ROLE_ATUAL = d.padaria.role || 'user';
    document.getElementById('tela-login-caixa').classList.add('hidden');
    entrar();
  } catch { el.textContent = 'Erro de conexão.'; el.classList.remove('hidden'); }
}

// Restringe o menu lateral quando logado em modo caixa (aparelho fixado) — só
// deixa visível Comandas e Sair, e já abre direto na tela de Comandas.
function aplicarRestricaoModoCaixa() {
  const papel = sessionStorage.getItem('pp_modo_caixa_restrito');
  if (!papel) return;
  document.querySelectorAll('.sidebar-nav > .sidebar-link, .sidebar-nav > div').forEach(el => {
    const texto = el.textContent || '';
    if (!texto.includes('Comandas')) el.classList.add('hidden');
  });
  mostrarPagina('comandas', false);
  entrarTelaCheiaSeAtivo();
}

function salvarConfigAparelho() {
  const balcao = document.getElementById('cfg-modo-balcao').checked;
  const lancamento = document.getElementById('cfg-modo-lancamento').checked;
  const telaCheia = document.getElementById('cfg-tela-cheia').checked;
  if (balcao) localStorage.setItem('pp_modo_balcao', '1'); else localStorage.removeItem('pp_modo_balcao');
  if (lancamento) localStorage.setItem('pp_modo_lancamento', '1'); else localStorage.removeItem('pp_modo_lancamento');
  if (telaCheia) localStorage.removeItem('pp_tela_cheia_auto'); else localStorage.setItem('pp_tela_cheia_auto', '0');
  location.reload();
}

function toggleTheme() {
  const html = document.documentElement;
  const isDark = html.getAttribute('data-theme') === 'dark';
  const next = isDark ? 'light' : 'dark';
  if (next === 'dark') html.setAttribute('data-theme', 'dark');
  else html.removeAttribute('data-theme');
  localStorage.setItem('pp-theme', next);
  _setThemeIcons(next);
}

// ── Auth ────────────────────────────────────────────────────
function mostrarTab(tab) {
  document.getElementById('form-login').classList.toggle('hidden', tab !== 'login');
  document.getElementById('form-registro').classList.toggle('hidden', tab !== 'registro');
  document.getElementById('tab-login').className   = tab === 'login'    ? 'tab-btn active' : 'tab-btn';
  document.getElementById('tab-registro').className = tab === 'registro' ? 'tab-btn active' : 'tab-btn';
}

function mostrarEsqueciSenha(e) {
  e.preventDefault();
  document.getElementById('form-login').classList.add('hidden');
  document.getElementById('form-esqueci').classList.remove('hidden');
  document.querySelector('.tabs-auth')?.classList.add('hidden');
  setTimeout(() => { document.getElementById('esqueci-email').value = ''; }, 200);
}

function voltarLogin() {
  document.getElementById('form-esqueci').classList.add('hidden');
  document.getElementById('form-login').classList.remove('hidden');
  document.querySelector('.tabs-auth').classList.remove('hidden');
}

async function enviarRecuperacao() {
  const email = document.getElementById('esqueci-email').value.trim();
  const msg = document.getElementById('esqueci-msg');
  if (!email) {
    msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
    msg.textContent = '❌ Digite seu email antes de continuar.';
    msg.classList.remove('hidden');
    return;
  }
  msg.className = '';
  msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#eff6ff;color:#1e40af;border:1px solid #bfdbfe;';
  msg.textContent = 'Enviando...';
  msg.classList.remove('hidden');
  try {
    const r = await fetch(`${API}/auth/esqueci-senha`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email })
    });
    const data = await r.json().catch(() => ({}));
    if (r.ok) {
      msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;';
      msg.textContent = '✅ Se este email estiver cadastrado, você receberá o link em instantes.';
    } else if (r.status === 429) {
      msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#fff7ed;color:#9a3412;border:1px solid #fed7aa;';
      msg.textContent = '⏳ Muitas tentativas. Aguarde 1 hora e tente novamente.';
    } else {
      msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
      msg.textContent = '❌ ' + (data.erro || 'Erro ao enviar. Tente novamente.');
    }
  } catch(e) {
    msg.style.cssText = 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
    msg.textContent = '❌ Sem conexão com o servidor. Tente novamente.';
  }
}

async function confirmarRedefinicao() {
  const senha    = document.getElementById('redef-senha').value;
  const confirma = document.getElementById('redef-confirma').value;
  const msg      = document.getElementById('redef-msg');

  const mostrar = (texto, ok) => {
    msg.style.cssText = ok
      ? 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;'
      : 'font-size:13px;padding:10px 14px;border-radius:8px;margin-bottom:14px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
    msg.textContent = texto;
    msg.classList.remove('hidden');
  };

  if (!senha) return mostrar('❌ Digite a nova senha.', false);
  if (senha.length < 6) return mostrar('❌ A senha precisa ter pelo menos 6 caracteres.', false);
  if (senha !== confirma) return mostrar('❌ As senhas não coincidem.', false);

  try {
    const r = await fetch(`${API}/auth/redefinir-senha`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ token: window._resetToken, senha })
    });
    const data = await r.json().catch(() => ({}));
    if (r.ok) {
      mostrar('✅ Senha alterada com sucesso! Redirecionando...', true);
      setTimeout(() => {
        window.location.href = '/';
      }, 2000);
    } else {
      mostrar('❌ ' + (data.erro || 'Link inválido ou expirado. Solicite um novo.'), false);
    }
  } catch {
    mostrar('❌ Sem conexão com o servidor. Tente novamente.', false);
  }
}

async function fazerLogin(e) {
  e.preventDefault();
  const el = document.getElementById('erro-login');
  el.classList.add('hidden');
  try {
    const r = await fetch(`${API}/auth/login`, {
      method: 'POST', headers: {'Content-Type':'application/json'},
      body: JSON.stringify({ email: document.getElementById('login-email').value, senha: document.getElementById('login-senha').value })
    });
    const d = await r.json();
    if (!r.ok) {
      el.innerHTML = d.erro + '<br><a href="#" onclick="mostrarTab(\'registro\');return false;" style="color:#f97316;font-weight:600;font-size:13px;">Não tem conta? Criar conta →</a>';
      el.classList.remove('hidden');
      return;
    }
    TOKEN = d.token;
    const manter = document.getElementById('manter-logado')?.checked !== false;
    if (manter) localStorage.setItem('pptoken', TOKEN);
    else { localStorage.removeItem('pptoken'); sessionStorage.setItem('pptoken', TOKEN); }
    document.getElementById('sidebar-nome').textContent = d.padaria.nome;
    const _planoLabels = { trial: '⏳ Trial', essencial: '⚡ Essencial', pro: '⭐ Pro', premium: '💎 Premium' };
    const _planoEl = document.getElementById('sidebar-plano');
    if (_planoEl) _planoEl.textContent = _planoLabels[d.padaria.plano] || d.padaria.plano || '—';
    atualizarAvisoExpiracao(d.padaria.plano, d.padaria.plano_expira_em);
    PLANO_ATUAL = d.padaria.plano || 'trial';
    if (d.padaria.role === 'admin') document.getElementById('nav-admin').classList.remove('hidden');
    entrar();
  } catch { el.textContent = 'Erro de conexão.'; el.classList.remove('hidden'); }
}

async function verificarCodigo(valor) {
  const status = document.getElementById('codigo-status');
  const codigo = valor.trim().toUpperCase();
  if (codigo.length < 10) { status.textContent = ''; return; }
  status.style.color = 'var(--slate-400)';
  status.textContent = 'Verificando...';
  try {
    const r = await fetch(`${API}/auth/verificar-codigo/${encodeURIComponent(codigo)}`);
    const d = await r.json();
    if (d.valido) {
      const planoLabel = { essencial: 'Essencial', pro: 'Pro', premium: 'Premium' }[d.plano] || d.plano;
      const duracao = d.dias ? `${d.dias} dia${d.dias === 1 ? '' : 's'}` : `${d.meses || 1} ${(d.meses || 1) === 1 ? 'mês' : 'meses'}`;
      status.style.color = '#16a34a';
      status.textContent = `✅ Código válido — Plano ${planoLabel} por ${duracao}`;
    } else {
      status.style.color = '#dc2626';
      status.textContent = '❌ Código inválido ou já utilizado';
    }
  } catch { status.textContent = ''; }
}

async function fazerRegistro(e) {
  e.preventDefault();
  const el = document.getElementById('erro-registro');
  el.classList.add('hidden');
  try {
    const r = await fetch(`${API}/auth/registrar`, {
      method: 'POST', headers: {'Content-Type':'application/json'},
      body: JSON.stringify({
        nome:   document.getElementById('reg-nome').value,
        email:  document.getElementById('reg-email').value,
        senha:  document.getElementById('reg-senha').value,
        codigo: document.getElementById('reg-codigo').value.trim().toUpperCase()
      })
    });
    const d = await r.json();
    if (!r.ok) { el.textContent = d.erro; el.classList.remove('hidden'); return; }
    TOKEN = d.token;
    localStorage.setItem('pptoken', TOKEN);
    document.getElementById('sidebar-nome').textContent = d.padaria.nome;
    const _planoLabelsReg = { trial: '⏳ Trial', essencial: '⚡ Essencial', pro: '⭐ Pro', premium: '💎 Premium' };
    const _planoElReg = document.getElementById('sidebar-plano');
    if (_planoElReg) _planoElReg.textContent = _planoLabelsReg[d.padaria.plano] || d.padaria.plano || '—';
    atualizarAvisoExpiracao(d.padaria.plano, d.padaria.plano_expira_em);
    PLANO_ATUAL = d.padaria.plano || 'trial';
    ROLE_ATUAL = d.padaria.role || 'user';
    if (d.padaria.role === 'admin') document.getElementById('nav-admin').classList.remove('hidden');
    entrar();
  } catch { el.textContent = 'Erro de conexão.'; el.classList.remove('hidden'); }
}

function entrar() {
  document.getElementById('tela-auth').classList.add('hidden');
  document.getElementById('tela-plano-expirado')?.classList.add('hidden');
  document.getElementById('app').classList.remove('hidden');
  document.getElementById('app').classList.add('flex');
  renderizarFaixaImpersonando();
  aplicarRestricaoModoCaixa();

  const resetPinToken = sessionStorage.getItem('pp_reset_pin_token');
  if (resetPinToken) {
    sessionStorage.removeItem('pp_reset_pin_token');
    history.replaceState({ pg: 'financeiro' }, '', '#financeiro');
    mostrarPagina('financeiro', false);
    setTimeout(() => confirmarResetPin(resetPinToken), 600);
    return;
  }

  if (MODO_BALCAO || MODO_LANCAMENTO) {
    aplicarModoBalcao();
    history.replaceState({ pg: 'comandas' }, '', '#comandas');
    mostrarPagina('comandas', false);
    return;
  }

  history.replaceState({ pg: 'dashboard' }, '', '#dashboard');
  mostrarPagina('dashboard', false);
  setTimeout(verificarOnboarding, 800);
}

// Modo Balcão: esconde tudo da barra lateral, exceto Comandas e Sair.
function aplicarModoBalcao() {
  document.querySelectorAll('.sidebar-link').forEach(el => {
    const onclick = el.getAttribute('onclick') || '';
    // Esconde os links de navegação de página que não sejam Comandas, e a configuração
    // do aparelho (pra quem está no balcão não conseguir reconfigurar o tablet sozinho).
    // Mantém visível "Sair" e qualquer outro botão que não se encaixe nesses casos.
    if ((onclick.includes('mostrarPagina') && !onclick.includes("'comandas'")) || onclick.includes('abrirModalConfigAparelho')) {
      el.style.display = 'none';
    }
  });
  document.getElementById('nav-admin')?.classList.add('hidden');
  // Esconde o botão de relatório de vendas na tela de Comandas (só o PC do caixa deve ver isso)
  document.querySelectorAll('[onclick="abrirRelatorioVendas()"]').forEach(el => el.style.display = 'none');
  // Evita duplicar o aviso se essa função rodar mais de uma vez na mesma sessão (ex: login de novo sem recarregar a página).
  document.querySelectorAll('.cmd-aviso-modo-balcao').forEach(el => el.remove());
  const aviso = document.createElement('div');
  aviso.className = 'cmd-aviso-modo-balcao';
  aviso.style.cssText = 'padding:8px 14px;font-size:11px;color:var(--slate-400);text-align:center;cursor:pointer;';
  aviso.textContent = MODO_LANCAMENTO ? '📋 Modo Lançamento' : '🔒 Modo Balcão';
  aviso.title = 'Toque pra reconfigurar este aparelho';
  aviso.onclick = abrirModalConfigAparelho;
  document.querySelector('.sidebar-nav')?.prepend(aviso);
}

function atualizarAvisoExpiracao(plano, planoExpiraEm) {
  const el = document.getElementById('sidebar-plano-expira');
  if (!el) return;
  if (!planoExpiraEm) { el.classList.add('hidden'); return; }
  const dataStr = String(planoExpiraEm).slice(0, 10); // aceita "YYYY-MM-DD" ou ISO completo
  const hoje = new Date(); hoje.setHours(0,0,0,0);
  const expira = new Date(dataStr + 'T00:00:00');
  if (isNaN(expira.getTime())) { el.classList.add('hidden'); return; }
  const dias = Math.round((expira - hoje) / 86400000);
  if (dias < 0) {
    el.textContent = '🔴 Licença expirada';
    el.style.color = '#dc2626';
  } else if (dias === 0) {
    el.textContent = '🔴 Expira hoje';
    el.style.color = '#dc2626';
  } else if (dias <= 7) {
    el.textContent = `⏳ Expira em ${dias} dia${dias === 1 ? '' : 's'}`;
    el.style.color = dias <= 3 ? '#dc2626' : '#d97706';
  } else {
    el.textContent = `Válido até ${expira.toLocaleDateString('pt-BR')}`;
    el.style.color = 'var(--slate-400)';
  }
  el.classList.remove('hidden');
}

function mostrarUpgrade(pg, planoNecessario) {
  fecharSidebar();
  const nomes = { financeiro: 'Financeiro', relatorios: 'Relatórios', fichas: 'Fichas de Produção', producao: 'Módulo de Produção' };
  paginas.forEach(p => document.getElementById(`pg-${p}`).classList.toggle('hidden', p !== pg));
  document.querySelectorAll('.sidebar-link').forEach((el, i) => el.classList.toggle('active', paginas[i] === pg));
  history.replaceState({ pg }, '', `#${pg}`);
  const container = document.getElementById(`pg-${pg}`);
  container.innerHTML = `
    <div style="display:flex;flex-direction:column;align-items:center;justify-content:center;min-height:60vh;text-align:center;padding:32px">
      <div style="font-size:52px;margin-bottom:16px">🔒</div>
      <h2 style="font-size:22px;font-weight:800;margin-bottom:8px">${nomes[pg] || pg} — Plano ${planoNecessario}</h2>
      <p style="color:var(--slate-500);max-width:380px;line-height:1.6;margin-bottom:28px">
        Esta funcionalidade está disponível a partir do plano <strong>${planoNecessario}</strong>.<br>
        Faça upgrade para desbloquear o acesso completo.
      </p>
      <button onclick="mostrarPagina('planos')" style="background:linear-gradient(135deg,#f97316,#ea580c);color:#fff;border:none;padding:13px 32px;border-radius:12px;font-size:15px;font-weight:700;cursor:pointer;box-shadow:0 4px 16px rgba(249,115,22,.35)">
        Ver planos e fazer upgrade →
      </button>
    </div>`;
}

function mostrarTelaPlanoExpirado() {
  document.getElementById('app').classList.add('hidden');
  document.getElementById('tela-auth').classList.add('hidden');
  document.getElementById('tela-plano-expirado').classList.remove('hidden');
}

function sair() {
  TOKEN = '';
  localStorage.removeItem('pptoken');
  sessionStorage.removeItem('pptoken');
  sessionStorage.removeItem('pp_modo_caixa_restrito');
  document.getElementById('app').classList.add('hidden');
  // Aparelho fixado pro caixa: volta pro login simples (nome+PIN), não pro
  // login de dono — é assim que o "próximo turno" troca de atendente.
  if (APARELHO_FIXADO_ID) {
    mostrarTelaLoginCaixa();
    document.getElementById('login-caixa-nome').value = '';
    document.getElementById('login-caixa-pin').value = '';
    return;
  }
  document.getElementById('tela-auth').classList.remove('hidden');
  // Limpa campos de login
  const em = document.getElementById('login-email');
  const pw = document.getElementById('login-senha');
  em.value = ''; em.setAttribute('readonly', '');
  pw.value = ''; pw.setAttribute('readonly', '');
  // Limpa campos de cadastro
  ['reg-nome','reg-email','reg-senha','reg-codigo'].forEach(id => {
    const el = document.getElementById(id);
    if (el) el.value = '';
  });
  const codigoStatus = document.getElementById('codigo-status');
  if (codigoStatus) codigoStatus.textContent = '';
  const erroReg = document.getElementById('erro-registro');
  if (erroReg) { erroReg.textContent = ''; erroReg.classList.add('hidden'); }
  // Volta para aba de login
  mostrarTab('login');
}

// ── Navegação ───────────────────────────────────────────────
const paginas = ['dashboard','estoque','compras','fornecedores','fichas','producao','relatorios','comandas','encomendas','equipe','financeiro','sync','planos','404'];
const PAGINAS_PRO      = ['relatorios', 'fichas'];
const PAGINAS_PREMIUM  = ['producao', 'financeiro', 'comandas', 'encomendas'];

function mostrarPagina(pg, pushHistory = true) {
  // Modo Balcão/Lançamento: só existe a tela de Comandas
  if ((MODO_BALCAO || MODO_LANCAMENTO) && pg !== 'comandas') pg = 'comandas';
  if (!paginas.includes(pg)) { mostrarPagina('404'); return; }

  // Bloqueio por plano (apenas para usuários não-admin)
  const plano = PLANO_ATUAL || 'essencial';
  if (PAGINAS_PREMIUM.includes(pg) && !['premium'].includes(plano) && plano !== 'admin') {
    mostrarUpgrade(pg, 'Premium');
    return;
  }
  if (PAGINAS_PRO.includes(pg) && !['pro','premium'].includes(plano) && plano !== 'admin') {
    mostrarUpgrade(pg, 'Pro');
    return;
  }

  // Equipe é mais sensível (mexe em quem tem acesso a quê) — pede o PIN toda vez,
  // sem aproveitar os 30 minutos de "liberado" que o Financeiro usa. _pinJaConfirmadoAgora
  // evita reabrir o PIN de novo logo depois de já ter acabado de confirmar (senão entra
  // em loop: confirma o PIN → mostra a página de novo → pede o PIN de novo).
  if (pg === 'financeiro' && !financeiroDesbloqueado()) {
    _paginaAposPin = pg;
    document.getElementById('pin-modal-sub').textContent = 'Digite o PIN de 4 dígitos para acessar o financeiro';
    abrirModalPin();
    return;
  }
  if (pg === 'equipe' && !_pinJaConfirmadoAgora) {
    _paginaAposPin = pg;
    document.getElementById('pin-modal-sub').textContent = 'Digite o PIN de 4 dígitos para acessar a Equipe';
    abrirModalPin();
    return;
  }
  _pinJaConfirmadoAgora = false;
  fecharSidebar();
  paginas.forEach(p => {
    document.getElementById(`pg-${p}`).classList.toggle('hidden', p !== pg);
  });
  document.querySelectorAll('.sidebar-link').forEach((el, i) => {
    el.classList.toggle('active', paginas[i] === pg);
  });
  // Sempre replaceState para não empilhar histórico e evitar gesto nativo do browser
  history.replaceState({ pg }, '', `#${pg}`);
  if (pg === 'dashboard')      carregarDashboard();
  if (pg === 'estoque')        { carregarCategorias(); carregarProdutos(); carregarFiltroFornecedor(); }
  if (pg === 'compras')        { carregarCompras(); }
  if (pg === 'fornecedores')   { carregarFornecedores(); }
  if (pg === 'relatorios')     { carregarRelatorios(); }
  if (pg === 'financeiro')     { carregarFinanceiro(); }
  if (pg === 'fichas')         { carregarFichas(); }
  if (pg === 'producao')       { carregarProducao(); }
  if (pg === 'comandas')       { carregarComandas(); abrirTelaVendaBalcao(); }
  if (pg === 'encomendas')     { carregarEncomendas(); }
  if (pg === 'equipe')         { carregarEquipe(); }
}

// ── PIN Financeiro ───────────────────────────────────────────
const FIN_UNLOCK_MS = 30 * 60 * 1000; // 30 minutos

function financeiroDesbloqueado() {
  const t = sessionStorage.getItem('fin_unlocked_at');
  return t && (Date.now() - parseInt(t)) < FIN_UNLOCK_MS;
}

// Ações sensíveis (cancelar comanda, excluir item) também usam esse mesmo PIN —
// _pinCallback guarda o que fazer depois que o PIN for confirmado com sucesso.
let _pinCallback = null;
let _paginaAposPin = null; // qual página abrir depois de digitar o PIN certo (financeiro ou equipe)
let _pinJaConfirmadoAgora = false; // evita reabrir o PIN de novo logo após confirmar (loop)
function pedirPinPara(callback) {
  if (financeiroDesbloqueado()) { callback(); return; }
  _pinCallback = callback;
  abrirModalPin();
}

function abrirModalPin() {
  ['pin0','pin1','pin2','pin3'].forEach(id => document.getElementById(id).value = '');
  document.getElementById('pin-erro').classList.add('hidden');
  document.querySelectorAll('.pin-input').forEach(el => el.classList.remove('erro'));
  document.getElementById('modal-pin-financeiro').classList.remove('hidden');
  setTimeout(() => document.getElementById('pin0').focus(), 100);
}

function fecharModalPin() {
  document.getElementById('modal-pin-financeiro').classList.add('hidden');
  _pinCallback = null; // se cancelar, não executa a ação sensível pendente
}

// Auto-avançar entre os inputs do PIN
document.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.pin-input').forEach((input, i) => {
    input.addEventListener('input', () => {
      input.value = input.value.replace(/\D/g, '').slice(-1);
      if (input.value && i < 3) document.getElementById(`pin${i+1}`).focus();
      if (i === 3 && input.value) confirmarPin();
    });
    input.addEventListener('keydown', e => {
      if (e.key === 'Backspace' && !input.value && i > 0)
        document.getElementById(`pin${i-1}`).focus();
    });
  });
});

async function confirmarPin() {
  const pin = ['pin0','pin1','pin2','pin3'].map(id => document.getElementById(id).value).join('');
  if (pin.length < 4) return;
  const r = await fetch(`${API}/financeiro/pin`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${TOKEN}` },
    body: JSON.stringify({ pin })
  });
  if (r.ok) {
    sessionStorage.setItem('fin_unlocked_at', Date.now());
    const cb = _pinCallback;
    _pinCallback = null;
    document.getElementById('modal-pin-financeiro').classList.add('hidden');
    if (cb) cb();
    else {
      const destino = _paginaAposPin || 'financeiro';
      _paginaAposPin = null;
      if (destino === 'equipe') _pinJaConfirmadoAgora = true;
      mostrarPagina(destino);
    }
  } else {
    document.getElementById('pin-erro').classList.remove('hidden');
    document.querySelectorAll('.pin-input').forEach(el => {
      el.classList.add('erro');
      el.value = '';
    });
    document.getElementById('pin0').focus();
  }
}

function abrirAlterarPin() {
  fecharModalPin();
  document.getElementById('pin-atual').value = '';
  document.getElementById('pin-novo').value = '';
  const titulo = document.querySelector('#modal-alterar-pin .modal-title');
  if (titulo) titulo.textContent = 'Alterar PIN';
  const labelAtual = document.querySelector('#modal-alterar-pin label');
  if (labelAtual) labelAtual.closest('.form-group').style.display = '';
  document.getElementById('modal-alterar-pin').classList.remove('hidden');
}

function fecharAlterarPin() {
  document.getElementById('modal-alterar-pin').classList.add('hidden');
}

async function salvarPin() {
  const pin_atual = document.getElementById('pin-atual').value;
  const pin_novo  = document.getElementById('pin-novo').value;
  if (!pin_novo) { mostrarToast('Digite o novo PIN.'); return; }
  if (!/^\d{4}$/.test(pin_novo)) { mostrarToast('O novo PIN deve ter exatamente 4 dígitos.'); return; }
  const r = await fetch(`${API}/financeiro/pin`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${TOKEN}` },
    body: JSON.stringify({ pin_atual, pin_novo })
  });
  const d = await r.json();
  if (r.ok) {
    fecharAlterarPin();
    mostrarToast('✅ PIN alterado com sucesso!');
  } else {
    mostrarToast('❌ ' + (d.erro || 'Erro ao alterar PIN.'));
  }
}

async function esqueceuPin() {
  const r = await fetch(`${API}/financeiro/pin/reset`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  if (r.ok) {
    fecharAlterarPin();
    mostrarToast('📧 E-mail enviado! Verifique sua caixa de entrada para redefinir o PIN.');
  } else {
    mostrarToast('❌ Erro ao enviar e-mail. Tente novamente.');
  }
}

async function confirmarResetPin(token) {
  const r = await fetch(`${API}/financeiro/pin/confirmar-reset`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ token })
  });
  if (r.ok) {
    // Abre modal de alterar PIN já com título personalizado
    document.getElementById('pin-atual').value = '';
    document.getElementById('pin-novo').value = '';
    const titulo = document.querySelector('#modal-alterar-pin .modal-title');
    if (titulo) titulo.textContent = 'Insira seu novo PIN';
    const labelAtual = document.querySelector('#modal-alterar-pin label');
    if (labelAtual) labelAtual.closest('.form-group').style.display = 'none';
    document.getElementById('modal-alterar-pin').classList.remove('hidden');
  } else {
    const d = await r.json();
    mostrarToast('❌ ' + (d.erro || 'Link inválido ou expirado.'));
  }
}

document.addEventListener('mousedown', e => {
  const lista = document.getElementById('compra-prod-lista');
  if (!lista) return;
  const item = e.target.closest('[data-prod-id]');
  if (item && lista.contains(item)) {
    e.preventDefault();
    const id = item.dataset.prodId;
    const nome = item.dataset.prodNome;
    const unidade = item.dataset.prodUnidade;
    if (id === '__novo__') selecionarNovoProdutoCompra(nome);
    else selecionarProdutoCompra(id, nome, unidade);
    return;
  }
  const input = document.getElementById('compra-prod-texto');
  if (e.target !== input) lista.classList.add('hidden');
});

document.addEventListener('touchend', e => {
  const lista = document.getElementById('compra-prod-lista');
  if (!lista) return;
  const item = e.target.closest('[data-prod-id]');
  if (item && lista.contains(item)) {
    e.preventDefault();
    const id = item.dataset.prodId;
    const nome = item.dataset.prodNome;
    const unidade = item.dataset.prodUnidade;
    if (id === '__novo__') selecionarNovoProdutoCompra(nome);
    else selecionarProdutoCompra(id, nome, unidade);
  }
});

window.addEventListener('popstate', () => {
  // Swipe back sempre vai para o dashboard, nunca abre modal-sair
  mostrarPagina('dashboard', false);
});

function confirmarSaida() {
  document.getElementById('modal-sair').classList.add('hidden');
  sair();
}

function cancelarSaida() {
  document.getElementById('modal-sair').classList.add('hidden');
}

// ── Toast helper ─────────────────────────────────────────────
function mostrarToast(msg, tipo) {
  let toast = document.getElementById('pp-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'pp-toast';
    toast.style.cssText = 'position:fixed;bottom:24px;left:50%;transform:translateX(-50%);z-index:9999;padding:12px 20px;border-radius:10px;font-size:14px;font-weight:600;font-family:\'Plus Jakarta Sans\',sans-serif;box-shadow:0 4px 16px rgba(0,0,0,0.18);transition:opacity 0.3s;pointer-events:none;';
    document.body.appendChild(toast);
  }
  const cores = {
    ok:   'background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;',
    err:  'background:#fef2f2;color:#991b1b;border:1px solid #fecaca;',
    info: 'background:#eff6ff;color:#1e40af;border:1px solid #bfdbfe;',
  };
  toast.style.cssText += cores[tipo] || cores.info;
  toast.textContent = msg;
  toast.style.opacity = '1';
  clearTimeout(toast._t);
  toast._t = setTimeout(() => { toast.style.opacity = '0'; }, 3500);
}

// ── Modo Resiliente: quedas curtas de internet na tela de venda ──
// Não é modo offline completo — é pra internet "piscar" (Wi-Fi soluçando, alguns
// minutos): continua deixando lançar item na comanda já aberta (guarda localmente
// e sincroniza sozinho quando voltar), mas bloqueia cobrança até confirmar conexão.
let MODO_OFFLINE = false;
let _filaOfflineItens = []; // [{comandaId, produto_id, nome_produto, quantidade, preco_unitario}]

function atualizarFaixaOffline(estado) {
  const faixa = document.getElementById('cmd-pdv-faixa-offline');
  if (!faixa) return;
  const btnsPagamento = document.querySelectorAll('.cmd-pgto-btn, #cmd-btn-finalizar');
  if (estado === 'offline') {
    faixa.className = 'cmd-pdv-faixa-offline offline';
    faixa.textContent = `🔴 Sem conexão — os itens continuam sendo lançados e ficam guardados aqui, sincroniza sozinho quando a internet voltar.${_filaOfflineItens.length ? ` (${_filaOfflineItens.length} pendente${_filaOfflineItens.length > 1 ? 's' : ''})` : ''}`;
    btnsPagamento.forEach(b => b.disabled = true);
  } else if (estado === 'reconectando') {
    faixa.className = 'cmd-pdv-faixa-offline reconectando';
    faixa.textContent = '🟠 Conexão voltou — sincronizando itens pendentes...';
  } else if (estado === 'ok') {
    faixa.className = 'cmd-pdv-faixa-offline ok';
    faixa.textContent = '✅ Reconectado, tudo sincronizado!';
    btnsPagamento.forEach(b => b.disabled = false);
    setTimeout(() => faixa.classList.add('hidden'), 3000);
  } else {
    faixa.classList.add('hidden');
  }
}

function entrarModoOffline() {
  if (MODO_OFFLINE) { atualizarFaixaOffline('offline'); return; }
  MODO_OFFLINE = true;
  atualizarFaixaOffline('offline');
}

async function tentarReconectar() {
  if (!MODO_OFFLINE) return;
  atualizarFaixaOffline('reconectando');
  // Confirma que dá pra falar com o servidor de verdade antes de sincronizar
  // (o evento "online" do navegador só garante rede local, não que o servidor responde).
  const teste = await fetch(`${API}/comandas`, { headers: { 'Authorization': `Bearer ${TOKEN}` } }).catch(() => null);
  if (!teste || !teste.ok) { atualizarFaixaOffline('offline'); return; }

  for (const item of [..._filaOfflineItens]) {
    const r = await fetch(`${API}/comandas/${item.comandaId}/itens`, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
      body: JSON.stringify(item)
    }).catch(() => null);
    if (r && r.ok) _filaOfflineItens.shift();
    else break; // ainda instável — para e tenta de novo depois
  }

  if (_filaOfflineItens.length) { atualizarFaixaOffline('offline'); return; }

  MODO_OFFLINE = false;
  atualizarFaixaOffline('ok');
  // Recarrega a comanda atual do servidor pra refletir os itens sincronizados de verdade
  if (comandaAtualId) {
    const c = await api(`/comandas/${comandaAtualId}`);
    if (c) renderItensComanda(c);
  }
}

window.addEventListener('online', tentarReconectar);
window.addEventListener('offline', entrarModoOffline);

// ── API helpers ──────────────────────────────────────────────
// B) 401 -> remove token + reload; C) network error -> toast
async function api(path, opts = {}) {
  const funcToken = sessionStorage.getItem('func_token');
  opts.headers = { ...opts.headers, 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' };
  if (funcToken) opts.headers['X-Func-Token'] = funcToken;
  if (opts.body && typeof opts.body === 'object' && !(opts.body instanceof FormData)) {
    opts.body = JSON.stringify(opts.body);
  }
  if (opts.body instanceof FormData) delete opts.headers['Content-Type'];
  try {
    const r = await fetch(`${API}${path}`, opts);
    if (r.status === 401) {
      const dataAuth = await r.json().catch(() => null);
      // Login de funcionário expirado/inválido — não é logout da padaria, só some o token do funcionário.
      if (dataAuth?.precisa_login_funcionario) {
        sessionStorage.removeItem('func_token');
        sessionStorage.removeItem('func_nome');
        sessionStorage.removeItem('func_role');
        return { ok: false, precisa_login_funcionario: true };
      }
      localStorage.removeItem('panificapro_token');
      localStorage.removeItem('pptoken');
      location.reload();
      return null;
    }
    if (r.status === 402) {
      mostrarTelaPlanoExpirado();
      return null;
    }
    if (r.status === 403) {
      const dataForb = await r.json().catch(() => null);
      if (dataForb?.erro) { mostrarToast(dataForb.erro, 'err'); return null; }
      mostrarToast('Funcionalidade disponível apenas nos planos Pro e Premium. Faça upgrade!', 'warn');
      return null;
    }
    const data = await r.json().catch(() => null);
    if (!r.ok) {
      const msg = data?.erro || `Erro ${r.status}`;
      mostrarToast(msg, 'err');
      console.error(`[API] ${opts.method || 'GET'} ${path} →`, r.status, data);
      return null;
    }
    if (MODO_OFFLINE) tentarReconectar(); // essa chamada deu certo — aproveita pra sincronizar a fila
    return data;
  } catch (err) {
    const jaEstavaOffline = MODO_OFFLINE;
    entrarModoOffline();
    if (!jaEstavaOffline) mostrarToast('Sem conexão. Verifique sua internet.', 'err');
    return null;
  }
}

// ── Botão loading ────────────────────────────────────────────
function setBtnLoading(btn, loading, textoOriginal) {
  if (!btn) return;
  if (loading) {
    btn.disabled = true;
    btn.dataset.textoOriginal = btn.textContent;
    btn.textContent = 'Aguarde...';
    btn.style.opacity = '0.7';
  } else {
    btn.disabled = false;
    btn.textContent = textoOriginal || btn.dataset.textoOriginal || btn.textContent;
    btn.style.opacity = '';
  }
}

let _valorEstoqueOculto = localStorage.getItem('valorEstoqueOculto') === '1';
let _valorEstoqueReal = '';

function toggleValorEstoque() {
  _valorEstoqueOculto = !_valorEstoqueOculto;
  localStorage.setItem('valorEstoqueOculto', _valorEstoqueOculto ? '1' : '0');
  _aplicarVisibilidadeValor();
}

function _aplicarVisibilidadeValor() {
  const el = document.getElementById('kpi-valor-estoque');
  const olho = document.getElementById('icon-olho');
  const fechado = document.getElementById('icon-olho-fechado');
  if (el) {
    if (_valorEstoqueOculto) {
      if (el.textContent !== '••••••') _valorEstoqueReal = el.textContent;
      el.textContent = '••••••';
      el.style.letterSpacing = '4px';
      if (olho) olho.style.display = 'none';
      if (fechado) fechado.style.display = '';
    } else {
      if (_valorEstoqueReal) {
        el.textContent = _valorEstoqueReal;
        el.style.letterSpacing = '-0.5px';
      }
      if (olho) olho.style.display = '';
      if (fechado) fechado.style.display = 'none';
    }
  }
  // Esconde/mostra também os valores em R$ das Últimas movimentações
  document.querySelectorAll('.valor-sensivel').forEach(v => {
    v.textContent = _valorEstoqueOculto ? '••••' : v.dataset.valor;
  });
}

// ── Dashboard ────────────────────────────────────────────────
async function carregarDashboard() {
  const d = await api('/dashboard');
  if (!d) return;
  const k = d.kpis;
  document.getElementById('kpis').innerHTML = `
    <div class="kpi-card"><div class="kpi-value" style="color:var(--navy)">${k.total_produtos}</div><div class="kpi-label">Total de produtos</div></div>
    <div class="kpi-card kpi-clickable" onclick="abrirModalEstoque('zerado')"><div class="kpi-value" style="color:var(--red-500)">${k.zerados}</div><div class="kpi-label">Sem estoque</div><div class="kpi-hint">Ver produtos →</div></div>
    <div class="kpi-card kpi-clickable" onclick="abrirModalEstoque('minimo')"><div class="kpi-value" style="color:var(--yellow-500)">${k.abaixo_minimo}</div><div class="kpi-label">Abaixo do mínimo</div><div class="kpi-hint">Ver produtos →</div></div>
    <div class="kpi-card" style="position:relative;">
      <button onclick="toggleValorEstoque()" id="btn-ocultar-valor" style="position:absolute;top:10px;right:10px;background:rgba(0,0,0,0.06);border:none;cursor:pointer;color:var(--slate-500);padding:6px;border-radius:8px;line-height:1;display:flex;align-items:center;justify-content:center;" title="Ocultar/mostrar valor">
        <svg id="icon-olho" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
        <svg id="icon-olho-fechado" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display:none"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
      </button>
      <div class="kpi-value" id="kpi-valor-estoque" style="color:var(--orange);font-size:26px;letter-spacing:-0.5px">${'R$ ' + parseFloat(k.valor_total_estoque||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>
      <div class="kpi-label">Valor em estoque</div>
    </div>
    <div class="kpi-card kpi-clickable kpi-saidas" onclick="abrirTelaSaidas()"><div style="display:flex;align-items:center;justify-content:space-between;"><div><div class="kpi-value" style="color:var(--red-500);font-size:26px;letter-spacing:-0.5px">${parseInt(k.qtd_saidas_30d||0)} saídas</div><div class="kpi-label">Saídas — últimos 30 dias</div></div><div class="kpi-hint" style="font-size:13px;">Ver detalhes →</div></div></div>
  `;
  _aplicarVisibilidadeValor();
  const onb = document.getElementById('onboarding-vazio');
  if (onb) onb.classList.toggle('hidden', k.total_produtos > 0);
  carregarPainelEncomendas();

  document.getElementById('lista-repor').innerHTML = d.repor.length
    ? d.repor.map(p => `
        <div class="repor-item">
          <div><div class="repor-item-name">${p.nome}</div>
          <div class="repor-item-sub">${p.falta > 0 ? `Falta: <b>${fmtQtd(p.falta)} ${p.unidade}</b>` : `<b>No limite mínimo</b>`}</div></div>
          <span class="badge ${p.estoque_atual <= 0 ? 'badge-zero' : 'badge-min'}">${p.estoque_atual <= 0 ? '🔴 Zerado' : '⚠️ Baixo'}</span>
        </div>`).join('')
    : '<p style="color:var(--slate-400);font-size:14px">Nenhum produto para repor ✅</p>';

  document.getElementById('lista-vencendo').innerHTML = d.vencendo.length
    ? d.vencendo.map(p => `
        <div class="repor-item">
          <div><div class="repor-item-name">${p.nome}</div>
          <div class="repor-item-sub">Vence: <b>${new Date(p.validade).toLocaleDateString('pt-BR')}</b></div></div>
          <span class="badge badge-validade">${p.dias_restantes}d</span>
        </div>`).join('')
    : '<p style="color:var(--slate-400);font-size:14px">Nenhum produto vencendo em breve ✅</p>';

  const isDark = () => document.documentElement.getAttribute('data-theme') === 'dark';
  const gridColor  = () => isDark() ? 'rgba(255,255,255,0.07)' : 'rgba(0,0,0,0.06)';
  const tickColor  = () => isDark() ? '#94a3b8' : '#64748b';
  const labelColor = () => isDark() ? '#cbd5e1' : '#334155';

  try {
    const movRecentes = await api('/movimentacoes?limit=10');
    const elMovs = document.getElementById('lista-movs-recentes');
    if (elMovs && movRecentes?.length) {
      elMovs.innerHTML = movRecentes.map(m => {
        const isEntrada = m.tipo === 'entrada';
        const isAjuste = m.tipo === 'ajuste';
        const icon = isEntrada ? '📥' : isAjuste ? '⚙️' : '📤';
        const cor = isEntrada ? '#16a34a' : isAjuste ? '#2563eb' : '#dc2626';
        const data = new Date(m.data).toLocaleDateString('pt-BR', { day:'2-digit', month:'2-digit' });
        const valor = parseFloat(m.quantidade) * parseFloat(m.custo_unit || 0);
        return `<div style="display:flex;align-items:center;gap:12px;padding:10px 16px;border-bottom:1px solid var(--slate-100);">
          <span style="font-size:18px;">${icon}</span>
          <div style="flex:1;min-width:0;">
            <div style="font-size:13px;font-weight:600;color:var(--slate-800);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">${m.produto || '—'}</div>
            <div style="font-size:12px;color:var(--slate-500);">${data} · ${m.observacao || m.tipo}</div>
          </div>
          <div style="text-align:right;flex-shrink:0;">
            <div style="font-size:13px;font-weight:700;color:${cor};white-space:nowrap;">${isEntrada ? '+' : isAjuste ? '~' : '−'}${fmtQtd(m.quantidade)} ${m.unidade||''}</div>
            <div class="valor-sensivel" data-valor="${fmtMoeda(valor)}" style="font-size:11.5px;color:var(--slate-400);white-space:nowrap;">${fmtMoeda(valor)}</div>
          </div>
        </div>`;
      }).join('');
      _aplicarVisibilidadeValor();
    } else if (elMovs) {
      elMovs.innerHTML = '<p style="padding:24px;text-align:center;color:var(--slate-400);font-size:14px;">Nenhuma movimentação ainda.</p>';
    }
  } catch(e) {}

  try {
    const topData = await api('/relatorios/top-produtos');
    const ctxC = document.getElementById('chart-cats')?.getContext('2d');
    if (ctxC && topData && topData.length) {
      if (window._chartCats) window._chartCats.destroy();
      window._chartCats = new Chart(ctxC, {
        type: 'bar',
        data: {
          labels: topData.map(r => r.nome),
          datasets: [{
            label: 'Valor em estoque (R$)',
            data: topData.map(r => parseFloat(r.valor)),
            backgroundColor: [
              'rgba(249,115,22,0.85)',
              'rgba(249,115,22,0.70)',
              'rgba(249,115,22,0.55)',
              'rgba(249,115,22,0.40)',
              'rgba(249,115,22,0.28)'
            ],
            borderColor: '#f97316',
            borderWidth: 1.5,
            borderRadius: 6
          }]
        },
        options: {
          indexAxis: 'y',
          responsive: true,
          plugins: {
            legend: { display: false },
            tooltip: {
              callbacks: {
                label: ctx => ` R$ ${ctx.parsed.x.toLocaleString('pt-BR', { minimumFractionDigits: 2 })}`
              }
            }
          },
          scales: {
            x: {
              beginAtZero: true,
              grid: { color: gridColor() },
              ticks: { color: tickColor(), font: { family: "'Plus Jakarta Sans', sans-serif" }, callback: v => 'R$ ' + v.toLocaleString('pt-BR') }
            },
            y: {
              grid: { display: false },
              ticks: { color: labelColor(), font: { family: "'Plus Jakarta Sans', sans-serif", weight: '600' } }
            }
          }
        }
      });
    }
  } catch(e) {}
}

function popularMesesSaidas() {
  const sel = document.getElementById('saidas-mes');
  if (sel.options.length > 0) return;
  const hoje = new Date();
  for (let i = 0; i < 12; i++) {
    const d = new Date(hoje.getFullYear(), hoje.getMonth() - i, 1);
    const val = `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}`;
    const label = d.toLocaleDateString('pt-BR',{month:'long',year:'numeric'});
    const opt = new Option(label.charAt(0).toUpperCase()+label.slice(1), val);
    sel.appendChild(opt);
  }
}

async function abrirTelaSaidas(mes) {
  const tela = document.getElementById('tela-saidas');
  const lista = document.getElementById('saidas-lista');
  popularMesesSaidas();
  const selMes = document.getElementById('saidas-mes');
  if (mes) selMes.value = mes;
  const mesEscolhido = selMes.value || selMes.options[0]?.value;
  const labelMes = selMes.options[selMes.selectedIndex]?.text || '';
  document.getElementById('saidas-titulo').textContent = `Saídas — ${labelMes}`;
  lista.innerHTML = '<p style="padding:20px;color:var(--slate-400);text-align:center;">Carregando...</p>';
  tela.classList.remove('hidden');

  const rows = await api(`/saidas/recentes?mes=${mesEscolhido}`) || [];
  if (!rows.length) {
    lista.innerHTML = `<p style="padding:32px;text-align:center;color:var(--slate-400);">Nenhuma saída em ${labelMes}.</p>`;
    window._saidasRows = [];
    return;
  }

  window._saidasRows = rows;
  renderizarSaidas(rows);
}

function renderizarSaidas(rows) {
  const total = rows.reduce((s, r) => s + parseFloat(r.valor_total || 0), 0);

  // Agrupar por fornecedor
  const grupos = {};
  rows.forEach((r, i) => {
    const forn = r.fornecedor || 'Sem fornecedor';
    if (!grupos[forn]) grupos[forn] = [];
    grupos[forn].push({ ...r, _idx: i });
  });

  const gruposHtml = Object.entries(grupos).map(([forn, itens]) => {
    const subtotal = itens.reduce((s, r) => s + parseFloat(r.valor_total || 0), 0);
    const itensHtml = itens.map(r => {
      const data = new Date(r.data).toLocaleDateString('pt-BR');
      const valor = parseFloat(r.valor_total || 0).toLocaleString('pt-BR',{minimumFractionDigits:2});
      const custo = parseFloat(r.custo_unit || 0).toLocaleString('pt-BR',{minimumFractionDigits:2});
      return `<div class="saida-item${r._idx % 2 === 0 ? ' saida-item-zebra' : ''}">
        <input type="checkbox" class="saida-check" data-idx="${r._idx}" style="width:16px;height:16px;flex-shrink:0;accent-color:var(--navy);cursor:pointer;"/>
        <div style="flex:1;min-width:0;">
          <div class="saida-item-nome">${r.produto}</div>
          <div class="saida-item-sub">${fmtQtd(r.quantidade)} ${r.unidade} × R$ ${custo}${r.observacao ? ' · ' + r.observacao : ''}</div>
        </div>
        <div style="text-align:right;flex-shrink:0;display:flex;align-items:center;gap:6px;">
          <div>
            <div style="font-weight:700;color:var(--red-500);">R$ ${valor}</div>
            <div class="saida-item-data">${data}</div>
          </div>
          <button class="btn-icon" title="Corrigir esta saída" onclick="event.stopPropagation();abrirModalEditarMovimentacao(${r.id})">✏️</button>
        </div>
      </div>`;
    }).join('');
    return `
      <div style="padding:10px 16px;background:var(--navy);color:#fff;display:flex;justify-content:space-between;align-items:center;">
        <span style="font-weight:700;font-size:13px;">${forn}</span>
        <span style="font-size:12px;color:rgba(255,255,255,0.75);">Subtotal: R$ ${subtotal.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>
      </div>
      ${itensHtml}`;
  }).join('');

  document.getElementById('saidas-lista').innerHTML = `
    <div style="padding:12px 16px;background:var(--slate-50);border-bottom:2px solid var(--slate-200);display:flex;justify-content:space-between;align-items:center;gap:8px;flex-wrap:wrap;">
      <label style="display:flex;align-items:center;gap:8px;font-size:13px;color:var(--slate-600);cursor:pointer;">
        <input type="checkbox" id="saidas-select-all" onchange="toggleSelecionarTodasSaidas(this.checked)" style="width:16px;height:16px;accent-color:var(--navy);"/>
        Selecionar todos
      </label>
      <span style="font-size:13px;color:var(--slate-500);">${rows.length} registros</span>
      <span style="font-weight:700;color:var(--red-500);">Total: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>
    </div>
    ${gruposHtml}`;
}

function toggleSelecionarTodasSaidas(checked) {
  document.querySelectorAll('.saida-check').forEach(cb => {
    if (!checked) { cb.checked = false; return; }
    const r = window._saidasRows[parseInt(cb.dataset.idx)];
    const temLoja = /loja\s*\d+/i.test(r?.observacao || '');
    cb.checked = temLoja;
  });
}

function imprimirSaidas() {
  const checks = [...document.querySelectorAll('.saida-check')];
  const selecionados = checks.filter(c => c.checked).map(c => window._saidasRows[parseInt(c.dataset.idx)]);
  const alvo = selecionados.length ? selecionados : window._saidasRows;

  const total = alvo.reduce((s, r) => s + parseFloat(r.valor_total || 0), 0);

  function extrairLoja(obs) {
    const m = (obs || '').match(/loja\s*(\d+)/i);
    return m ? 'Loja ' + m[1] : 'Uso interno';
  }

  // Agrupar por loja → fornecedor
  const porLoja = {};
  alvo.forEach(r => {
    const loja = extrairLoja(r.observacao);
    const forn = r.fornecedor || 'Sem fornecedor';
    if (!porLoja[loja]) porLoja[loja] = {};
    if (!porLoja[loja][forn]) porLoja[loja][forn] = [];
    porLoja[loja][forn].push(r);
  });

  const lojasDetectadas = Object.keys(porLoja).filter(l => l !== 'Uso interno').sort((a, b) => {
    const na = parseInt(a.replace('Loja ', '')) || 0;
    const nb = parseInt(b.replace('Loja ', '')) || 0;
    return na - nb;
  });
  const lojasOrdenadas = [...lojasDetectadas, ...(porLoja['Uso interno'] ? ['Uso interno'] : [])];

  const blocos = lojasOrdenadas.map(loja => {
    const totalLoja = Object.values(porLoja[loja]).flat().reduce((s, r) => s + parseFloat(r.valor_total || 0), 0);
    const fornEntries = Object.entries(porLoja[loja]);
    const muitosForn = fornEntries.length > 1;
    const fornBlocks = fornEntries.map(([forn, itens]) => {
      const subtotal = itens.reduce((s, r) => s + parseFloat(r.valor_total || 0), 0);
      const linhas = itens.map(r => `
        <tr>
          <td>${r.produto}</td>
          <td>${fmtQtd(r.quantidade)} ${r.unidade}</td>
          <td>R$ ${parseFloat(r.custo_unit||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</td>
          <td style="font-weight:700;color:#dc2626;">R$ ${parseFloat(r.valor_total||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</td>
          <td>${new Date(r.data).toLocaleDateString('pt-BR')}</td>
          <td class="obs">${r.observacao || ''}</td>
        </tr>`).join('');
      const subtotalHtml = muitosForn
        ? `<span style="float:right;font-weight:400;">Subtotal: R$ ${subtotal.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>`
        : '';
      return `
        <tr class="forn-header"><td colspan="6">${forn}${subtotalHtml}</td></tr>
        ${linhas}`;
    }).join('');
    return `
      <tr class="loja-header"><td colspan="6">${loja} <span style="float:right;">Total: R$ ${totalLoja.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span></td></tr>
      ${fornBlocks}`;
  }).join('');

  const logoUrl = window.location.origin + '/img/favicon-192.png';
  const html = `<!DOCTYPE html><html><head><meta charset="utf-8"/>
    <meta name="viewport" content="width=794, initial-scale=1"/>
    <title> </title>
    <style>
      @page { margin: 0.5cm 1cm; size: A4 portrait; }
      html { font-family: Arial, sans-serif; font-size: 11px; color: #000; }
      body { padding: 12px; box-sizing: border-box; width: 770px; max-width: 770px; margin: 0 auto; }
      .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
      .page-header-left h2 { color: #1e3a5f; margin: 0 0 2px; font-size: 16px; }
      .page-header-left p { color: #1e3a5f; margin: 0; font-size: 10px; font-weight: 600; }
      .page-header-right { text-align: center; flex-shrink: 0; }
      .page-header-right img { width: 60px; height: 60px; opacity: 0.75; display: block; margin: 0 auto; }
      .page-header-right span { font-size: 10px; font-weight: 700; color: #1e3a5f; letter-spacing: 1px; display: block; }
      table { width: 100%; border-collapse: collapse; }
      th { background: #fff; color: #1e3a5f; padding: 5px 7px; text-align: left; font-size: 10px; font-weight: 700; border-bottom: 2px solid #1e3a5f; }
      td { padding: 5px 7px; border-bottom: 1px solid #cbd5e1; color: #000; font-size: 10px; }
      tr:nth-child(even) td { background: #f1f5f9; }
      td.obs { color: #1e3a5f; font-style: italic; font-size: 10px; font-weight: 600; }
      tr.loja-header td { background: #fff; color: #1e3a5f; font-weight: 700; font-size: 11px; padding: 5px 7px; border-top: 2px solid #1e3a5f; border-bottom: 1px solid #1e3a5f; }
      tr.forn-header td { background: #fff; color: #1e3a5f; font-weight: 700; padding: 4px 7px 4px 18px; font-size: 10px; border-bottom: 1px solid #cbd5e1; }
      .total { text-align: right; font-weight: 700; margin-top: 8px; font-size: 12px; color: #dc2626; }
    </style></head><body>
    <div class="page-header">
      <div class="page-header-left">
        <h2>${document.getElementById('sidebar-nome').textContent} — ${document.getElementById('saidas-titulo')?.textContent || 'Saídas'}</h2>
        <p>Impresso em ${new Date().toLocaleDateString('pt-BR')} · ${alvo.length} registros</p>
      </div>
      <div class="page-header-right">
        <img src="${logoUrl}" alt="logo"/>
        <span>PanificaPro</span>
      </div>
    </div>
    <table>
      <thead><tr><th>Produto</th><th>Quantidade</th><th>Custo unit.</th><th>Total</th><th>Data</th><th>Observação</th></tr></thead>
      <tbody>${blocos}</tbody>
    </table>
    <div class="total">Total geral: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>
    <script>
    window.onload = () => {
      const body = document.body;
      const pageH = 267; // A4 altura útil em mm (297 - margens)
      const mmToPx = 3.7795;
      const pageHpx = pageH * mmToPx;
      const contentH = body.scrollHeight;
      if (contentH > pageHpx) {
        const scale = pageHpx / contentH;
        body.style.transformOrigin = 'top left';
        body.style.transform = 'scale(' + scale + ')';
        body.style.width = Math.round(100 / scale) + '%';
      }
      window.print();
      window.onafterprint = () => window.close();
    };
    <\/script>
    </body></html>`;

  const w = window.open('', '_blank');
  w.document.write(html);
  w.document.close();
}

function fecharTelaSaidas() {
  document.getElementById('tela-saidas').classList.add('hidden');
}

// Corrigir uma saída (erro de digitação: quantidade, data ou destino/observação)
function abrirModalEditarMovimentacao(id) {
  const r = (window._saidasRows || []).find(x => x.id === id);
  if (!r) { mostrarToast('Registro não encontrado.', 'err'); return; }
  document.getElementById('mov-editar-id').value = r.id;
  document.getElementById('mov-editar-produto').value = r.produto;
  document.getElementById('mov-editar-qtd').value = parseFloat(r.quantidade);
  document.getElementById('mov-editar-data').value = String(r.data).slice(0, 10);
  document.getElementById('mov-editar-obs').value = r.observacao || '';
  document.getElementById('modal-editar-mov').classList.remove('hidden');
}

async function salvarEdicaoMovimentacao() {
  const id = document.getElementById('mov-editar-id').value;
  const quantidade = document.getElementById('mov-editar-qtd').value;
  const data = document.getElementById('mov-editar-data').value;
  const observacao = document.getElementById('mov-editar-obs').value.trim();
  if (!quantidade || parseFloat(quantidade) <= 0) { mostrarToast('Quantidade inválida.', 'warn'); return; }

  const r = await api(`/movimentacoes/${id}`, { method: 'PUT', body: { quantidade, data, observacao } });
  if (!r) return;
  mostrarToast('Saída corrigida!', 'ok');
  document.getElementById('modal-editar-mov').classList.add('hidden');
  const mesAtual = document.getElementById('saidas-mes').value;
  abrirTelaSaidas(mesAtual);
}

async function abrirModalImprimirEstoque() {
  const sel = document.getElementById('imprimir-estoque-categoria');
  const cats = await api('/categorias');
  if (cats && sel) {
    sel.innerHTML = '<option value="">Todas as categorias</option>' +
      cats.map(c => `<option value="${c.id}">${c.nome}</option>`).join('');
  }
  document.getElementById('modal-imprimir-estoque').classList.remove('hidden');
}

function fecharModalImprimirEstoque() {
  document.getElementById('modal-imprimir-estoque').classList.add('hidden');
}

async function imprimirEstoquePorCategoria() {
  const sel = document.getElementById('imprimir-estoque-categoria');
  const categoriaId = sel.value;
  const categoriaNome = categoriaId ? sel.options[sel.selectedIndex].textContent : 'Todas as categorias';

  const url = categoriaId ? `/produtos?categoria_id=${categoriaId}` : '/produtos';
  const prods = await api(url) || [];

  if (!prods.length) return alert('Nenhum produto encontrado nessa categoria.');

  fecharModalImprimirEstoque();

  const linhas = prods.map(p => `
    <tr>
      <td>${p.nome}</td>
      <td>${p.categoria || '—'}</td>
      <td>${fmtQtd(p.estoque_atual)} ${p.unidade}</td>
      <td>${fmtQtd(p.estoque_minimo || 0)} ${p.unidade}</td>
      <td>R$ ${parseFloat(p.custo_unitario||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</td>
      <td>R$ ${parseFloat(p.preco_venda||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</td>
    </tr>`).join('');

  const logoUrl = window.location.origin + '/img/favicon-192.png';
  const html = `<!DOCTYPE html><html><head><meta charset="utf-8"/>
    <meta name="viewport" content="width=794, initial-scale=1"/>
    <title> </title>
    <style>
      @page { margin: 0.5cm 1cm; size: A4 portrait; }
      html { font-family: Arial, sans-serif; font-size: 11px; color: #000; }
      body { padding: 12px; box-sizing: border-box; width: 770px; max-width: 770px; margin: 0 auto; }
      .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
      .page-header-left h2 { color: #1e3a5f; margin: 0 0 2px; font-size: 16px; }
      .page-header-left p { color: #1e3a5f; margin: 0; font-size: 10px; font-weight: 600; }
      .page-header-right { text-align: center; flex-shrink: 0; }
      .page-header-right img { width: 60px; height: 60px; opacity: 0.75; display: block; margin: 0 auto; }
      .page-header-right span { font-size: 10px; font-weight: 700; color: #1e3a5f; letter-spacing: 1px; display: block; }
      table { width: 100%; border-collapse: collapse; }
      th { background: #fff; color: #1e3a5f; padding: 5px 7px; text-align: left; font-size: 10px; font-weight: 700; border-bottom: 2px solid #1e3a5f; }
      td { padding: 5px 7px; border-bottom: 1px solid #cbd5e1; color: #000; font-size: 10px; }
      tr:nth-child(even) td { background: #f1f5f9; }
    </style></head><body>
    <div class="page-header">
      <div class="page-header-left">
        <h2>${document.getElementById('sidebar-nome').textContent} — Estoque</h2>
        <p>${categoriaNome} · Impresso em ${new Date().toLocaleDateString('pt-BR')} · ${prods.length} produtos</p>
      </div>
      <div class="page-header-right">
        <img src="${logoUrl}" alt="logo"/>
        <span>PanificaPro</span>
      </div>
    </div>
    <table>
      <thead><tr><th>Produto</th><th>Categoria</th><th>Saldo</th><th>Mínimo</th><th>Custo</th><th>Venda</th></tr></thead>
      <tbody>${linhas}</tbody>
    </table>
    <script>
    window.onload = () => {
      const body = document.body;
      const pageH = 267;
      const mmToPx = 3.7795;
      const pageHpx = pageH * mmToPx;
      const contentH = body.scrollHeight;
      if (contentH > pageHpx) {
        const scale = pageHpx / contentH;
        body.style.transformOrigin = 'top left';
        body.style.transform = 'scale(' + scale + ')';
        body.style.width = Math.round(100 / scale) + '%';
      }
      window.print();
      window.onafterprint = () => window.close();
    };
    <\/script>
    </body></html>`;

  const w = window.open('', '_blank');
  w.document.write(html);
  w.document.close();
}

async function abrirModalEstoque(tipo) {
  const prods = await api(`/produtos?alerta=${tipo}`) || [];
  const titulo = tipo === 'zerado' ? '🔴 Produtos sem estoque' : '⚠️ Produtos abaixo do mínimo';

  document.getElementById('modal-estoque-titulo').textContent = titulo;
  document.getElementById('modal-estoque-lista').innerHTML = prods.length
    ? `<div style="display:flex;flex-direction:column;">
        <div style="display:flex;align-items:center;padding:8px 16px;border-bottom:2px solid var(--slate-200);font-size:12px;font-weight:600;color:var(--slate-500);">
          <span style="width:32px;"></span>
          <span style="flex:1;">PRODUTO</span>
          <span style="text-align:right;min-width:60px;">ATUAL</span>
          <span style="text-align:right;min-width:60px;">MÍN.</span>
        </div>
        ${prods.map(p => `
        <label style="display:flex;align-items:center;padding:10px 16px;border-bottom:1px solid var(--slate-100);cursor:pointer;gap:0;">
          <input type="checkbox" data-prod-id="${p.id}" onchange="atualizarBtnCompras()" style="width:18px;height:18px;flex-shrink:0;accent-color:var(--orange);cursor:pointer;margin-right:10px;"/>
          <span style="flex:1;font-size:14px;padding-right:8px;">${p.nome}</span>
          <span style="min-width:60px;text-align:right;font-weight:600;font-size:14px;color:${p.estoque_atual <= 0 ? 'var(--red-500)' : 'var(--yellow-500)'};">${fmtQtd(p.estoque_atual)} ${p.unidade}</span>
          <span style="min-width:60px;text-align:right;font-size:14px;color:var(--slate-400);">${fmtQtd(p.estoque_minimo || 0)} ${p.unidade}</span>
        </label>`).join('')}
      </div>`
    : `<p style="text-align:center;padding:24px;color:var(--slate-400);">✅ Nenhum produto nesta situação!</p>`;

  _produtosParaRepor = prods;
  document.getElementById('modal-estoque').classList.remove('hidden');
}

function fecharModalEstoque() {
  document.getElementById('modal-estoque').classList.add('hidden');
}

function atualizarBtnCompras() {
  const checks = document.querySelectorAll('#modal-estoque-lista input[type=checkbox]:checked');
  const btn = document.getElementById('btn-ir-compras');
  if (btn) {
    btn.disabled = checks.length === 0;
    btn.style.opacity = checks.length === 0 ? '0.5' : '1';
    btn.textContent = checks.length > 0 ? `🛒 Ir para Compras (${checks.length})` : '🛒 Ir para Compras';
  }
}

async function irParaCompras() {
  const checks = document.querySelectorAll('#modal-estoque-lista input[type=checkbox]:checked');
  const selecionados = Array.from(checks).map(c => {
    const id = c.dataset.prodId;
    return _produtosParaRepor.find(p => String(p.id) === String(id));
  }).filter(Boolean);

  fecharModalEstoque();
  mostrarPagina('compras');
  await carregarCompras();

  if (!selecionados.length) return;

  // Adiciona todos os selecionados ao pedido
  selecionados.forEach(p => {
    _pedidoItens.push({
      id: Date.now() + Math.random(),
      prodId: String(p.id),
      nome: p.nome,
      unidade: p.unidade || 'un',
      qtd: 1,
      custo: parseFloat(p.custo_unitario || 0),
      isNovo: false,
      minimo: 0,
      qtdKg: null,
      unidadeCusto: null
    });
  });
  renderizarPedido();

  // Pré-seleciona fornecedor do primeiro produto que tiver
  const primComForn = selecionados.find(p => p.fornecedor_id);
  if (primComForn) {
    const sel = document.getElementById('compra-fornecedor');
    if (sel) setTimeout(() => { sel.value = String(primComForn.fornecedor_id); }, 100);
  }
}

// ── Produtos ─────────────────────────────────────────────────
async function carregarFiltroFornecedor() {
  const sel = document.getElementById('filtro-fornecedor');
  if (!sel) return;
  const fornecedores = await api('/fornecedores') || [];
  const atual = sel.value;
  sel.innerHTML = '<option value="">Fornecedor</option>' +
    fornecedores.map(f =>
      `<option value="${f.id}" ${String(f.id) === atual ? 'selected' : ''}>${f.nome}</option>`
    ).join('');
}

function atualizarBtnLimpar() {
  const busca = document.getElementById('busca-produto')?.value;
  const cat = document.getElementById('filtro-categoria')?.value;
  const alerta = document.getElementById('filtro-alerta')?.value;
  const forn = document.getElementById('filtro-fornecedor')?.value;
  const btn = document.getElementById('btn-limpar-filtros');
  if (!btn) return;
  const contagem = document.getElementById('contagem-produtos');
  if (busca || cat || alerta || forn) {
    btn.classList.remove('hidden');
    if (contagem) contagem.style.display = 'none';
  } else {
    btn.classList.add('hidden');
    if (contagem) contagem.style.display = '';
  }
}

function limparFiltros() {
  const busca = document.getElementById('busca-produto');
  const cat = document.getElementById('filtro-categoria');
  const alerta = document.getElementById('filtro-alerta');
  const forn = document.getElementById('filtro-fornecedor');
  if (busca) busca.value = '';
  if (cat) cat.value = '';
  if (alerta) alerta.value = '';
  if (forn) forn.value = '';
  atualizarBtnLimpar();
  carregarProdutos();
}

async function filtrarPorFornecedor() {
  const fornecedorId = document.getElementById('filtro-fornecedor')?.value;
  const tbody = document.getElementById('tabela-produtos');
  if (!tbody) return;

  if (!fornecedorId) {
    tbody.querySelectorAll('tr[data-prod-id]').forEach(tr => tr.style.display = '');
    tbody.querySelectorAll('.forn-empty').forEach(el => el.remove());
    return;
  }

  // Busca produtos que já foram comprados desse fornecedor (histórico de compras)
  const prodsForn = await api(`/fornecedores/${fornecedorId}/produtos`) || [];
  const idsPermitidos = new Set(prodsForn.map(p => String(p.id)));

  const rows = tbody.querySelectorAll('tr[data-prod-id]');
  rows.forEach(tr => {
    tr.style.display = idsPermitidos.has(tr.dataset.prodId) ? '' : 'none';
  });

  // Se nenhum produto apareceu, mostra mensagem
  const visiveis = [...rows].filter(tr => tr.style.display !== 'none');
  if (visiveis.length === 0) {
    const jaTemEmpty = tbody.querySelector('.empty-row');
    if (!jaTemEmpty) {
      tbody.insertAdjacentHTML('beforeend',
        '<tr class="empty-row forn-empty"><td colspan="10">Nenhum produto encontrado para este fornecedor</td></tr>');
    }
  } else {
    tbody.querySelectorAll('.forn-empty').forEach(el => el.remove());
  }
}

async function carregarProdutos() {
  const busca      = document.getElementById('busca-produto').value;
  const alerta     = document.getElementById('filtro-alerta').value;
  const categoriaId = document.getElementById('filtro-categoria')?.value;
  let url = '/produtos?';
  if (busca)       url += `busca=${encodeURIComponent(busca)}&`;
  if (categoriaId) url += `categoria_id=${categoriaId}&`;
  if (alerta)      url += `alerta=${alerta}`;
  const prods = await api(url);
  todosProds = prods || [];
  const contagem = document.getElementById('contagem-produtos');
  if (contagem) contagem.textContent = `${todosProds.length} produto${todosProds.length !== 1 ? 's' : ''}`;
  const tbody = document.getElementById('tabela-produtos');
  // F) col-hide-mobile and col-hide-mobile classes for mobile hiding
  tbody.innerHTML = todosProds.map(p => {
    const status = statusBadge(p);
    const validade = p.validade ? new Date(p.validade).toLocaleDateString('pt-BR') : '—';
    const valorTotal = (p.estoque_atual * p.custo_unitario).toLocaleString('pt-BR',{style:'currency',currency:'BRL'});
    const ultimaCompraLabel = p.ultima_compra
      ? '🗓 ' + new Date(p.ultima_compra).toLocaleDateString('pt-BR')
      : '—';
    const diasSemCompra = p.ultima_compra
      ? Math.floor((Date.now() - new Date(p.ultima_compra)) / 86400000)
      : 999;
    const ultimaCompraColor = diasSemCompra > 30 ? '#dc2626' : diasSemCompra > 15 ? '#d97706' : 'var(--slate-400)';
    return `<tr data-prod-id="${p.id}">
      <td>
        <div class="td-main">${p.nome}</div>
        ${p.codigo_barras ? `<div class="td-sub">${p.codigo_barras}</div>` : ''}
        <div class="td-sub" style="color:${ultimaCompraColor};font-size:11px;">últ. compra: ${ultimaCompraLabel}</div>
      </td>
      <td style="color:var(--slate-600)">${p.categoria || '—'}</td>
      <td class="right td-mono">
        ${fmtQtd(p.estoque_atual)} ${p.unidade}
        ${p.embalagem_qtd > 0 ? `<div class="td-sub" style="color:var(--slate-400);font-size:11px;">≈ ${fmtQtd(p.estoque_atual / p.embalagem_qtd)} embalagem(ns)</div>` : ''}
      </td>
      <td class="right td-mono" style="color:var(--slate-500)">${fmtQtd(p.estoque_minimo)}</td>
      <td class="right">${parseFloat(p.custo_unitario).toLocaleString('pt-BR',{style:'currency',currency:'BRL'})}</td>
      <td class="right" style="font-weight:600">${parseFloat(p.preco_venda||0).toLocaleString('pt-BR',{style:'currency',currency:'BRL'})}</td>
      <td class="center" style="${p.validade ? 'color:var(--orange-600);font-weight:600' : 'color:var(--slate-400)'}">${validade}</td>
      <td class="center">${status}</td>
      <td class="right" style="white-space:nowrap;">
        <button onclick="movRapido(${p.id},'entrada')" class="btn-icon" title="Entrada" style="color:#16a34a;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg></button>
        <button onclick="movRapido(${p.id},'saida')" class="btn-icon" title="Saída" style="color:#dc2626;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="5" y1="12" x2="19" y2="12"/></svg></button>
        <button onclick="editarProduto(${p.id})" class="btn-icon" title="Editar"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg></button>
        <button onclick="excluirProduto(this,${p.id},'${p.nome.replace(/'/g,"\\'")}')" class="btn-icon" title="Excluir" style="color:#dc2626;"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/></svg></button>
      </td>
    </tr>`;
  }).join('') || '<tr class="empty-row"><td colspan="10">Nenhum produto encontrado</td></tr>';

  // Reaplica filtro de fornecedor se ativo
  filtrarPorFornecedor();

  // Detecta duplicatas após carregar produtos
  detectarDuplicatas(todosProds);
}

let _duplicatas = [];

function detectarDuplicatas(prods) {
  const normalizar = s => s.toLowerCase().trim().replace(/\s+/g, ' ');
  const grupos = {};
  prods.forEach(p => {
    const chave = normalizar(p.nome);
    if (!grupos[chave]) grupos[chave] = [];
    grupos[chave].push(p);
  });
  _duplicatas = Object.values(grupos).filter(g => g.length > 1);

  const aviso = document.getElementById('aviso-duplicatas');
  const texto = document.getElementById('aviso-duplicatas-texto');
  if (_duplicatas.length) {
    const total = _duplicatas.reduce((acc, g) => acc + g.length, 0);
    texto.textContent = `${total} produtos com nomes duplicados encontrados`;
    aviso.classList.remove('hidden');
    aviso.style.display = 'flex';
  } else {
    aviso.classList.add('hidden');
  }
}

function abrirModalDuplicatas() {
  const lista = document.getElementById('modal-duplicatas-lista');
  lista.innerHTML = _duplicatas.map((grupo, gi) => {
    const unidadesDoGrupo = new Set(grupo.map(p => p.unidade));
    const mesmaUnidade = unidadesDoGrupo.size === 1;
    return `
    <div style="border:1px solid var(--slate-200);border-radius:10px;margin-bottom:12px;overflow:hidden;">
      <div style="background:var(--slate-50);padding:10px 14px;font-size:12px;font-weight:700;color:var(--slate-500);text-transform:uppercase;letter-spacing:.05em;">
        "${grupo[0].nome}" ${!mesmaUnidade ? '<span style="color:#d97706;text-transform:none;font-weight:600;">— unidades diferentes, mesclar exige atenção</span>' : ''}
      </div>
      ${grupo.map(p => `
        <div style="display:flex;align-items:center;justify-content:space-between;padding:10px 14px;border-top:1px solid var(--slate-100);gap:8px;">
          <div style="flex:1;min-width:0;">
            <div style="font-size:13px;font-weight:600;color:var(--slate-800);">${p.nome}</div>
            <div style="font-size:12px;color:var(--slate-400);">${p.unidade} · Estoque: ${fmtQtd(p.estoque_atual)} · R$ ${parseFloat(p.custo_unitario).toFixed(2)}</div>
          </div>
          <div style="display:flex;gap:6px;flex-shrink:0;flex-wrap:wrap;justify-content:flex-end;">
            <button onclick="fecharModalDuplicatas();editarProduto(${p.id})" style="background:var(--slate-100);color:var(--slate-700);border:none;border-radius:7px;padding:5px 10px;font-size:12px;font-weight:600;cursor:pointer;">Editar</button>
            <button onclick="mesclarDuplicataGrupo(this,${gi},${p.id})" style="background:#eff6ff;color:#2563eb;border:1px solid #bfdbfe;border-radius:7px;padding:5px 10px;font-size:12px;font-weight:600;cursor:pointer;" title="Soma o estoque dos outros deste grupo aqui e desativa os demais">🔗 Mesclar aqui</button>
            <button onclick="excluirDuplicata(this,${p.id},'${p.nome.replace(/'/g,"\\'")}',${grupo.length})" style="background:#fef2f2;color:#dc2626;border:1px solid #fecaca;border-radius:7px;padding:5px 10px;font-size:12px;font-weight:600;cursor:pointer;">Desativar</button>
          </div>
        </div>
      `).join('')}
    </div>
  `;
  }).join('');
  document.getElementById('modal-duplicatas').classList.remove('hidden');
}

// Mescla todos os produtos do grupo dentro do escolhido (soma estoque dos que têm a mesma unidade,
// avisa sobre os que ficaram de fora por unidade diferente).
async function mesclarDuplicataGrupo(btn, grupoIndex, principalId) {
  const grupo = _duplicatas[grupoIndex];
  if (!grupo) return;
  const outrosIds = grupo.map(p => p.id).filter(id => id !== principalId);
  if (!outrosIds.length) return;
  if (!confirm(`Mesclar os ${outrosIds.length + 1} produtos "${grupo[0].nome}" neste? O estoque dos que têm a mesma unidade será somado, e os outros ficarão inativos (histórico preservado).`)) return;

  btn.disabled = true;
  btn.textContent = '...';
  const r = await api(`/produtos/${principalId}/mesclar`, { method: 'POST', body: { ids: outrosIds } });
  if (!r) { btn.disabled = false; btn.textContent = '🔗 Mesclar aqui'; return; }

  let msg = `✅ ${r.mesclados} produto${r.mesclados === 1 ? '' : 's'} mesclado${r.mesclados === 1 ? '' : 's'}${r.estoqueSomado > 0 ? ` (+${fmtQtd(r.estoqueSomado)} no estoque)` : ''}`;
  if (r.ignorados && r.ignorados.length) msg += ` · ${r.ignorados.length} ficaram de fora (unidade diferente, precisam de decisão manual)`;
  mostrarToast(msg, 'ok');
  await carregarProdutos();
  if (_duplicatas.length) abrirModalDuplicatas();
  else fecharModalDuplicatas();
}

function fecharModalDuplicatas() {
  document.getElementById('modal-duplicatas').classList.add('hidden');
}

async function excluirDuplicata(btn, id, nome, totalNoGrupo) {
  if (totalNoGrupo <= 1) {
    alert('Não é possível desativar o único produto deste grupo.');
    return;
  }
  if (!confirm(`Desativar "${nome}"? Ele ficará oculto do estoque mas o histórico será preservado.`)) return;
  btn.disabled = true;
  btn.textContent = '...';
  const r = await fetch(`${API}/produtos/${id}`, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  if (r.ok) {
    btn.closest('div[style*="display:flex"]').style.opacity = '0.4';
    btn.textContent = 'Desativado';
    await carregarProdutos();
    if (_duplicatas.length) abrirModalDuplicatas();
    else fecharModalDuplicatas();
  } else {
    btn.disabled = false;
    btn.textContent = 'Desativar';
    alert('Erro ao desativar produto.');
  }
}

async function excluirProduto(btn, id, nome) {
  if (!confirm(`Excluir "${nome}"? Esta ação não pode ser desfeita.`)) return;
  const tr = btn.closest('tr');
  const r = await fetch(`${API}/produtos/${id}`, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  if (r.ok) tr.remove();
  else alert('Erro ao excluir produto.');
}

// ── Compras ───────────────────────────────────────────────
async function carregarCompras() {
  const prods = await api('/produtos?alerta=minimo') || [];
  const zerados = await api('/produtos?alerta=zerado') || [];
  const todos = [...zerados, ...prods.filter(p => !zerados.find(z => z.id === p.id))];
  const el = document.getElementById('lista-compras-repor');
  if (!todos.length) {
    el.innerHTML = '<p style="color:#16a34a;font-size:14px;">✅ Nenhum produto precisa de reposição agora!</p>';
  } else {
    el.innerHTML = todos.map(p => {
      const falta = Math.max(0, p.estoque_minimo - p.estoque_atual);
      const badge = p.estoque_atual <= 0
        ? '<span class="badge badge-zero">🔴 Zerado</span>'
        : '<span class="badge badge-min">⚠️ Baixo</span>';
      return `<div class="repor-item">
        <div>
          <div class="repor-item-name">${p.nome}</div>
          <div class="repor-item-sub">Atual: ${fmtQtd(p.estoque_atual)} ${p.unidade} · ${falta > 0 ? `Falta: <b>${fmtQtd(falta)} ${p.unidade}</b>` : '<b>No limite mínimo</b>'}</div>
        </div>
        ${badge}
      </div>`;
    }).join('');
  }

  _produtosCache = await api('/produtos') || [];

  const hoje = new Date().toISOString().split('T')[0];
  if (!document.getElementById('compra-data').value) document.getElementById('compra-data').value = hoje;

  // Popula select de fornecedor no formulário de compra
  const forn = await api('/fornecedores') || [];
  const selF = document.getElementById('compra-fornecedor');
  selF.innerHTML = '<option value="">— Sem fornecedor —</option>' +
    forn.map(f => `<option value="${f.id}" data-tel="${f.telefone||''}">${f.nome}</option>`).join('');

  // Pedidos pendentes de recebimento
  const pendentes = await api('/compras/pedidos') || [];
  const secPend = document.getElementById('secao-pedidos-pendentes');
  const listaPend = document.getElementById('lista-pedidos-pendentes');
  if (pendentes.length) {
    secPend.classList.remove('hidden');
    listaPend.innerHTML = pendentes.map(p => {
      const dataPedido = new Date(p.criado_em).toLocaleDateString('pt-BR');
      const itensHtml = p.itens.map((item, idx) => {
        const nomeProd = item.produto || '';
        const semNome = !nomeProd || nomeProd === 'Produto sem nome';
        const itemKey = `item-${p.id}-${idx}`;
        if (semNome) {
          return `<div class="pedido-item-corrigir" id="wrap-${itemKey}">
            <span class="pedido-item-semNome">⚠️ Produto sem nome</span>
            <span class="pedido-item-qtd">(${fmtQtd(item.quantidade)} ${item.unidade})</span>
            <button class="btn-corrigir-item" onclick="abrirCorrecaoItem('${itemKey}', ${p.id}, ${idx})">Corrigir</button>
            <div id="correcao-${itemKey}" class="correcao-item hidden">
              <input id="inp-${itemKey}" type="text" placeholder="Digite o nome do produto..." autocomplete="off"
                oninput="filtrarCorrecaoItem('${itemKey}')" class="inp-correcao"/>
              <div id="lista-${itemKey}" class="autocomplete-lista hidden"></div>
              <div class="correcao-acoes">
                <button class="btn-salvar-correcao" id="btn-salvar-${itemKey}" onclick="salvarCorrecaoItem('${itemKey}', ${p.id}, ${idx})" disabled>Salvar</button>
                <button class="btn-cancelar-correcao" onclick="fecharCorrecaoItem('${itemKey}')">Cancelar</button>
              </div>
            </div>
          </div>`;
        }
        return `<span class="pedido-item-ok">${nomeProd} (${fmtQtd(item.quantidade)} ${item.unidade})</span>`;
      }).join('');

      return `<div class="pedido-pendente-card">
        <div class="pedido-pendente-info">
          <div class="pedido-pendente-header">
            <span class="pedido-pendente-forn">${p.fornecedor || 'Sem fornecedor'}</span>
            <span class="pedido-pendente-data">${dataPedido}</span>
          </div>
          <div class="pedido-pendente-itens">${itensHtml}</div>
          ${p.total > 0 ? `<div class="pedido-pendente-total">Total: R$ ${parseFloat(p.total).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>` : ''}
        </div>
        <div class="pedido-pendente-acoes">
          <button class="btn-editar-pedido" onclick="reabrirPedido(${p.id})"><svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg> Editar</button>
          <button class="btn-receber" onclick="confirmarRecebimentoPedido(${p.id})"><svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg> Recebi</button>
          <button class="btn-cancelar-pedido" onclick="cancelarPedido(${p.id})">✕</button>
        </div>
      </div>`;
    }).join('');
  } else {
    secPend.classList.add('hidden');
  }

  // Histórico de compras recebidas — agrupado por fornecedor
  const recentes = await api('/compras/recentes') || [];
  const elRecentes = document.getElementById('tabela-compras-recentes');
  if (!recentes.length) {
    elRecentes.innerHTML = '<p style="padding:20px;text-align:center;color:var(--slate-400);font-size:14px;">Nenhuma compra recebida nos últimos 30 dias.</p>';
  } else {
    const grupos = {};
    recentes.forEach(c => {
      const forn = c.fornecedor || '— Sem fornecedor —';
      if (!grupos[forn]) grupos[forn] = [];
      grupos[forn].push(c);
    });
    elRecentes.innerHTML = Object.entries(grupos).map(([forn, compras]) => {
      const totalForn = compras.reduce((s, c) => s + parseFloat(c.total || 0), 0);
      const linhas = compras.map(c => {
        const prods = (c.produtos || '').split(',').map(p => p.trim()).filter(Boolean);
        return `<div style="padding:10px 16px;border-bottom:1px solid var(--slate-100);">
          <div style="display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap;">
            <div style="font-size:13px;color:var(--slate-500);">${c.data ? new Date(c.data).toLocaleDateString('pt-BR') : '—'}</div>
            <div style="font-size:13px;font-weight:700;color:var(--navy);">R$ ${parseFloat(c.total||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>
          </div>
          <div style="margin-top:6px;display:flex;flex-wrap:wrap;gap:4px;">
            ${prods.map(p => `<span style="font-size:12px;background:var(--slate-100);color:var(--slate-700);padding:2px 8px;border-radius:20px;">${p}</span>`).join('')}
          </div>
        </div>`;
      }).join('');
      const expandId = `forn-expand-${forn.replace(/\s+/g,'_')}`;
      const collapsed = compras.length > 3;
      return `<div style="border-bottom:2px solid var(--slate-200);margin-bottom:4px;">
        <div style="display:flex;justify-content:space-between;align-items:center;padding:10px 16px;background:var(--slate-50);cursor:pointer;" onclick="toggleHistoricoForn('${expandId}')">
          <span style="font-size:13px;font-weight:700;color:var(--navy);">🏭 ${forn}</span>
          <span style="font-size:12px;color:var(--slate-500);">${compras.length} pedido${compras.length>1?'s':''} · R$ ${totalForn.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>
        </div>
        <div id="${expandId}" style="max-height:${collapsed ? '220px' : 'none'};overflow-y:${collapsed ? 'auto' : 'visible'};">
          ${linhas}
          ${collapsed ? `<div style="text-align:center;padding:8px;font-size:12px;color:var(--orange);cursor:pointer;" onclick="expandirHistoricoForn('${expandId}')">Ver todos os ${compras.length} pedidos ▼</div>` : ''}
        </div>
      </div>`;
    }).join('');
  }
}

function expandirHistoricoForn(id) {
  const el = document.getElementById(id);
  if (!el) return;
  el.style.maxHeight = 'none';
  el.style.overflowY = 'visible';
  const btn = el.querySelector('[onclick*="expandirHistoricoForn"]');
  if (btn) btn.remove();
}

function toggleHistoricoForn(id) {
  const el = document.getElementById(id);
  if (!el) return;
  if (el.style.maxHeight === 'none' || !el.style.maxHeight) {
    el.style.maxHeight = '220px';
    el.style.overflowY = 'auto';
  } else {
    el.style.maxHeight = 'none';
    el.style.overflowY = 'visible';
  }
}

let _produtosCache = [];
let _pedidoItens = [];
let _produtosParaRepor = [];

function filtrarProdutosCompra() {
  const termo = document.getElementById('compra-prod-texto').value.trim().toLowerCase();
  const lista = document.getElementById('compra-prod-lista');
  if (!termo) { lista.classList.add('hidden'); document.getElementById('compra-produto').value = ''; document.getElementById('novo-prod-inline').classList.add('hidden'); return; }
  const filtrados = _produtosCache.filter(p => p.nome.toLowerCase().includes(termo));
  const itens = filtrados.slice(0, 8).map(p =>
    `<div data-prod-id="${p.id}" data-prod-nome="${p.nome.replace(/"/g,'&quot;')}" data-prod-unidade="${p.unidade}" class="autocomplete-item">${p.nome} <span style="color:var(--slate-400);font-size:12px;">${p.unidade}</span></div>`
  );
  const textoAtual = document.getElementById('compra-prod-texto').value.trim();
  const jaExiste = _produtosCache.some(p => p.nome.toLowerCase() === termo);
  if (!jaExiste) {
    itens.push(`<div data-prod-id="__novo__" data-prod-nome="${textoAtual.replace(/"/g,'&quot;')}" data-prod-unidade="" class="autocomplete-item novo">+ Criar novo: "${textoAtual}"</div>`);
  }
  lista.innerHTML = itens.join('') || `<div style="padding:10px 14px;color:var(--slate-400);font-size:13px;">Nenhum produto encontrado</div>`;
  lista.classList.remove('hidden');
}

function selecionarProdutoCompra(id, nome, unidade) {
  document.getElementById('compra-prod-texto').value = nome;
  document.getElementById('compra-produto').value = id;
  document.getElementById('compra-prod-lista').classList.add('hidden');
  document.getElementById('novo-prod-inline').classList.add('hidden');
  const uSel = document.getElementById('compra-unidade');
  if (uSel && unidade) {
    const u = unidade.toLowerCase();
    // mapeia unidades do estoque (maiúsculo) para o valor do select de compras
    const mapa = { unidade: 'un', kg: 'kg', litro: 'L', pacote: 'pct', caixa: 'cx', fardo: 'fardo' };
    const val = mapa[u] || u;
    const opt = [...uSel.options].find(o => o.value.toLowerCase() === val.toLowerCase());
    if (opt) uSel.value = opt.value;
  }
  // Preenche custo unitário com o valor da última compra (custo atual do produto)
  const prod = _produtosCache.find(p => String(p.id) === String(id));
  const custoEl = document.getElementById('compra-custo');
  if (prod && custoEl && prod.custo_unitario > 0) {
    custoEl.value = parseFloat(prod.custo_unitario).toFixed(2);
  }
}

function selecionarNovoProdutoCompra(nome) {
  document.getElementById('compra-prod-texto').value = nome;
  document.getElementById('compra-produto').value = '__novo__';
  document.getElementById('compra-prod-lista').classList.add('hidden');
  document.getElementById('novo-prod-inline').classList.remove('hidden');
  // Sincroniza unidade da quantidade com a unidade padrão do novo produto
  const uNovo = document.getElementById('novo-prod-unidade');
  const uSel  = document.getElementById('compra-unidade');
  if (uNovo && uSel) {
    const opt = [...uSel.options].find(o => o.value === uNovo.value);
    if (opt) uSel.value = opt.value;
  }
}

async function limparProdutosZerados() {
  if (!confirm('Isso vai desativar todos os produtos com estoque zero. Eles podem ser reativados depois. Continuar?')) return;
  const r = await fetch(`${API}/saurus/limpar-zerados`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const data = await r.json();
  if (!r.ok) { mostrarToast('Erro ao limpar zerados.'); return; }
  mostrarToast(`🗑 ${data.removidos} produtos zerados removidos do estoque.`);
  carregarProdutos();
}

// Preenche em massa o código da balança de todos os produtos que já têm código curto
// do Saurus (código de barcão, 1-4 dígitos) mas ainda não têm o código da balança vinculado.
async function preencherCodigosBalanca() {
  if (!confirm('Isso vai preencher automaticamente o "Código da balança" de todos os produtos que já têm código curto do Saurus cadastrado (código de barcão), usando a fórmula código × 100. Continuar?')) return;
  const r = await fetch(`${API}/produtos/preencher-codigos-balanca`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const data = await r.json();
  if (!r.ok) { mostrarToast('Erro ao preencher códigos.', 'warn'); return; }
  mostrarToast(`⚖️ ${data.preenchidos} produtos vinculados automaticamente!`, 'ok');
  carregarProdutos();
}

// ── Exportação pro Gerenciador de Balanças Triunfo (formato "Padrão Smart
// Filizola") ── Layout descoberto a partir de um arquivo cadtxt.txt real
// exportado pelo próprio programa da padaria: 39 caracteres por linha, sem
// separador, sem cabeçalho:
//   código(6, zero à esquerda) + tipo(1: P=peso, U=unidade)
//   + descrição(22, cortada/completada com espaço) + preço(7, 2 casas
//   decimais implícitas, zero à esquerda) + validade em dias(3, zero à
//   esquerda — usamos 000 por padrão, já que o PanificaPro não guarda prazo
//   de validade em dias por produto).
async function exportarParaBalanca() {
  // Busca direto do servidor em vez de depender de algum cache local — o sistema
  // tem várias variáveis de cache de produto diferentes por tela (produtosCache,
  // _produtosCache, todosProds) e nem sempre a certa está carregada nesse momento.
  const lista = await api('/produtos') || [];
  const comCodigo = lista.filter(p => p.codigo_balanca && /^\d+$/.test(String(p.codigo_balanca).trim()));
  // Produto sem preço não pode ir pra balança como "R$ 0,00" — melhor deixar de fora
  // e avisar, do que exportar errado.
  const semPreco = comCodigo.filter(p => !(parseFloat(p.preco_venda) > 0));
  const elegiveis = comCodigo.filter(p => parseFloat(p.preco_venda) > 0);
  if (!elegiveis.length) {
    mostrarToast('Nenhum produto com código da balança E preço cadastrado ainda.', 'warn');
    return;
  }
  if (semPreco.length) {
    console.log(`⚠️ ${semPreco.length} produtos com código de balança mas SEM preço (ficaram de fora da exportação):`, semPreco.map(p => p.nome));
  }
  const pesoUnidades = ['KG', 'LITRO']; // vendido por peso/volume → tipo P; o resto → tipo U

  const linhas = elegiveis.map(p => {
    const codigo = String(p.codigo_balanca).trim().padStart(6, '0').slice(-6);
    const tipo = pesoUnidades.includes((p.unidade || '').toUpperCase()) ? 'P' : 'U';
    // Sem acento — no arquivo real exportado pela balança, "Pão" virou "Pao",
    // sugerindo que esse formato não lida bem com acentuação.
    const nomeSemAcento = (p.nome || '').normalize('NFD').replace(/[̀-ͯ]/g, '');
    const descricao = nomeSemAcento.slice(0, 22).padEnd(22, ' ');
    const precoCentavos = Math.round(parseFloat(p.preco_venda || 0) * 100);
    const preco = String(precoCentavos).padStart(7, '0').slice(-7);
    const validade = '000';
    return `${codigo}${tipo}${descricao}${preco}${validade}`;
  });

  const conteudo = linhas.join('\r\n') + '\r\n';
  const blob = new Blob([conteudo], { type: 'text/plain;charset=windows-1252' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = 'cadtxt.txt';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
  const avisoSemPreco = semPreco.length ? ` (${semPreco.length} ficaram de fora por não ter preço — veja o console)` : '';
  mostrarToast(`📤 Arquivo gerado com ${elegiveis.length} produtos!${avisoSemPreco} Leva o cadtxt.txt até o computador da balança e importa pelo Cadastros → Importar.`, 'ok');
}

// ── Financeiro ──────────────────────────────────────────────────────────────
let _finPeriodo = 'hoje';
let _finTipo = 'entrada';
let _finPgto = 'Dinheiro';

const FIN_ICONES = {
  Vendas:'💰', Encomendas:'🥐', 'Café':'☕', Delivery:'🛵',
  Farinha:'🌾', Fornecedor:'🚚', 'Folha de pagamento':'👥',
  Energia:'⚡', Aluguel:'🏠', 'Gás':'🔥', Manutenção:'🔧',
  Impostos:'📋', Marketing:'📣', Compras:'📦', Outro:'💵',
  'Despesa fixa':'🧾', Internet:'🌐', Água:'💧', Contabilidade:'📊'
};

async function carregarFinanceiro() {
  const [data, grafico, contas] = await Promise.all([
    api(`/financeiro?periodo=${_finPeriodo}`),
    api('/financeiro/grafico'),
    api('/financeiro/contas-pagar')
  ]);
  if (!data) return;

  const fmt = v => parseFloat(v).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  const saldo = data.saldo;

  document.getElementById('fin-saldo').textContent = fmt(saldo);
  document.getElementById('fin-saldo').style.color = saldo >= 0 ? '#2563eb' : '#dc2626';
  document.getElementById('fin-entradas').textContent = fmt(data.total_entradas);
  document.getElementById('fin-saidas').textContent   = fmt(data.total_saidas);

  const labels = { hoje: 'Hoje', semana: 'Últimos 7 dias', mes: 'Este mês', ano: 'Este ano' };
  document.getElementById('fin-periodo-label').textContent = labels[_finPeriodo] || '';

  // KPI contas a pagar
  if (contas) {
    document.getElementById('fin-total-pagar').textContent = fmt(contas.total);
    document.getElementById('fin-qtd-pagar').textContent = contas.qtd + ' conta' + (contas.qtd !== 1 ? 's' : '') + ' em aberto';
    renderContasPagar(contas.contas);
  }

  // Gráfico
  if (grafico) renderGrafico(grafico);

  // Movimentações
  renderMovimentacoes(data.movimentacoes, data.movimentacoes);

  // Categorias
  renderCategorias(data.movimentacoes);

  // Alertas
  renderAlertas(contas ? contas.contas : []);
}

function renderMovimentacoes(movs) {
  const fmt = v => parseFloat(v).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  const lista = document.getElementById('fin-lista');
  if (!movs.length) {
    lista.innerHTML = '<p style="text-align:center;color:var(--slate-400);padding:32px 16px;font-size:14px;">Nenhuma movimentação no período.</p>';
    return;
  }
  const pgtoTag = p => {
    const cores = { Pix:'#eff6ff:#2563eb', Dinheiro:'#f0fdf4:#16a34a', Crédito:'#fdf4ff:#9333ea', Débito:'#fdf4ff:#9333ea', Transferência:'#eff6ff:#2563eb', Boleto:'#fefce8:#ca8a04', Faturado:'#fff7ed:#c2410c', Padaria:'#f8fafc:#64748b' };
    const [bg, color] = (cores[p] || '#f1f5f9:#64748b').split(':');
    return `<span style="background:${bg};color:${color};border-radius:4px;padding:1px 6px;font-size:10px;font-weight:700;">${p||'Dinheiro'}</span>`;
  };
  let html = '', dataAtual = '';
  movs.forEach(m => {
    const d = new Date(String(m.data).slice(0, 10) + 'T12:00:00').toLocaleDateString('pt-BR', { weekday:'long', day:'2-digit', month:'2-digit' });
    if (d !== dataAtual) { dataAtual = d; html += `<div class="fin-date-header">${d}</div>`; }
    const icone = FIN_ICONES[m.categoria] || '💵';
    const sinal = m.tipo === 'entrada' ? '+' : '−';
    html += `<div class="fin-mov-item">
      <div class="fin-mov-icon ${m.tipo}">${icone}</div>
      <div style="flex:1;min-width:0;">
        <div class="fin-mov-desc">${m.descricao}</div>
        <div class="fin-mov-cat" style="display:flex;gap:6px;align-items:center;margin-top:2px;">
          <span>${m.categoria}</span>${pgtoTag(m.forma_pagamento)}
        </div>
      </div>
      <div style="display:flex;align-items:center;gap:8px;">
        <div class="fin-mov-val ${m.tipo}">${sinal}${fmt(m.valor)}</div>
        <button onclick="finExcluir(${m.id})" class="btn-icon" style="color:#dc2626;font-size:13px;" title="Excluir">🗑</button>
      </div>
    </div>`;
  });
  lista.innerHTML = html;
}

function renderGrafico(dados) {
  const maxVal = Math.max(...dados.map(d => Math.max(parseFloat(d.entradas), parseFloat(d.saidas))), 1);
  const meses = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
  let barsHtml = '', mesesHtml = '';
  dados.forEach(d => {
    const hEnt = Math.max((parseFloat(d.entradas)/maxVal)*100, 4);
    const hSai = Math.max((parseFloat(d.saidas)/maxVal)*100, 4);
    const mesNum = parseInt(d.mes.split('-')[1]) - 1;
    barsHtml += `<div class="fin-bar-group">
      <div class="fin-bar ent" style="height:${hEnt}%" title="Entradas: R$ ${parseFloat(d.entradas).toLocaleString('pt-BR')}"></div>
      <div class="fin-bar sai" style="height:${hSai}%" title="Saídas: R$ ${parseFloat(d.saidas).toLocaleString('pt-BR')}"></div>
    </div>`;
    mesesHtml += `<div class="fin-grafico-mes">${meses[mesNum]}</div>`;
  });
  document.getElementById('fin-grafico').innerHTML = barsHtml || '<p style="padding:16px;color:var(--slate-400);font-size:13px;">Sem dados ainda.</p>';
  document.getElementById('fin-grafico-meses').innerHTML = mesesHtml;
}

function renderContasPagar(contas) {
  const fmt = v => parseFloat(v).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  const hoje = new Date().toISOString().split('T')[0];
  const atrasadas = contas.filter(c => c.status === 'atrasado').length;
  const badge = document.getElementById('fin-badge-atrasadas');
  if (atrasadas > 0) { badge.textContent = atrasadas + ' atrasada' + (atrasadas>1?'s':''); badge.classList.remove('hidden'); }
  else badge.classList.add('hidden');

  if (!contas.length) {
    document.getElementById('fin-contas-pagar-lista').innerHTML = '<p style="font-size:12px;color:var(--slate-400);padding:8px 0;">Nenhuma conta em aberto.</p>';
    return;
  }
  let html = '';
  contas.forEach(c => {
    const venc = c.vencimento.split('T')[0];
    const diffDias = Math.round((new Date(venc+'T12:00:00') - new Date(hoje+'T12:00:00')) / 86400000);
    let cls = 'ok', label = 'Em dia';
    if (c.status === 'atrasado') { cls = 'late'; label = 'Atrasada'; }
    else if (diffDias <= 3) { cls = 'warn'; label = diffDias === 0 ? 'Vence hoje' : `${diffDias}d`; }
    html += `<div class="fin-cp-item">
      <div class="fin-cp-dot ${cls}"></div>
      <div class="fin-cp-info">
        <div class="fin-cp-desc">${c.descricao}</div>
        <div class="fin-cp-date">${new Date(venc+'T12:00:00').toLocaleDateString('pt-BR')}</div>
        <span class="fin-cp-status ${cls}">${label}</span>
      </div>
      <div class="fin-cp-right">
        <div class="fin-cp-val">${fmt(c.valor)}</div>
        <div class="fin-cp-pagar" onclick="pagarContaDireta(${c.id})">✓ Pagar</div>
      </div>
    </div>`;
  });
  document.getElementById('fin-contas-pagar-lista').innerHTML = html;
}

function renderCategorias(movs) {
  const saidas = movs.filter(m => m.tipo === 'saida');
  const totais = {};
  saidas.forEach(m => { totais[m.categoria] = (totais[m.categoria] || 0) + parseFloat(m.valor); });
  const sorted = Object.entries(totais).sort((a,b) => b[1]-a[1]).slice(0,5);
  const max = sorted[0]?.[1] || 1;
  const cores = ['#dc2626','#f97316','#d97706','#2563eb','#9333ea'];
  const fmt = v => v.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  if (!sorted.length) { document.getElementById('fin-categorias-chart').innerHTML = '<p style="font-size:12px;color:var(--slate-400);padding:8px 0;">Sem saídas no período.</p>'; return; }
  document.getElementById('fin-categorias-chart').innerHTML = sorted.map(([cat, val], i) => `
    <div class="fin-cat-item">
      <div class="fin-cat-name">${FIN_ICONES[cat]||'📦'} ${cat}</div>
      <div class="fin-cat-right">
        <div class="fin-cat-val">${fmt(val)}</div>
        <div class="fin-cat-bar-wrap"><div class="fin-cat-bar" style="width:${(val/max)*100}%;background:${cores[i]};"></div></div>
      </div>
    </div>`).join('');
}

function renderAlertas(contas) {
  const hoje = new Date().toISOString().split('T')[0];
  const atrasadas = contas.filter(c => c.status === 'atrasado');
  const vencendoHoje = contas.filter(c => c.vencimento && c.vencimento.split('T')[0] === hoje && c.status !== 'atrasado');
  const fmt = v => parseFloat(v).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
  let html = '';
  if (atrasadas.length) {
    const total = atrasadas.reduce((s,c) => s + parseFloat(c.valor), 0);
    html += `<div class="fin-alerta red"><div class="fin-alerta-dot"></div>${atrasadas.length} conta${atrasadas.length>1?'s':''} atrasada${atrasadas.length>1?'s':''} — ${fmt(total)}</div>`;
  }
  if (vencendoHoje.length) {
    const total = vencendoHoje.reduce((s,c) => s + parseFloat(c.valor), 0);
    html += `<div class="fin-alerta yellow"><div class="fin-alerta-dot"></div>${vencendoHoje.length} conta${vencendoHoje.length>1?'s':''} vence${vencendoHoje.length>1?'m':''} hoje — ${fmt(total)}</div>`;
  }
  document.getElementById('fin-alertas').innerHTML = html;
  document.getElementById('fin-alertas').style.display = html ? 'flex' : 'none';
}

function finSetPeriodo(periodo, btn) {
  _finPeriodo = periodo;
  document.querySelectorAll('.fin-periodo-btn').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
  carregarFinanceiro();
}

function abrirModalFinanceiro(tipo = 'entrada') {
  _finTipo = tipo;
  finSetTipo(tipo);
  document.getElementById('fin-valor').value = '';
  document.getElementById('fin-descricao').value = '';
  document.getElementById('fin-categoria').value = tipo === 'entrada' ? 'Vendas' : 'Aluguel';
  document.getElementById('fin-data').value = new Date().toISOString().split('T')[0];
  // Reset forma pagamento
  _finPgto = 'Dinheiro';
  document.querySelectorAll('.fin-pgto-btn').forEach(b => b.classList.toggle('active', b.dataset.pgto === 'Dinheiro'));
  // Mostrar campo de baixa só para saída
  const grp = document.getElementById('fin-conta-pagar-group');
  grp.style.display = tipo === 'saida' ? '' : 'none';
  document.getElementById('modal-financeiro').classList.remove('hidden');
}

function fecharModalFinanceiro() {
  document.getElementById('modal-financeiro').classList.add('hidden');
}

function finSetTipo(tipo) {
  _finTipo = tipo;
  const btnE = document.getElementById('fin-tab-entrada');
  const btnS = document.getElementById('fin-tab-saida');
  const btnConf = document.getElementById('btn-fin-confirmar');
  btnE.className = 'fin-tab' + (tipo === 'entrada' ? ' active-entrada' : '');
  btnS.className = 'fin-tab' + (tipo === 'saida'   ? ' active-saida'   : '');
  btnConf.className = 'fin-confirmar-btn ' + tipo;
  btnConf.textContent = tipo === 'entrada' ? '✅ Confirmar entrada' : '✅ Confirmar saída';
  const grp = document.getElementById('fin-conta-pagar-group');
  if (grp) grp.style.display = tipo === 'saida' ? '' : 'none';
}

// Botões de forma de pagamento
document.addEventListener('DOMContentLoaded', () => {
  document.getElementById('fin-pgto-grid')?.addEventListener('click', e => {
    const btn = e.target.closest('.fin-pgto-btn');
    if (!btn) return;
    _finPgto = btn.dataset.pgto;
    document.querySelectorAll('.fin-pgto-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
  });
});

async function finSalvar() {
  const valor = parseFloat(document.getElementById('fin-valor').value);
  const descricao = document.getElementById('fin-descricao').value.trim();
  const categoria = document.getElementById('fin-categoria').value;
  const data = document.getElementById('fin-data').value;
  const conta_pagar_id = document.getElementById('fin-conta-pagar-id')?.value || null;

  if (!valor || valor <= 0) { mostrarToast('Informe um valor válido.'); return; }
  if (!descricao) { mostrarToast('Informe uma descrição.'); return; }

  const btn = document.getElementById('btn-fin-confirmar');
  btn.disabled = true;

  const r = await fetch(`${API}/financeiro`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ tipo: _finTipo, valor, descricao, categoria, data, forma_pagamento: _finPgto, conta_pagar_id })
  });
  const d = await r.json();
  btn.disabled = false;

  if (!r.ok) { mostrarToast('Erro: ' + (d.erro || 'Tente novamente.')); return; }
  fecharModalFinanceiro();
  mostrarToast(_finTipo === 'entrada' ? '✅ Entrada registrada!' : '✅ Saída registrada!');
  carregarFinanceiro();
}

async function finExcluir(id) {
  if (!confirm('Excluir esta movimentação?')) return;
  await fetch(`${API}/financeiro/${id}`, { method: 'DELETE', headers: { 'Authorization': `Bearer ${TOKEN}` } });
  mostrarToast('Movimentação excluída.');
  carregarFinanceiro();
}

// ── Contas a Pagar ───────────────────────────────────────────
function abrirModalContaPagar() {
  document.getElementById('cp-descricao').value = '';
  document.getElementById('cp-valor').value = '';
  document.getElementById('cp-vencimento').value = '';
  document.getElementById('cp-categoria').value = 'Aluguel';
  document.getElementById('modal-conta-pagar').classList.remove('hidden');
}

function fecharModalContaPagar() {
  document.getElementById('modal-conta-pagar').classList.add('hidden');
}

async function salvarContaPagar() {
  const descricao  = document.getElementById('cp-descricao').value.trim();
  const valor      = parseFloat(document.getElementById('cp-valor').value);
  const vencimento = document.getElementById('cp-vencimento').value;
  const categoria  = document.getElementById('cp-categoria').value;
  if (!descricao || !valor || !vencimento) { mostrarToast('Preencha todos os campos.'); return; }
  const r = await fetch(`${API}/financeiro/contas-pagar`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ descricao, valor, vencimento, categoria })
  });
  if (r.ok) { fecharModalContaPagar(); mostrarToast('✅ Conta cadastrada!'); carregarFinanceiro(); }
  else mostrarToast('Erro ao salvar conta.');
}

async function pagarContaDireta(id) {
  if (!confirm('Marcar conta como paga?')) return;
  const r = await fetch(`${API}/financeiro/contas-pagar/${id}`, { method: 'PUT', headers: { 'Authorization': `Bearer ${TOKEN}` } });
  if (r.ok) { mostrarToast('✅ Conta baixada!'); carregarFinanceiro(); }
}

// ── Fechamento da maquininha (foto → OCR → lançamento) ──────────────────────
const MAQ_ESTILOS = {
  'Crédito': { icone: '💳', cor: '#f97316' },
  'Débito':  { icone: '💳', cor: '#0ea5e9' },
  'Voucher': { icone: '🎫', cor: '#8b5cf6' },
  'Pix':     { icone: '⚡', cor: '#16a34a' },
  'Dinheiro':{ icone: '💵', cor: '#64748b' },
};
let _maqItens = [];
let _maqPeriodoLabel = '';
let _maqTotalImpresso = null;

function abrirModalMaquininha() {
  reiniciarModalMaquininha();
  document.getElementById('modal-maquininha').classList.remove('hidden');
}

function fecharModalMaquininha() {
  document.getElementById('modal-maquininha').classList.add('hidden');
}

function reiniciarModalMaquininha() {
  document.getElementById('maq-etapa-foto').classList.remove('hidden');
  document.getElementById('maq-etapa-loading').classList.add('hidden');
  document.getElementById('maq-etapa-revisao').classList.add('hidden');
  document.getElementById('maq-etapa-erro').classList.add('hidden');
  document.getElementById('maq-input-foto').value = '';
  document.getElementById('maq-aviso-divergencia')?.classList.add('hidden');
  _maqItens = [];
  _maqTotalImpresso = null;
}

async function processarFotoMaquininha(file) {
  if (!file) return;
  document.getElementById('maq-etapa-foto').classList.add('hidden');
  document.getElementById('maq-etapa-loading').classList.remove('hidden');

  const form = new FormData();
  form.append('foto', file);
  try {
    const r = await fetch(`${API}/financeiro/maquininha/preview`, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${TOKEN}` },
      body: form
    });
    const d = await r.json();
    document.getElementById('maq-etapa-loading').classList.add('hidden');
    if (!r.ok) {
      document.getElementById('maq-erro-texto').textContent = d.erro || 'Não consegui ler esse comprovante.';
      document.getElementById('maq-etapa-erro').classList.remove('hidden');
      return;
    }
    renderizarRevisaoMaquininha(d);
  } catch (e) {
    document.getElementById('maq-etapa-loading').classList.add('hidden');
    document.getElementById('maq-erro-texto').textContent = 'Erro de conexão ao processar a imagem.';
    document.getElementById('maq-etapa-erro').classList.remove('hidden');
  }
}

function renderizarRevisaoMaquininha(dados) {
  _maqItens = dados.itens || [];
  _maqTotalImpresso = dados.total_impresso ?? null;
  _maqPeriodoLabel = dados.periodo_inicio && dados.periodo_fim
    ? (dados.periodo_inicio === dados.periodo_fim ? dados.periodo_inicio : `${dados.periodo_inicio} a ${dados.periodo_fim}`)
    : '';

  document.getElementById('maq-periodo-texto').textContent = _maqPeriodoLabel
    ? `Período identificado: ${_maqPeriodoLabel}`
    : 'Confira os valores identificados abaixo';

  const hoje = new Date().toISOString().slice(0, 10);
  document.getElementById('maq-data').value = hoje;

  renderizarItensMaquininha();
  document.getElementById('maq-etapa-revisao').classList.remove('hidden');
}

function renderizarItensMaquininha() {
  const lista = document.getElementById('maq-itens-lista');
  lista.innerHTML = _maqItens.map((item, i) => {
    const estilo = MAQ_ESTILOS[item.tipo] || { icone: '💰', cor: '#f97316' };
    const bandeirasHtml = (item.bandeiras && item.bandeiras.length)
      ? `<div class="maq-item-bandeiras">${item.bandeiras.map(b => {
          const taxa = b.taxa_pct != null ? ` <span class="maq-item-taxa">− ${b.taxa_pct}% (R$${b.taxa_valor.toFixed(2)})</span>` : '';
          return `<span>${b.nome} <strong>R$ ${b.total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</strong>${taxa}</span>`;
        }).join('')}</div>`
      : '';
    const taxaTipoHtml = item.taxa_pct != null
      ? ` <span class="maq-item-taxa">− ${item.taxa_pct}% (R$${item.taxa_valor.toFixed(2)})</span>` : '';
    return `
      <div class="maq-item-card" style="--maq-cor:${estilo.cor}">
        <div class="maq-item-icone">${estilo.icone}</div>
        <div class="maq-item-info">
          <div class="maq-item-nome">${item.tipo}${taxaTipoHtml}</div>
          <div class="maq-item-qtd">${item.quantidade} transaç${item.quantidade === 1 ? 'ão' : 'ões'}</div>
          <div class="maq-item-barra-fundo"><div class="maq-item-barra" style="width:${item.percentual}%"></div></div>
          ${bandeirasHtml}
        </div>
        <div class="maq-item-valores">
          <input type="number" step="0.01" min="0" class="maq-item-input" value="${item.total}" oninput="atualizarItemMaquininha(${i}, this.value)"/>
          <div class="maq-item-pct">${item.percentual}%</div>
        </div>
      </div>`;
  }).join('');
  atualizarTotalMaquininha();
}

function atualizarItemMaquininha(idx, valor) {
  _maqItens[idx].total = parseFloat(valor) || 0;
  const totalGeral = _maqItens.reduce((s, i) => s + i.total, 0);
  _maqItens.forEach(i => { i.percentual = totalGeral > 0 ? parseFloat((i.total / totalGeral * 100).toFixed(1)) : 0; });
  renderizarItensMaquininha();
}

function atualizarTotalMaquininha() {
  const total = _maqItens.reduce((s, i) => s + (parseFloat(i.total) || 0), 0);
  document.getElementById('maq-total-geral').textContent = 'R$ ' + total.toLocaleString('pt-BR', { minimumFractionDigits: 2 });

  const avisoEl = document.getElementById('maq-aviso-divergencia');
  if (!avisoEl) return;
  if (_maqTotalImpresso !== null && Math.abs(total - _maqTotalImpresso) >= 0.02) {
    avisoEl.innerHTML = `⚠️ A soma dos itens (R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}) não bate com o total impresso no comprovante (R$ ${_maqTotalImpresso.toLocaleString('pt-BR',{minimumFractionDigits:2})}). Confira os valores com atenção antes de confirmar — o OCR pode ter lido algum dígito errado.`;
    avisoEl.classList.remove('hidden');
  } else {
    avisoEl.classList.add('hidden');
  }
}

async function confirmarMaquininha() {
  const data = document.getElementById('maq-data').value;
  if (!data) { mostrarToast('Escolha a data do lançamento.'); return; }
  const itensValidos = _maqItens.filter(i => parseFloat(i.total) > 0);
  if (!itensValidos.length) { mostrarToast('Nenhum valor pra lançar.'); return; }

  const r = await fetch(`${API}/financeiro/maquininha/confirmar`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ itens: itensValidos, data, periodo_label: _maqPeriodoLabel })
  });
  const d = await r.json();
  if (r.ok) {
    fecharModalMaquininha();
    mostrarToast(`✅ ${d.lancados} lançamento(s) registrados no Financeiro!`);
    carregarFinanceiro();
  } else {
    mostrarToast(d.erro || 'Erro ao lançar.');
  }
}

// ── Resumo de hoje ───────────────────────────────────────────────────────
async function abrirModalResumoDia() {
  document.getElementById('modal-resumo-dia').classList.remove('hidden');
  const lista = document.getElementById('resumo-dia-lista');
  lista.innerHTML = '<p style="padding:16px;color:var(--slate-400);text-align:center;">Carregando...</p>';

  const d = await api('/financeiro/resumo-dia');
  if (!d) { lista.innerHTML = '<p style="padding:16px;color:var(--slate-400);text-align:center;">Erro ao carregar.</p>'; return; }

  const dataLabel = new Date(d.data + 'T00:00:00').toLocaleDateString('pt-BR', { day: '2-digit', month: 'long', year: 'numeric' });
  document.getElementById('resumo-dia-data').textContent = dataLabel;

  if (!d.entradas_por_forma.length) {
    lista.innerHTML = '<p style="padding:16px;color:var(--slate-400);text-align:center;">Nenhuma entrada registrada hoje ainda.</p>';
  } else {
    const totalEnt = d.total_entradas || 1;
    lista.innerHTML = d.entradas_por_forma.map(item => {
      const estilo = MAQ_ESTILOS[item.forma_pagamento] || { icone: '💰', cor: '#f97316' };
      const pct = totalEnt > 0 ? parseFloat((item.total / totalEnt * 100).toFixed(1)) : 0;
      return `
        <div class="maq-item-card" style="--maq-cor:${estilo.cor}">
          <div class="maq-item-icone">${estilo.icone}</div>
          <div class="maq-item-info">
            <div class="maq-item-nome">${item.forma_pagamento}</div>
            <div class="maq-item-barra-fundo"><div class="maq-item-barra" style="width:${pct}%"></div></div>
          </div>
          <div class="maq-item-valores">
            <div class="maq-item-nome">R$ ${item.total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>
            <div class="maq-item-pct">${pct}%</div>
          </div>
        </div>`;
    }).join('');
  }

  document.getElementById('resumo-dia-entradas').textContent = 'R$ ' + d.total_entradas.toLocaleString('pt-BR', { minimumFractionDigits: 2 });
  document.getElementById('resumo-dia-saidas').textContent   = 'R$ ' + d.total_saidas.toLocaleString('pt-BR', { minimumFractionDigits: 2 });
  const saldoEl = document.getElementById('resumo-dia-saldo');
  saldoEl.textContent = 'R$ ' + d.saldo.toLocaleString('pt-BR', { minimumFractionDigits: 2 });
  saldoEl.style.color = d.saldo >= 0 ? 'var(--orange)' : '#fca5a5';
}

function fecharModalResumoDia() {
  document.getElementById('modal-resumo-dia').classList.add('hidden');
}

async function enviarResumoDiaPorEmail() {
  const btn = document.getElementById('btn-resumo-dia-email');
  const textoOriginal = btn.textContent;
  btn.disabled = true;
  btn.textContent = 'Enviando...';
  const r = await fetch(`${API}/financeiro/resumo-dia/enviar-email`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const d = await r.json();
  btn.disabled = false;
  btn.textContent = textoOriginal;
  if (r.ok) mostrarToast(`✅ Resumo enviado para ${d.enviado_para}!`);
  else mostrarToast(d.erro || 'Erro ao enviar e-mail.');
}

// ── Onboarding ──────────────────────────────────────────────────────────────
async function verificarOnboarding() {
  if (localStorage.getItem('onboarding_dispensado')) return;

  const [produtos, fornecedores, compras] = await Promise.all([
    api('/produtos?limit=1'),
    api('/fornecedores'),
    api('/compras/recentes?limit=1'),
  ]);

  const temProduto    = (produtos || []).length > 0;
  const temFornecedor = (fornecedores || []).length > 0;
  const temCompra     = (compras || []).length > 0;
  const vistoPainel   = !!localStorage.getItem('onboarding_painel_visto');

  if (temProduto && temFornecedor && temCompra && vistoPainel) {
    localStorage.setItem('onboarding_dispensado', '1');
    return;
  }

  const steps = [
    {
      icon: '📦', titulo: 'Cadastre seu primeiro produto',
      desc: 'Adicione os produtos que você vende ou usa na produção.',
      done: temProduto, acao: () => { fecharOnboarding(); navegarPara('estoque'); setTimeout(abrirModalProduto, 400); }
    },
    {
      icon: '🏭', titulo: 'Adicione um fornecedor',
      desc: 'Registre quem fornece seus produtos para facilitar pedidos.',
      done: temFornecedor, acao: () => { fecharOnboarding(); navegarPara('fornecedores'); }
    },
    {
      icon: '🛒', titulo: 'Registre sua primeira compra',
      desc: 'Lance uma entrada de estoque para manter tudo atualizado.',
      done: temCompra, acao: () => { fecharOnboarding(); navegarPara('compras'); }
    },
    {
      icon: '📊', titulo: 'Explore o painel',
      desc: 'Veja o resumo do seu negócio em tempo real.',
      done: vistoPainel, acao: () => {
        localStorage.setItem('onboarding_painel_visto', '1');
        fecharOnboarding();
        navegarPara('dashboard');
      }
    },
  ];

  const container = document.getElementById('onboarding-steps');
  if (!container) return;
  container.innerHTML = steps.map((s, i) => `
    <div class="onboarding-step ${s.done ? 'done' : ''}" onclick="onboardingStep(${i})">
      <div class="onboarding-step-icon">${s.icon}</div>
      <div class="onboarding-step-text">
        <div class="onboarding-step-title">${s.titulo}</div>
        <div class="onboarding-step-desc">${s.desc}</div>
      </div>
      <div class="onboarding-step-check">${s.done ? '✅' : '→'}</div>
    </div>
  `).join('');

  window._onboardingSteps = steps;
  document.getElementById('modal-onboarding').classList.remove('hidden');
}

function onboardingStep(i) {
  const step = window._onboardingSteps?.[i];
  if (!step || step.done) return;
  step.acao();
}

function fecharOnboarding() {
  document.getElementById('modal-onboarding').classList.add('hidden');
}

function navegarPara(pg) {
  document.querySelectorAll('.nav-link').forEach(el => {
    if (el.dataset.pg === pg) el.click();
  });
}

function mostrarToast(msg) {
  let t = document.getElementById('toast-global');
  if (!t) {
    t = document.createElement('div');
    t.id = 'toast-global';
    t.style.cssText = 'position:fixed;bottom:24px;left:50%;transform:translateX(-50%);background:#166534;color:#fff;padding:12px 24px;border-radius:12px;font-size:14px;font-weight:600;z-index:9999;box-shadow:0 4px 20px rgba(0,0,0,0.2);max-width:90vw;width:max-content;text-align:center;line-height:1.4;';
    document.body.appendChild(t);
  }
  t.textContent = msg;
  t.style.display = 'block';
  clearTimeout(t._t);
  t._t = setTimeout(() => { t.style.display = 'none'; }, msg.length > 60 ? 5000 : 3500);
}

function toggleCalcCx() {
  const wrap = document.getElementById('calc-cx-wrap');
  wrap.classList.toggle('hidden');
}

function calcularPorCaixa() {
  const caixas  = parseFloat(document.getElementById('calc-caixas').value) || 0;
  const kgCx    = parseFloat(document.getElementById('calc-kg-cx').value) || 0;
  const precoKg = parseFloat(document.getElementById('calc-preco-kg').value) || 0;
  const res     = document.getElementById('calc-resultado');

  if (!caixas || !kgCx || !precoKg) { res.textContent = ''; return; }

  const totalKg = caixas * kgCx;
  const total   = totalKg * precoKg;

  // Campos principais: quantidade = caixas, custo = preço/kg
  document.getElementById('compra-qtd').value   = caixas;
  document.getElementById('compra-custo').value = precoKg.toFixed(2);

  // Unidade = cx
  const uSel = document.getElementById('compra-unidade');
  if (uSel) uSel.value = 'cx';

  res.innerHTML = `<strong>${caixas} cx</strong> × ${kgCx} kg/cx = <strong>${totalKg.toFixed(2)} kg</strong> · R$ ${precoKg.toFixed(2)}/kg · <strong>Total R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</strong>`;
}

// Variável auxiliar para dados da calculadora ao adicionar item
let _calcCxDados = null;

function adicionarItemPedido() {
  let prodId     = document.getElementById('compra-produto').value;
  const nome     = document.getElementById('compra-prod-texto').value.trim();
  const qtd      = parseFloat(document.getElementById('compra-qtd').value);
  const custo    = parseFloat(document.getElementById('compra-custo').value || 0);
  if (!prodId) prodId = '__novo__';
  const isNovo   = prodId === '__novo__';
  const unidadeSelect = document.getElementById('compra-unidade')?.value || 'un';
  const unidade  = isNovo
    ? (document.getElementById('novo-prod-unidade')?.value || unidadeSelect || 'un')
    : (unidadeSelect || (_produtosCache.find(p=>p.id==prodId)?.unidade || 'un'));
  const minimo   = isNovo ? parseFloat(document.getElementById('novo-prod-minimo').value || 0) : 0;

  limparErrosCampo('compra-prod-texto', 'compra-qtd');
  let ok = true;
  if (!nome) { mostrarErrocampo('compra-prod-texto', 'Selecione ou informe um produto.'); ok = false; }
  if (!qtd || qtd <= 0) { mostrarErrocampo('compra-qtd', 'Informe a quantidade.'); ok = false; }
  if (!ok) return;

  // Captura dados da calculadora por caixa, se ativa
  const calcAberto = !document.getElementById('calc-cx-wrap').classList.contains('hidden');
  const calcCaixas = parseFloat(document.getElementById('calc-caixas').value) || 0;
  const calcKgCx   = parseFloat(document.getElementById('calc-kg-cx').value) || 0;
  const qtdKg      = (calcAberto && calcCaixas && calcKgCx) ? calcCaixas * calcKgCx : null;

  _pedidoItens.push({ prodId, nome, unidade, qtd, custo, isNovo, minimo, id: Date.now(), qtdKg, unidadeCusto: qtdKg ? 'kg' : null });
  renderizarPedido();

  document.getElementById('compra-prod-texto').value = '';
  document.getElementById('compra-produto').value = '';
  document.getElementById('compra-qtd').value = '';
  document.getElementById('compra-custo').value = '';
  const uSel = document.getElementById('compra-unidade');
  if (uSel) uSel.value = 'un';
  document.getElementById('novo-prod-inline').classList.add('hidden');
  document.getElementById('calc-cx-wrap').classList.add('hidden');
  document.getElementById('calc-caixas').value = '';
  document.getElementById('calc-kg-cx').value = '';
  document.getElementById('calc-preco-kg').value = '';
  document.getElementById('calc-resultado').textContent = '';
  document.getElementById('compra-prod-texto').focus();
}

function removerItemPedido(id) {
  _pedidoItens = _pedidoItens.filter(i => i.id !== id);
  renderizarPedido();
}

function _calcTotalPedido() {
  const total = _pedidoItens.reduce((s, i) => s + (i.qtd || 0) * i.custo, 0);
  document.getElementById('pedido-total').textContent = `Total: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}`;
}

function atualizarQtdItem(id, valor) {
  const item = _pedidoItens.find(i => i.id === id);
  if (item) { item.qtd = parseFloat(valor) || 0; _calcTotalPedido(); }
}

function renderizarPedido() {
  const wrap = document.getElementById('pedido-itens-wrap');
  if (!_pedidoItens.length) { wrap.classList.add('hidden'); return; }
  wrap.classList.remove('hidden');
  _calcTotalPedido();
  document.getElementById('pedido-itens-lista').innerHTML = _pedidoItens.map(i => `
    <div style="display:flex;align-items:center;gap:8px;padding:10px 14px;border-bottom:1px solid var(--slate-100);font-size:14px;flex-wrap:wrap;">
      <div style="flex:1;min-width:120px;">
        <span style="font-weight:600;">${i.nome}</span>
        ${i.isNovo ? '<span style="font-size:11px;background:#fff7ed;color:var(--orange);padding:2px 6px;border-radius:4px;margin-left:4px;">novo</span>' : ''}
        ${i.custo > 0 ? `<div style="color:var(--slate-400);font-size:12px;margin-top:2px;">R$ ${i.custo.toFixed(2)}/${i.unidadeCusto || i.unidade}</div>` : ''}
        ${i.qtdKg ? `<div style="color:var(--slate-400);font-size:11px;">${i.qtdKg.toFixed(2)} kg no estoque</div>` : ''}
      </div>
      <div style="display:flex;align-items:center;gap:6px;">
        <input type="number" value="${i.qtd > 0 ? i.qtd : ''}" min="0.001" step="0.001"
          placeholder="Qtd"
          style="width:72px;padding:5px 8px;border:1.5px solid ${i.qtd > 0 ? 'var(--slate-200)' : 'var(--orange)'};border-radius:8px;font-size:13px;text-align:center;background:var(--white);color:var(--navy);"
          oninput="atualizarQtdItem(${i.id}, this.value)"
          onchange="this.style.borderColor=this.value>0?'var(--slate-200)':'var(--orange)'"
        />
        <span style="color:var(--slate-500);font-size:13px;">${i.unidade}</span>
      </div>
      <button onclick="removerItemPedido(${i.id})" class="btn-icon" style="color:#dc2626;flex-shrink:0;" title="Remover">🗑️</button>
    </div>`).join('');
}

function fmtQtd(v) {
  const n = parseFloat(v) || 0;
  // Mostra sem decimais se for número inteiro, senão até 3 casas sem zeros à direita
  return Number.isInteger(n) ? n.toLocaleString('pt-BR') : parseFloat(n.toFixed(3)).toLocaleString('pt-BR');
}

function mostrarMsgCompra(txt, tipo) {
  const msg = document.getElementById('compra-msg');
  msg.style.cssText = tipo === 'ok'
    ? 'font-size:13px;padding:8px 12px;border-radius:8px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;'
    : 'font-size:13px;padding:8px 12px;border-radius:8px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
  msg.textContent = txt;
  msg.classList.remove('hidden');
  if (tipo === 'ok') setTimeout(() => msg.classList.add('hidden'), 3000);
}

function abrirModalFinalizar() {
  if (!_pedidoItens.length) { mostrarMsgCompra('⚠️ Adicione ao menos um item ao pedido.', 'err'); return; }
  const semQtd = _pedidoItens.filter(i => !(i.qtd > 0));
  if (semQtd.length) { mostrarMsgCompra(`⚠️ Preencha a quantidade de: ${semQtd.map(i => i.nome).join(', ')}.`, 'err'); return; }
  const selF = document.getElementById('compra-fornecedor');
  const mSelF = document.getElementById('final-fornecedor');
  mSelF.innerHTML = selF.innerHTML;
  mSelF.value = selF.value;
  document.getElementById('final-data').value = document.getElementById('compra-data').value || new Date().toISOString().slice(0,10);
  renderizarFinalItens();
  document.getElementById('final-msg').classList.add('hidden');
  document.getElementById('modal-finalizar').classList.remove('hidden');
}

function fecharModalFinalizar() {
  document.getElementById('modal-finalizar').classList.add('hidden');
  _pedidoEditandoId = null;
}

const UNIDADES = ['kg','g','L','ml','un','cx','pct','fardo'];

function renderizarFinalItens() {
  document.getElementById('final-total').textContent = '';
  document.getElementById('final-itens-lista').innerHTML = _pedidoItens.map(i => `
    <div style="display:flex;align-items:center;gap:8px;padding:12px 14px;border-bottom:1px solid var(--slate-100);font-size:14px;">
      <div style="flex:1;min-width:0;">
        <div style="font-weight:600;margin-bottom:6px;">${i.nome} ${i.isNovo ? '<span style="font-size:11px;background:#fff7ed;color:var(--orange);padding:2px 6px;border-radius:4px;margin-left:4px;">novo</span>' : ''}</div>
        <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
          <input type="number" value="${i.qtd}" min="0.001" step="0.001" placeholder="Qtd"
            style="width:80px;padding:4px 8px;border:1.5px solid var(--slate-200);border-radius:6px;font-size:13px;background:var(--white);color:var(--slate-800);"
            onchange="_pedidoItens.find(x=>x.id==${i.id}).qtd=parseFloat(this.value)||0;renderizarFinalItens()"/>
          ${i.isNovo
            ? `<select style="padding:4px 8px;border:1.5px solid var(--orange);border-radius:6px;font-size:13px;color:var(--orange);font-weight:600;background:var(--white);"
                onchange="_pedidoItens.find(x=>x.id==${i.id}).unidade=this.value">
                ${UNIDADES.map(u => `<option value="${u}" ${u===i.unidade?'selected':''}>${u}</option>`).join('')}
               </select>`
            : `<span style="color:var(--slate-500);font-size:13px;">${i.unidade}</span>`
          }
        </div>
      </div>
      <button onclick="_pedidoItens=_pedidoItens.filter(x=>x.id!=${i.id});renderizarPedido();if(!_pedidoItens.length)fecharModalFinalizar();else renderizarFinalItens();" class="btn-icon" style="color:#dc2626;flex-shrink:0;">🗑️</button>
    </div>`).join('');
}

async function registrarPedido(abrirWhats = false) {
  if (!_pedidoItens.length) return;
  const data = document.getElementById('final-data').value || new Date().toISOString().slice(0,10);
  const selF = document.getElementById('final-fornecedor');
  const fornecedorId = selF.value || null;
  const fornecedorNome = selF.options[selF.selectedIndex]?.text || '';
  const fornecedorTel = selF.options[selF.selectedIndex]?.dataset?.tel || '';
  const observacao = fornecedorNome && fornecedorNome !== '— Sem fornecedor —' ? fornecedorNome : null;

  const registrarBtn = document.querySelector('#modal-finalizar button.btn-primary') || document.querySelector('#modal-finalizar .btn-primary');
  setBtnLoading(registrarBtn, true);
  const msgEl = document.getElementById('final-msg');
  msgEl.style.cssText = 'font-size:13px;padding:8px 12px;border-radius:8px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;';
  msgEl.textContent = 'Registrando pedido...';
  msgEl.classList.remove('hidden');

  const itensPayload = _pedidoItens.map(i => ({
    produto_id: i.isNovo ? null : i.prodId,
    nome: i.nome,
    unidade: i.qtdKg ? 'kg' : i.unidade,
    quantidade: i.qtdKg ?? i.qtd,
    custo: i.custo,
    minimo: i.minimo,
    isNovo: i.isNovo
  }));

  // Se estiver editando um pedido existente, apaga o original antes de recriar
  if (_pedidoEditandoId) {
    await api(`/compras/pedidos/${_pedidoEditandoId}`, { method: 'DELETE' });
    _pedidoEditandoId = null;
  }

  const r = await fetch(`${API}/compras/pedidos`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ fornecedor_id: fornecedorId, observacao, data, itens: itensPayload })
  });

  setBtnLoading(registrarBtn, false);
  if (!r.ok) {
    const err = await r.json().catch(() => ({}));
    msgEl.style.cssText = 'font-size:13px;padding:8px 12px;border-radius:8px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
    msgEl.textContent = `❌ ${err.erro || 'Erro ao registrar pedido.'}`;
    return;
  }

  if (abrirWhats) {
    const dataFmt = new Date(data + 'T12:00:00').toLocaleDateString('pt-BR');
    let msg = `*Pedido de compra* — ${dataFmt}\n`;
    if (observacao) msg += `Fornecedor: *${observacao}*\n`;
    msg += `\n`;
    _pedidoItens.forEach(i => { msg += `• ${i.nome}: *${fmtQtd(i.qtd)} ${i.unidade}*\n`; });
    const tel = fornecedorTel.replace(/\D/g,'');
    const url = tel ? `https://wa.me/55${tel}?text=${encodeURIComponent(msg)}` : `https://wa.me/?text=${encodeURIComponent(msg)}`;
    abrirWhatsAppComRetorno(url);
  }

  _pedidoItens = [];
  renderizarPedido();
  fecharModalFinalizar();
  mostrarMsgCompra('✅ Pedido registrado! Confirme o recebimento quando a mercadoria chegar.', 'ok');
  carregarCompras();
}

async function confirmarRecebimentoPedido(id) {
  if (!confirm('Confirmar recebimento? O estoque será atualizado agora.')) return;
  const receberBtn = document.querySelector(`.btn-receber[onclick*="${id}"]`);
  setBtnLoading(receberBtn, true);
  const r = await fetch(`${API}/compras/pedidos/${id}/receber`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  setBtnLoading(receberBtn, false);
  if (r.ok) {
    mostrarMsgCompra('✅ Recebimento confirmado! Estoque atualizado.', 'ok');
    carregarCompras();
  } else {
    const err = await r.json().catch(() => ({}));
    mostrarMsgCompra(`❌ ${err.erro || 'Erro ao confirmar recebimento.'}`, 'err');
  }
}

async function cancelarPedido(id) {
  if (!confirm('Cancelar este pedido?')) return;
  await fetch(`${API}/compras/pedidos/${id}/cancelar`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  carregarCompras();
}

// ── Correção de itens sem nome no pedido ───────────────────────
let _correcaoSelecionado = {}; // itemKey → { produto_id, nome }

function abrirCorrecaoItem(itemKey, pedidoId, itemIdx) {
  document.getElementById(`correcao-${itemKey}`).classList.remove('hidden');
  document.getElementById(`inp-${itemKey}`).focus();
}

function fecharCorrecaoItem(itemKey) {
  document.getElementById(`correcao-${itemKey}`).classList.add('hidden');
  document.getElementById(`inp-${itemKey}`).value = '';
  document.getElementById(`lista-${itemKey}`).classList.add('hidden');
  document.getElementById(`btn-salvar-${itemKey}`).disabled = true;
  delete _correcaoSelecionado[itemKey];
}

function filtrarCorrecaoItem(itemKey) {
  const inp = document.getElementById(`inp-${itemKey}`);
  const lista = document.getElementById(`lista-${itemKey}`);
  const btn = document.getElementById(`btn-salvar-${itemKey}`);
  const termo = inp.value.trim().toLowerCase();
  delete _correcaoSelecionado[itemKey];
  btn.disabled = true;

  if (termo.length < 1) { lista.classList.add('hidden'); return; }

  const prods = (_produtosCache || []).filter(p => p.nome.toLowerCase().includes(termo));
  if (!prods.length) {
    // Permite digitar nome novo
    lista.innerHTML = `<div class="autocomplete-item" onclick="selecionarCorrecaoNovo('${itemKey}', '${inp.value.replace(/'/g,"\\'")}')">
      <strong>+ Cadastrar como novo:</strong> "${inp.value}"
    </div>`;
    lista.classList.remove('hidden');
    return;
  }

  lista.innerHTML = prods.slice(0, 8).map(p =>
    `<div class="autocomplete-item" onclick="selecionarCorrecaoExistente('${itemKey}', ${p.id}, '${p.nome.replace(/'/g,"\\'")}')">
      ${p.nome} <span style="color:var(--slate-400);font-size:0.8em;">${p.unidade}</span>
    </div>`
  ).join('');
  lista.classList.remove('hidden');
}

function selecionarCorrecaoExistente(itemKey, prodId, nome) {
  _correcaoSelecionado[itemKey] = { produto_id: prodId, nome };
  document.getElementById(`inp-${itemKey}`).value = nome;
  document.getElementById(`lista-${itemKey}`).classList.add('hidden');
  document.getElementById(`btn-salvar-${itemKey}`).disabled = false;
}

function selecionarCorrecaoNovo(itemKey, nome) {
  _correcaoSelecionado[itemKey] = { produto_id: null, nome };
  document.getElementById(`inp-${itemKey}`).value = nome;
  document.getElementById(`lista-${itemKey}`).classList.add('hidden');
  document.getElementById(`btn-salvar-${itemKey}`).disabled = false;
}

async function salvarCorrecaoItem(itemKey, pedidoId, itemIdx) {
  const sel = _correcaoSelecionado[itemKey];
  if (!sel) return;

  const r = await api(`/compras/pedidos/${pedidoId}/corrigir-item`, {
    method: 'POST',
    body: JSON.stringify({ item_idx: itemIdx, produto_id: sel.produto_id, nome_temp: sel.nome })
  });

  if (r && r.ok) {
    mostrarToast('Item corrigido!', 'ok');
    carregarCompras();
  } else {
    mostrarToast(r?.erro || 'Erro ao salvar correção.', 'err');
  }
}

let _pedidoEditandoId = null;

async function reabrirPedido(id) {
  // Busca os dados do pedido pendente
  const pendentes = await api('/compras/pedidos') || [];
  const pedido = pendentes.find(p => p.id === id);
  if (!pedido) return;

  // Guarda o ID do pedido sendo editado — o cancelamento só ocorre ao salvar
  _pedidoEditandoId = id;

  // Restaura os itens no carrinho sem cancelar o pedido original
  _pedidoItens = pedido.itens.map(i => ({
    id: Date.now() + Math.random(),
    prodId: i.produto_id,
    nome: i.produto,
    unidade: i.unidade,
    qtd: parseFloat(i.quantidade),
    custo: parseFloat(i.custo_unitario || 0),
    isNovo: !!i.is_novo,
    minimo: 0
  }));

  await carregarCompras();
  renderizarPedido();

  const selF = document.getElementById('compra-fornecedor');
  if (pedido.fornecedor_id) selF.value = pedido.fornecedor_id;

  abrirModalFinalizar();
  mostrarMsgCompra('📝 Edite o pedido e clique em "Registrar" para salvar as alterações.', 'ok');
}

async function enviarPedidoWhatsApp(tel, nomeForn) {
  const prods = await api('/produtos?alerta=minimo') || [];
  const zerados = await api('/produtos?alerta=zerado') || [];
  const todos = [...zerados, ...prods.filter(p => !zerados.find(z => z.id === p.id))];
  const nomePadaria = document.getElementById('sidebar-nome').textContent;
  let msg = `*PEDIDO — ${nomePadaria}*\n${new Date().toLocaleDateString('pt-BR')}\n\nOla, *${nomeForn}*! Segue nossa lista de compras:\n\n`;
  if (todos.length) {
    todos.forEach(p => {
      const falta = Math.max(0, p.estoque_minimo - p.estoque_atual);
      msg += `• ${p.nome}: *${fmtQtd(falta)} ${p.unidade}*\n`;
    });
  } else {
    msg += '_Nenhum item critico no momento._\n';
  }
  msg += '\nAguardamos confirmacao. Obrigado!';
  const numero = tel.startsWith('55') ? tel : '55' + tel;
  abrirWhatsAppComRetorno(`https://wa.me/${numero}?text=${encodeURIComponent(msg)}`);
}

function abrirWhatsAppComRetorno(url) {
  // Abre WhatsApp em nova aba para não sair do app
  window.open(url, '_blank');
  // Quando o usuário voltar para esta aba, recarrega a página de compras
  const handler = () => {
    if (document.visibilityState === 'visible') {
      document.removeEventListener('visibilitychange', handler);
      carregarCompras();
    }
  };
  document.addEventListener('visibilitychange', handler);
}

async function gerarListaCompras() {
  const prods = await api('/produtos?alerta=minimo') || [];
  const zerados = await api('/produtos?alerta=zerado') || [];
  const todos = [...zerados, ...prods.filter(p => !zerados.find(z => z.id === p.id))];
  if (!todos.length) return alert('✅ Nenhum produto precisa de reposição!');
  let txt = `📋 LISTA DE COMPRAS — ${document.getElementById('sidebar-nome').textContent}\n`;
  txt += new Date().toLocaleDateString('pt-BR') + '\n\n';
  todos.forEach(p => {
    const falta = Math.max(0, p.estoque_minimo - p.estoque_atual);
    txt += `• ${p.nome}: ${fmtQtd(falta)} ${p.unidade}\n`;
  });
  const blob = new Blob([txt], { type: 'text/plain' });
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = 'lista-compras.txt';
  a.click();
}

function abrirModalFornecedor() {
  document.getElementById('form-forn').reset();
  document.getElementById('modal-forn').classList.remove('hidden');
}

function mostrarErrocampo(id, msg) {
  const el = document.getElementById(id);
  if (!el) return;
  el.style.borderColor = '#dc2626';
  let err = el.parentElement.querySelector('.campo-erro');
  if (!err) { err = document.createElement('span'); err.className = 'campo-erro'; err.style.cssText = 'color:#dc2626;font-size:12px;margin-top:3px;display:block;'; el.parentElement.appendChild(err); }
  err.textContent = msg;
  el.addEventListener('input', function limpar() { el.style.borderColor = ''; if (err) err.textContent = ''; el.removeEventListener('input', limpar); }, { once: true });
}

function limparErrosCampo(...ids) {
  ids.forEach(id => {
    const el = document.getElementById(id);
    if (!el) return;
    el.style.borderColor = '';
    const err = el.parentElement?.querySelector('.campo-erro');
    if (err) err.textContent = '';
  });
}

async function salvarFornecedor(e) {
  e.preventDefault();
  const nome = document.getElementById('forn-nome').value.trim();
  const email = document.getElementById('forn-email').value.trim();
  limparErrosCampo('forn-nome', 'forn-email');
  let ok = true;
  if (!nome) { mostrarErrocampo('forn-nome', 'Nome do fornecedor é obrigatório.'); ok = false; }
  if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { mostrarErrocampo('forn-email', 'E-mail inválido.'); ok = false; }
  if (!ok) return;
  const body = {
    nome,
    contato:  document.getElementById('forn-contato').value.trim(),
    telefone: document.getElementById('forn-tel').value.trim(),
    email:    email || null,
  };
  const r = await fetch(`${API}/fornecedores`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  if (r.ok) { fecharModal('modal-forn'); carregarFornecedores(); carregarCompras(); }
  else { const d = await r.json(); mostrarToast(d.erro || 'Erro ao salvar fornecedor.', 'err'); }
}

async function carregarFornecedores() {
  const forn = await api('/fornecedores') || [];
  const lf = document.getElementById('lista-fornecedores');
  if (!lf) return;
  if (!forn.length) {
    lf.innerHTML = '<p style="color:var(--slate-400);font-size:14px;padding:8px 0;">Nenhum fornecedor cadastrado ainda.</p>';
  } else {
    lf.innerHTML = forn.map(f => {
      const tel = (f.telefone || '').replace(/\D/g, '');
      const waBtn = tel.length >= 10
        ? `<button onclick="window.open('https://wa.me/55${tel}','_blank')" class="btn-secondary" style="font-size:12px;padding:6px 10px;white-space:nowrap;display:inline-flex;align-items:center;gap:5px;"><svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07A19.5 19.5 0 0 1 4.69 13a19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 3.6 2.2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L7.91 9.82a16 16 0 0 0 6.29 6.29l1.88-1.88a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg> WhatsApp</button>`
        : '';
      return `<div class="repor-item" style="flex-wrap:wrap;gap:8px;">
        <div style="flex:1;min-width:0;">
          <div class="repor-item-name">${f.nome}</div>
          <div class="repor-item-sub">${f.telefone || '<em>Sem telefone</em>'} ${f.email ? '· ' + f.email : ''}</div>
        </div>
        <div style="display:flex;gap:6px;align-items:center;flex-shrink:0;">
          ${waBtn}
          <button onclick="abrirHistoricoFornecedor(${f.id},'${f.nome.replace(/'/g,"\\'")}')" class="btn-icon" title="Histórico de compras"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/><polyline points="10 9 9 9 8 9"/></svg></button>
          <button onclick="editarFornecedor(${f.id},'${f.nome.replace(/'/g,"\\'")}','${(f.contato||'').replace(/'/g,"\\'")}','${(f.telefone||'').replace(/'/g,"\\'")}','${(f.email||'').replace(/'/g,"\\'")}')" class="btn-icon" title="Editar"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg></button>
          <button onclick="excluirFornecedor(${f.id})" class="btn-icon" style="color:#dc2626;" title="Excluir"><svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2L5 6"/><path d="M10 11v6"/><path d="M14 11v6"/><path d="M9 6V4a1 1 0 0 1 1-1h4a1 1 0 0 1 1 1v2"/></svg></button>
        </div>
      </div>`;
    }).join('');
  }
}

async function excluirFornecedor(id) {
  if (!confirm('Excluir este fornecedor?')) return;
  await fetch(`${API}/fornecedores/${id}`, {
    method: 'DELETE', headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  mostrarToast('🗑️ Fornecedor excluído.', 'info');
  carregarFornecedores();
}

function editarFornecedor(id, nome, contato, tel, email) {
  document.getElementById('editar-forn-id').value      = id;
  document.getElementById('editar-forn-nome').value    = nome;
  document.getElementById('editar-forn-contato').value = contato;
  document.getElementById('editar-forn-tel').value     = tel;
  document.getElementById('editar-forn-email').value   = email;
  document.getElementById('modal-editar-forn').classList.remove('hidden');
}

async function salvarEdicaoFornecedor(e) {
  if (e) e.preventDefault();
  const id    = document.getElementById('editar-forn-id').value;
  const nome  = document.getElementById('editar-forn-nome').value.trim();
  const email = document.getElementById('editar-forn-email').value.trim();
  limparErrosCampo('editar-forn-nome', 'editar-forn-email');
  let ok = true;
  if (!nome) { mostrarErrocampo('editar-forn-nome', 'Nome do fornecedor é obrigatório.'); ok = false; }
  if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) { mostrarErrocampo('editar-forn-email', 'E-mail inválido.'); ok = false; }
  if (!ok) return;
  const body = { nome, contato: document.getElementById('editar-forn-contato').value.trim(), telefone: document.getElementById('editar-forn-tel').value.trim(), email: email || null };
  const r = await fetch(`${API}/fornecedores/${id}`, {
    method: 'PUT',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  if (r.ok) { fecharModal('modal-editar-forn'); mostrarToast('✅ Fornecedor atualizado!', 'ok'); carregarFornecedores(); }
  else { const d = await r.json(); mostrarToast(d.erro || 'Erro ao atualizar.', 'err'); }
}

// ── Relatórios ────────────────────────────────────────────
function popularMeses() {
  const sel = document.getElementById('rel-mes');
  if (sel.options.length > 0) return;
  const hoje = new Date();
  for (let i = 0; i < 12; i++) {
    const d = new Date(hoje.getFullYear(), hoje.getMonth() - i, 1);
    const val = `${d.getFullYear()}-${String(d.getMonth()+1).padStart(2,'0')}`;
    const label = d.toLocaleDateString('pt-BR',{month:'long',year:'numeric'});
    const opt = new Option(label.charAt(0).toUpperCase()+label.slice(1), val);
    sel.appendChild(opt);
  }
}

function _pct(atual, anterior) {
  if (!anterior || anterior == 0) return '';
  const diff = ((atual - anterior) / anterior * 100).toFixed(0);
  const up = diff >= 0;
  return `<span class="rel-variacao ${up ? 'rel-up' : 'rel-down'}">${up ? '▲' : '▼'} ${Math.abs(diff)}%</span>`;
}

async function carregarRelatorios() {
  popularMeses();
  const mes = document.getElementById('rel-mes').value;
  const data = await api(`/relatorios/mes?mes=${mes}`);
  if (!data) return;

  const fmtR$ = v => 'R$ ' + parseFloat(v||0).toLocaleString('pt-BR',{minimumFractionDigits:2});
  const ant = data.mes_anterior || {};

  // ── KPIs com comparativo ──
  const saldo = parseFloat(data.total_entradas||0) - parseFloat(data.total_saidas||0);
  const relOculto = localStorage.getItem('rel-kpi-oculto') === '1';
  const relMask = v => relOculto ? '••••••' : v;
  const olhoIcon = relOculto
    ? '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/>'
    : '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>';

  document.getElementById('rel-kpis').innerHTML = `
    <div class="kpi-card" style="position:relative;">
      <button id="btn-rel-ocultar" onclick="toggleRelKpis()" style="position:absolute;top:8px;right:8px;background:none;border:none;cursor:pointer;color:var(--slate-400);padding:2px;" title="Ocultar/mostrar valores">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${olhoIcon}</svg>
      </button>
      <div class="kpi-label">Total entradas</div>
      <div class="kpi-value" style="color:#16a34a;">${relMask(fmtR$(data.total_entradas))}</div>
      ${_pct(data.total_entradas, ant.total_entradas)}
    </div>
    <div class="kpi-card">
      <div class="kpi-label">Total saídas (custo)</div>
      <div class="kpi-value" style="color:#dc2626;">${relMask(fmtR$(data.total_saidas))}</div>
      ${_pct(data.total_saidas, ant.total_saidas)}
    </div>
    <div class="kpi-card">
      <div class="kpi-label">Saldo do período</div>
      <div class="kpi-value" style="color:${saldo>=0?'#16a34a':'#dc2626'};">${relMask(fmtR$(saldo))}</div>
    </div>
    <div class="kpi-card">
      <div class="kpi-label">Movimentações</div>
      <div class="kpi-value">${relMask(String(data.qtd_movs||0))}</div>
      ${_pct(data.qtd_movs, ant.qtd_movs)}
    </div>
    <div class="kpi-card">
      <div class="kpi-label">Produtos movimentados</div>
      <div class="kpi-value">${relMask(String(data.prods_distintos||0))}</div>
    </div>
  `;

  window.toggleRelKpis = function() {
    const oculto = localStorage.getItem('rel-kpi-oculto') === '1';
    localStorage.setItem('rel-kpi-oculto', oculto ? '0' : '1');
    carregarRelatorios();
  };

  // ── Top 5 produtos ──
  document.getElementById('tabela-rel-top').innerHTML = data.top_produtos?.length
    ? data.top_produtos.map((p,i) => `<tr>
        <td><span class="rel-rank">${i+1}</span> ${p.nome}</td>
        <td class="right" style="color:#16a34a;">${fmtQtd(p.entradas)} ${p.unidade}</td>
        <td class="right" style="color:#dc2626;">${fmtQtd(p.saidas)} ${p.unidade}</td>
        <td class="right bold">${p.qtd_movs}</td>
      </tr>`).join('')
    : '<tr><td colspan="4" class="empty-row">Nenhum produto movimentado</td></tr>';

  // ── Compras por fornecedor ──
  document.getElementById('tabela-rel-compras').innerHTML = data.compras_fornecedor?.length
    ? data.compras_fornecedor.map(c => `<tr>
        <td class="td-main">${c.fornecedor}</td>
        <td class="right">${c.qtd_pedidos}</td>
        <td class="right bold">${fmtR$(c.total_gasto)}</td>
      </tr>`).join('')
    : '<tr><td colspan="3" class="empty-row">Nenhuma compra recebida no mês</td></tr>';

  // ── Por categoria ──
  document.getElementById('tabela-rel-cats').innerHTML = data.categorias?.length
    ? data.categorias.map(c => `<tr>
        <td class="td-main">${c.categoria}</td>
        <td class="right" style="color:#16a34a;">${fmtR$(c.total_entradas)}</td>
        <td class="right" style="color:#dc2626;">${fmtR$(c.total_saidas)}</td>
        <td class="right">${c.movs}</td>
      </tr>`).join('')
    : '<tr><td colspan="4" class="empty-row">Sem dados</td></tr>';

  // ── Alertas de estoque ──
  document.getElementById('tabela-rel-alertas').innerHTML = data.alertas?.length
    ? data.alertas.map(p => `<tr>
        <td class="td-main">${p.nome}</td>
        <td class="right">${fmtQtd(p.estoque_atual)} ${p.unidade}</td>
        <td class="right">${fmtQtd(p.estoque_minimo)} ${p.unidade}</td>
        <td class="center">${p.alerta === 'zerado'
          ? '<span class="badge badge-zero">🔴 Zerado</span>'
          : '<span class="badge badge-min">⚠️ Baixo</span>'}</td>
      </tr>`).join('')
    : '<tr><td colspan="4" class="empty-row" style="color:#16a34a;">✅ Estoque OK</td></tr>';

  // ── Movimentações detalhadas ──
  const tiposEmoji = { entrada:'📥 Entrada', saida:'📤 Saída', ajuste:'⚙️ Ajuste', sync_saurus:'🔄 Saurus' };
  const tiposTexto = { entrada:'Entrada', saida:'Saída', ajuste:'Ajuste', sync_saurus:'Saurus' };
  document.getElementById('tabela-rel-movs').innerHTML = data.movs?.length
    ? data.movs.map(m => {
        const isSaida = m.tipo === 'saida';
        return `<tr class="${isSaida ? 'tr-saida' : ''}">
          <td class="td-main">${m.produto}</td>
          <td style="color:var(--slate-500);font-size:12px;">${m.categoria||'—'}</td>
          <td><span class="tipo-tela">${tiposEmoji[m.tipo]||m.tipo}</span><span class="tipo-print">${tiposTexto[m.tipo]||m.tipo}</span></td>
          <td class="right td-mono">${fmtQtd(m.quantidade)}</td>
          <td class="right">R$ ${parseFloat(m.custo_unit||0).toFixed(2)}</td>
          <td class="right bold">R$ ${parseFloat(m.valor_total||0).toFixed(2)}</td>
          <td>${new Date(m.data).toLocaleDateString('pt-BR')}</td>
        </tr>`;
      }).join('')
    : '<tr class="empty-row"><td colspan="7">Nenhuma movimentação neste mês</td></tr>';
}

function imprimirRelatorio() {
  const nomePadaria = document.getElementById('sidebar-nome').textContent.trim();
  const periodo = document.getElementById('rel-mes')?.selectedOptions[0]?.text || '';
  const secao = document.getElementById('pg-relatorios');
  secao.setAttribute('data-padaria', nomePadaria);
  secao.setAttribute('data-periodo', 'Relatório de ' + periodo);
  document.title = nomePadaria + ' — Relatório ' + periodo;
  window.print();
  document.title = 'PanificaPro';
}

function statusBadge(p) {
  const hoje = new Date(); hoje.setHours(0,0,0,0);
  const val  = p.validade ? new Date(p.validade) : null;
  if (p.estoque_atual <= 0) return '<span class="badge badge-zero">🔴 Sem estoque</span>';
  if (p.estoque_minimo > 0 && p.estoque_atual <= p.estoque_minimo) return '<span class="badge badge-min">⚠️ Abaixo mín.</span>';
  if (val && val <= new Date(hoje.getTime() + 10*86400000)) return '<span class="badge badge-validade">🟡 Vencendo</span>';
  return '<span class="badge badge-ok">✅ OK</span>';
}

async function carregarCategorias() {
  const [cats, forns] = await Promise.all([api('/categorias'), api('/fornecedores')]);
  // Filtro de categoria no estoque
  const filtroCat = document.getElementById('filtro-categoria');
  if (cats && filtroCat) {
    const atual = filtroCat.value;
    filtroCat.innerHTML = '<option value="">Categoria</option>' +
      cats.map(c => `<option value="${c.id}" ${String(c.id) === atual ? 'selected' : ''}>${c.nome}</option>`).join('');
  }
  // Select de categoria no modal de produto
  const selCat = document.getElementById('prod-categoria');
  if (cats && selCat) {
    selCat.innerHTML = '<option value="">— Sem categoria —</option>' +
      cats.map(c => `<option value="${c.id}">${c.nome}</option>`).join('');
  }
  const selForn = document.getElementById('prod-fornecedor');
  if (forns && selForn) {
    selForn.innerHTML = '<option value="">— Sem fornecedor —</option>' +
      forns.map(f => `<option value="${f.id}">${f.nome}</option>`).join('');
  }
}

async function criarCategoria() {
  const nome = prompt('Nome da nova categoria:');
  if (!nome || !nome.trim()) return;
  const r = await fetch(`${API}/categorias`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ nome: nome.trim() })
  });
  const d = await r.json();
  if (!r.ok) return alert('Erro: ' + d.erro);
  await carregarCategorias();
  document.getElementById('prod-categoria').value = d.id;
}

// Controla se o "Código da balança" deve se auto-preencher a partir do "Código
// de barras" digitado (fórmula código × 100, igual ao preenchimento em massa).
// Fica true em produto novo, ou se a pessoa nunca digitou nada manual ali.
let _codBalancaAutoPreenchido = true;
function autoPreencherCodigoBalanca(codigoBarras) {
  if (!_codBalancaAutoPreenchido) return;
  const campo = document.getElementById('prod-cod-balanca');
  const codigo = String(codigoBarras || '').trim();
  if (!/^\d{1,4}$/.test(codigo)) { campo.value = ''; return; }
  campo.value = String(parseInt(codigo, 10) * 100).padStart(6, '0');
}

function abrirModalProduto() {
  document.getElementById('prod-id').value = '';
  document.getElementById('modal-titulo').textContent = 'Novo produto';
  document.getElementById('form-produto').reset();
  _codBalancaAutoPreenchido = true; // produto novo — pode auto-preencher
  document.getElementById('wrap-prod-cest').classList.add('hidden');
  document.getElementById('wrap-saldo').classList.remove('hidden');
  document.getElementById('bloco-embalagem').classList.add('hidden');
  document.getElementById('prod-embalagem-resultado').textContent = '—';
  document.getElementById('bloco-estoque-embalagem').classList.add('hidden');
  document.getElementById('prod-estoque-embalagens').value = '';
  document.getElementById('prod-estoque-embalagem-tamanho').value = '';
  document.getElementById('prod-estoque-embalagem-resultado').textContent = '—';
  atualizarLabelEmbalagem();
  document.getElementById('modal-produto').classList.remove('hidden');
}

async function editarProduto(id) {
  const p = await api(`/produtos/${id}`);
  if (!p) return;
  document.getElementById('prod-id').value      = p.id;
  document.getElementById('prod-nome').value    = p.nome;
  document.getElementById('prod-cod').value     = p.codigo_barras || '';
  document.getElementById('prod-cod-balanca').value = p.codigo_balanca || '';
  // Produto existente sem código de balança ainda: deixa auto-preencher se a
  // pessoa digitar/mudar o código de barras. Se já tem um valor salvo, não mexe
  // sozinho (pode ser um código manual que não segue a fórmula padrão).
  _codBalancaAutoPreenchido = !p.codigo_balanca;
  document.getElementById('prod-ncm').value = p.ncm || '';
  document.getElementById('prod-origem-producao').value = p.origem_producao || 'revenda';
  document.getElementById('prod-situacao-icms').value = p.situacao_icms || 'normal';
  document.getElementById('prod-cest').value = p.cest || '';
  document.getElementById('wrap-prod-cest').classList.toggle('hidden', (p.situacao_icms || 'normal') !== 'st');
  document.getElementById('prod-unidade').value = p.unidade;
  document.getElementById('prod-minimo').value  = Math.round(p.estoque_minimo || 0);
  document.getElementById('prod-custo').value   = parseFloat(p.custo_unitario || 0).toFixed(4);
  document.getElementById('prod-venda').value   = parseFloat(p.preco_venda || 0).toFixed(2);
  document.getElementById('prod-validade').value      = p.validade ? p.validade.slice(0,10) : '';
  document.getElementById('prod-ultima-compra').value = p.ultima_compra ? new Date(p.ultima_compra).toISOString().slice(0,10) : '';
  document.getElementById('prod-categoria').value  = p.categoria_id || '';
  document.getElementById('prod-fornecedor').value = p.fornecedor_id || '';
  document.getElementById('prod-saldo').value   = parseFloat(p.estoque_atual || 0);
  document.getElementById('prod-venda-rapida').checked = !!p.venda_rapida;
  document.getElementById('prod-controla-estoque').checked = p.controla_estoque !== 0;
  document.getElementById('wrap-saldo').classList.remove('hidden');
  atualizarLabelEmbalagem();
  if (p.embalagem_preco && p.embalagem_qtd) {
    document.getElementById('prod-embalagem-preco').value = p.embalagem_preco;
    document.getElementById('prod-embalagem-qtd').value   = p.embalagem_qtd;
    document.getElementById('bloco-embalagem').classList.remove('hidden');
    calcularCustoPorEmbalagem(false);
  } else {
    document.getElementById('prod-embalagem-preco').value = '';
    document.getElementById('prod-embalagem-qtd').value   = '';
    document.getElementById('prod-embalagem-resultado').textContent = '—';
    document.getElementById('bloco-embalagem').classList.add('hidden');
  }
  document.getElementById('bloco-estoque-embalagem').classList.add('hidden');
  document.getElementById('prod-estoque-embalagens').value = '';
  document.getElementById('prod-estoque-embalagem-tamanho').value = '';
  document.getElementById('prod-estoque-embalagem-resultado').textContent = '—';
  document.getElementById('modal-titulo').textContent = 'Editar produto';
  document.getElementById('modal-produto').classList.remove('hidden');
}

function toggleModoEmbalagem() {
  const bloco = document.getElementById('bloco-embalagem');
  bloco.classList.toggle('hidden');
  if (!bloco.classList.contains('hidden')) atualizarLabelEmbalagem();
}

function atualizarLabelEmbalagem() {
  const unidade = document.getElementById('prod-unidade').value || 'unidade';
  const label = document.getElementById('prod-embalagem-unidade-label');
  if (label) label.textContent = unidade;
}

function calcularCustoPorEmbalagem(atualizarCusto = true) {
  const preco = parseFloat(document.getElementById('prod-embalagem-preco').value || 0);
  const qtd   = parseFloat(document.getElementById('prod-embalagem-qtd').value || 0);
  const unidade = document.getElementById('prod-unidade').value || 'unidade';
  const resultadoEl = document.getElementById('prod-embalagem-resultado');
  if (preco > 0 && qtd > 0) {
    const custoPorUnidade = preco / qtd;
    resultadoEl.textContent = `R$ ${custoPorUnidade.toFixed(4)} por ${unidade}`;
    if (atualizarCusto) document.getElementById('prod-custo').value = custoPorUnidade.toFixed(4);
  } else {
    resultadoEl.textContent = '—';
  }
}

function toggleModoEstoquePorEmbalagem() {
  const bloco = document.getElementById('bloco-estoque-embalagem');
  bloco.classList.toggle('hidden');
  if (!bloco.classList.contains('hidden')) {
    // Reaproveita o tamanho da embalagem já informado no cálculo de custo, se houver
    const tamanhoEl = document.getElementById('prod-estoque-embalagem-tamanho');
    const embQtd = parseFloat(document.getElementById('prod-embalagem-qtd').value || 0);
    if (!tamanhoEl.value && embQtd > 0) tamanhoEl.value = embQtd;
    document.getElementById('prod-estoque-embalagem-unidade-label').textContent = document.getElementById('prod-unidade').value || 'unidade';
    calcularSaldoPorEmbalagem();
  }
}

function calcularSaldoPorEmbalagem() {
  const qtdEmb   = parseFloat(document.getElementById('prod-estoque-embalagens').value || 0);
  const tamanho  = parseFloat(document.getElementById('prod-estoque-embalagem-tamanho').value || 0);
  const unidade  = document.getElementById('prod-unidade').value || 'unidade';
  const resultadoEl = document.getElementById('prod-estoque-embalagem-resultado');
  if (qtdEmb > 0 && tamanho > 0) {
    const total = qtdEmb * tamanho;
    resultadoEl.textContent = `${total} ${unidade}`;
    document.getElementById('prod-saldo').value = total;
  } else {
    resultadoEl.textContent = '—';
  }
}

// D) Product edit feedback
async function salvarProduto(e) {
  e.preventDefault();
  const nome   = document.getElementById('prod-nome').value.trim();
  const custo  = parseFloat(document.getElementById('prod-custo').value || 0);
  const preco  = parseFloat(document.getElementById('prod-venda').value || 0);
  const estMin = parseFloat(document.getElementById('prod-minimo').value || 0);
  const saldo  = parseFloat(document.getElementById('prod-saldo').value || 0);
  limparErrosCampo('prod-nome', 'prod-custo', 'prod-venda', 'prod-minimo', 'prod-saldo');
  let ok = true;
  if (!nome) { mostrarErrocampo('prod-nome', 'Nome do produto é obrigatório.'); ok = false; }
  if (custo < 0) { mostrarErrocampo('prod-custo', 'Custo não pode ser negativo.'); ok = false; }
  if (preco < 0) { mostrarErrocampo('prod-venda', 'Preço não pode ser negativo.'); ok = false; }
  if (estMin < 0) { mostrarErrocampo('prod-minimo', 'Estoque mínimo não pode ser negativo.'); ok = false; }
  if (saldo < 0) { mostrarErrocampo('prod-saldo', 'Saldo não pode ser negativo.'); ok = false; }
  if (!ok) return;
  const submitBtn = e.submitter || document.querySelector('#modal-produto button[type=submit]');
  setBtnLoading(submitBtn, true);
  const id = document.getElementById('prod-id').value;
  const body = {
    nome:          document.getElementById('prod-nome').value,
    codigo_barras: document.getElementById('prod-cod').value || null,
    codigo_balanca: document.getElementById('prod-cod-balanca').value.trim() || null,
    ncm:           document.getElementById('prod-ncm').value.trim().replace(/\D/g, '') || null,
    origem_producao: document.getElementById('prod-origem-producao').value,
    situacao_icms: document.getElementById('prod-situacao-icms').value,
    cest:          document.getElementById('prod-cest').value.trim().replace(/\D/g, '') || null,
    unidade:       document.getElementById('prod-unidade').value,
    categoria_id:  document.getElementById('prod-categoria').value || null,
    fornecedor_id: document.getElementById('prod-fornecedor').value || null,
    estoque_minimo:parseFloat(document.getElementById('prod-minimo').value) || 0,
    custo_unitario:parseFloat(document.getElementById('prod-custo').value) || 0,
    preco_venda:   parseFloat(document.getElementById('prod-venda').value) || 0,
    validade:       document.getElementById('prod-validade').value || null,
    ultima_compra:  document.getElementById('prod-ultima-compra').value || null,
    venda_rapida:   document.getElementById('prod-venda-rapida').checked ? 1 : 0,
    controla_estoque: document.getElementById('prod-controla-estoque').checked ? 1 : 0,
  };
  body.estoque_atual = parseFloat(document.getElementById('prod-saldo').value) || 0;
  if (!document.getElementById('bloco-embalagem').classList.contains('hidden')) {
    const embPreco = parseFloat(document.getElementById('prod-embalagem-preco').value || 0);
    const embQtd   = parseFloat(document.getElementById('prod-embalagem-qtd').value || 0);
    body.embalagem_preco = embPreco > 0 ? embPreco : null;
    body.embalagem_qtd   = embQtd > 0 ? embQtd : null;
  } else {
    body.embalagem_preco = null;
    body.embalagem_qtd   = null;
  }
  const r = await fetch(`${API}${id ? `/produtos/${id}` : '/produtos'}`, {
    method: id ? 'PUT' : 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  const res = r.ok ? await r.json() : await r.json().then(d => {
    if (d.erro === 'limite_plano') {
      mostrarToast(`Limite do plano ${d.plano} atingido (${d.limite} produtos). Faça upgrade!`, 'warn');
      return null;
    }
    mostrarToast(d.erro || 'Erro ao salvar.', 'err');
    return null;
  });
  setBtnLoading(submitBtn, false);
  if (id && res) {
    // Show success message in modal before closing
    const actions = document.querySelector('#form-produto .modal-actions');
    const feedback = document.createElement('div');
    feedback.style.cssText = 'font-size:13px;padding:8px 12px;border-radius:8px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;margin-bottom:8px;text-align:center;font-weight:600;';
    feedback.textContent = '✅ Produto atualizado!';
    actions.parentNode.insertBefore(feedback, actions);
    setTimeout(() => {
      fecharModal('modal-produto');
      if (feedback.parentNode) feedback.parentNode.removeChild(feedback);
      carregarProdutos();
    }, 1000);
  } else {
    fecharModal('modal-produto');
    carregarProdutos();
  }
}

// ── Movimentações ────────────────────────────────────────────
async function carregarMovimentacoes() {
  const movs = await api('/movimentacoes?limit=100');
  if (!movs) return;
  const tipos = { entrada:'📥 Entrada', saida:'📤 Saída', ajuste:'⚙️ Ajuste', sync_saurus:'🔄 Saurus' };
  document.getElementById('tabela-movs').innerHTML = movs.map(m => `
    <tr>
      <td style="color:var(--slate-600)">${new Date(m.data).toLocaleString('pt-BR')}</td>
      <td style="font-weight:600;color:var(--slate-800)">${m.produto}</td>
      <td class="center">${tipos[m.tipo] || m.tipo}</td>
      <td class="right td-mono">${fmtQtd(m.quantidade)} ${m.unidade}</td>
      <td class="right">${parseFloat(m.valor_total||0).toLocaleString('pt-BR',{style:'currency',currency:'BRL'})}</td>
      <td style="color:var(--slate-500)">${m.observacao || '—'}</td>
    </tr>`).join('') || '<tr class="empty-row"><td colspan="6">Nenhuma movimentação</td></tr>';
}

// ── Movimento rápido direto da tabela ────────────────────
function movRapido(prodId, tipo) {
  document.getElementById('form-mov').reset();
  document.getElementById('mov-produto-info').classList.add('hidden');
  const sel = document.getElementById('mov-produto');
  sel.innerHTML = '<option value="">— Selecione —</option>' +
    todosProds.map(p => `<option value="${p.id}">${p.nome}</option>`).join('');
  sel.value = prodId;
  document.getElementById('mov-tipo').value = tipo;
  const prod = todosProds.find(p => p.id === prodId);
  if (prod) {
    document.getElementById('mov-custo').value = prod.custo_unitario || 0;
    const info = document.getElementById('mov-produto-info');
    const cor = tipo === 'entrada' ? '#f0fdf4' : '#fef2f2';
    const borda = tipo === 'entrada' ? '#bbf7d0' : '#fecaca';
    const icon = tipo === 'entrada' ? '➕' : '➖';
    info.innerHTML = `<div style="background:${cor};border:1px solid ${borda};border-radius:8px;padding:10px 14px;margin-bottom:12px;font-size:13px;">
      ${icon} <strong>${prod.nome}</strong> — ${tipo === 'entrada' ? 'Entrada' : 'Saída'}<br>
      <span style="color:#64748b;">Estoque atual: <strong>${fmtQtd(prod.estoque_atual)} ${prod.unidade}</strong></span>
    </div>`;
    info.classList.remove('hidden');
  }
  document.getElementById('modal-mov').classList.remove('hidden');
  document.getElementById('mov-qtd').focus();
}

function abrirModalMovimento() {
  document.getElementById('form-mov').reset();
  document.getElementById('mov-produto-info').classList.add('hidden');
  const sel = document.getElementById('mov-produto');
  sel.innerHTML = '<option value="">— Selecione —</option>' +
    todosProds.map(p => `<option value="${p.id}">${p.nome}</option>`).join('');
  document.getElementById('modal-mov').classList.remove('hidden');
}

async function salvarMovimento(e) {
  e.preventDefault();
  const produtoId = parseInt(document.getElementById('mov-produto').value);
  const qtd   = parseFloat(document.getElementById('mov-qtd').value || 0);
  const custo = parseFloat(document.getElementById('mov-custo').value || 0);
  limparErrosCampo('mov-qtd', 'mov-custo', 'mov-produto');
  let ok = true;
  if (!produtoId) { mostrarErrocampo('mov-produto', 'Selecione um produto.'); ok = false; }
  if (qtd <= 0) { mostrarErrocampo('mov-qtd', 'Quantidade deve ser maior que zero.'); ok = false; }
  if (custo < 0) { mostrarErrocampo('mov-custo', 'Custo não pode ser negativo.'); ok = false; }
  if (!ok) return;
  const movBtn = e.submitter || document.querySelector('#modal-mov button[type=submit]');
  setBtnLoading(movBtn, true);
  try {
    const d = await api('/movimentacoes', {
      method: 'POST',
      body: {
        produto_id: produtoId,
        tipo:       document.getElementById('mov-tipo').value,
        quantidade: qtd,
        custo_unit: custo || 0,
        observacao: document.getElementById('mov-obs').value || null,
      }
    });
    if (!d) return; // api() já trata 401, 402 e erros de rede
    if (d.erro) { mostrarToast(`❌ ${d.erro}`); return; }
    fecharModal('modal-mov');
    mostrarToast('✅ Movimentação registrada!');
    carregarProdutos();
    carregarMovimentacoes();
    carregarDashboard();
  } catch(err) {
    mostrarToast('❌ Erro inesperado. Tente novamente.');
  } finally {
    setBtnLoading(movBtn, false);
  }
}

// ── Abas de Sync ─────────────────────────────────────────────
function mostrarTabSync(aba) {
  document.getElementById('sync-painel-saurus').classList.toggle('hidden', aba !== 'saurus');
  document.getElementById('sync-painel-generico').classList.toggle('hidden', aba !== 'generico');
  document.getElementById('tab-sync-saurus').classList.toggle('active', aba === 'saurus');
  document.getElementById('tab-sync-generico').classList.toggle('active', aba === 'generico');
}

// ── Importação Genérica ───────────────────────────────────────
const CAMPOS_IMPORT = [
  { key: 'nome',           label: 'Nome do produto',   obrigatorio: true  },
  { key: 'codigo_barras',  label: 'Código de barras',  obrigatorio: false },
  { key: 'estoque_atual',  label: 'Estoque atual',     obrigatorio: false },
  { key: 'custo_unitario', label: 'Custo unitário',    obrigatorio: false },
  { key: 'preco_venda',    label: 'Preço de venda',    obrigatorio: false },
  { key: 'unidade',        label: 'Unidade (kg, un…)', obrigatorio: false },
  { key: 'categoria',      label: 'Categoria',         obrigatorio: false },
  { key: 'estoque_minimo', label: 'Estoque mínimo',    obrigatorio: false },
];

let _importColunas = [];

async function previewImportacao() {
  const file = document.getElementById('arquivo-generico').files[0];
  if (!file) return alert('Selecione um arquivo .xlsx ou .csv.');
  const el = document.getElementById('resultado-import-preview');
  el.className = ''; el.textContent = '⏳ Lendo colunas…'; el.classList.remove('hidden');

  const fd = new FormData();
  fd.append('arquivo', file);
  const r = await fetch(`${API}/sync/preview`, {
    method: 'POST', headers: { Authorization: `Bearer ${TOKEN}` }, body: fd
  });
  const d = await r.json();
  if (!r.ok) { el.className = 'result-err'; el.textContent = `❌ ${d.erro}`; return; }

  _importColunas = d.colunas;
  el.classList.add('hidden');

  // Monta os selects de mapeamento
  const container = document.getElementById('import-mapeamento-campos');
  container.innerHTML = '';
  for (const campo of CAMPOS_IMPORT) {
    const opts = ['<option value="">(não importar)</option>',
      ..._importColunas.map(c => `<option value="${c}">${c}</option>`)].join('');
    // Tentativa de auto-match por similaridade
    const autoMatch = _importColunas.find(c =>
      c.toLowerCase().includes(campo.key.replace('_',' ').toLowerCase()) ||
      c.toLowerCase().replace(/[^a-z]/g,'').includes(campo.key.replace(/_/g,'').toLowerCase())
    ) || '';
    container.innerHTML += `
      <div class="form-group" style="margin-bottom:12px;">
        <label style="font-size:13px;font-weight:600;color:var(--slate-700);display:block;margin-bottom:4px;">
          ${campo.label}${campo.obrigatorio ? ' <span style="color:#dc2626">*</span>' : ''}
        </label>
        <select id="map-${campo.key}" class="form-control">
          ${opts}
        </select>
      </div>`;
    if (autoMatch) document.getElementById(`map-${campo.key}`).value = autoMatch;
  }

  document.getElementById('import-passo1').classList.add('hidden');
  document.getElementById('import-passo2').classList.remove('hidden');
}

function voltarImportPasso1() {
  document.getElementById('import-passo2').classList.add('hidden');
  document.getElementById('import-passo1').classList.remove('hidden');
  document.getElementById('resultado-import').classList.add('hidden');
}

async function confirmarImportacao() {
  const file = document.getElementById('arquivo-generico').files[0];
  if (!file) { voltarImportPasso1(); return; }

  const mapeamento = {};
  for (const campo of CAMPOS_IMPORT) {
    const val = document.getElementById(`map-${campo.key}`).value;
    if (val) mapeamento[campo.key] = val;
  }
  if (!mapeamento.nome) return alert('Selecione a coluna correspondente ao "Nome do produto".');

  const el = document.getElementById('resultado-import');
  el.className = ''; el.textContent = '⏳ Importando…'; el.classList.remove('hidden');

  const fd = new FormData();
  fd.append('arquivo', file);
  fd.append('mapeamento', JSON.stringify(mapeamento));
  const r = await fetch(`${API}/sync/generico`, {
    method: 'POST', headers: { Authorization: `Bearer ${TOKEN}` }, body: fd
  });
  const d = await r.json();
  if (r.ok) {
    el.className = 'result-ok';
    el.textContent = `✅ Importação concluída! ${d.atualizados} atualizados, ${d.criados} novos, ${d.ignorados} ignorados.`;
  } else {
    el.className = 'result-err';
    el.textContent = `❌ Erro: ${d.erro}`;
  }
}

// ── Sync Saurus ──────────────────────────────────────────────
async function sincronizarSaurus(e) {
  e.preventDefault();
  const file = document.getElementById('arquivo-saurus').files[0];
  if (!file) return alert('Selecione o arquivo .xlsx do Saurus.');
  const loja = document.getElementById('sync-loja').value;
  const fd = new FormData();
  fd.append('arquivo', file);
  if (loja) fd.append('loja', loja);
  const r = await fetch(`${API}/sync/saurus`, {
    method: 'POST', headers: { 'Authorization': `Bearer ${TOKEN}` }, body: fd
  });
  const d = await r.json();
  const el = document.getElementById('resultado-sync');
  el.classList.remove('hidden');
  if (r.ok) {
    el.className = 'result-ok';
    const lojaInfo = loja ? ` (loja ${loja})` : '';
    const balcaoInfo = (d.balcaoCriados || d.balcaoAtualizados)
      ? ` · Balcão: ${d.balcaoCriados || 0} novos, ${d.balcaoAtualizados || 0} atualizados.`
      : '';
    const resumo = `✅ Sync concluído${lojaInfo}! Mercado: ${d.atualizados} atualizados, ${d.criados} novos.${balcaoInfo} ${d.ignorados} ignorados.`;

    const vendidos = d.vendidos || [];
    let vendidosHtml = '';
    if (vendidos.length) {
      vendidosHtml = `
        <div class="sync-vendidos">
          <div class="sync-vendidos-titulo">🧾 O que passou pelo caixa desde a última atualização</div>
          <div class="sync-vendidos-total">${fmtMoeda(d.totalVendidoEstimado)} <span>estimado em vendas</span></div>
          <div class="sync-vendidos-lista">
            ${vendidos.slice(0, 30).map(v => `
              <div class="sync-vendido-item">
                <span class="sync-vendido-nome">${v.nome}</span>
                <span class="sync-vendido-qtd">${fmtQtd(v.quantidade)} ${v.unidade}</span>
                <span class="sync-vendido-valor">${fmtMoeda(v.valorEstimado)}</span>
              </div>
            `).join('')}
            ${vendidos.length > 30 ? `<div class="sync-vendido-mais">+ ${vendidos.length - 30} outros produtos</div>` : ''}
          </div>
        </div>`;
    }

    el.innerHTML = `<div>${resumo}</div>${vendidosHtml}`;
  } else {
    el.className = 'result-err';
    el.textContent = `❌ Erro: ${d.erro}`;
  }
}

function abrirModalLimpar() {
  document.getElementById('input-confirmar-apagar').value = '';
  verificarSenhaApagar('');
  document.getElementById('modal-limpar').classList.remove('hidden');
  setTimeout(() => document.getElementById('input-confirmar-apagar').focus(), 100);
}

function fecharModalLimpar() {
  document.getElementById('modal-limpar').classList.add('hidden');
}

function verificarSenhaApagar(val) {
  const btn = document.getElementById('btn-confirmar-apagar');
  const ok = val.trim() === 'APAGAR TUDO';
  btn.disabled = !ok;
  btn.style.opacity = ok ? '1' : '0.4';
  btn.style.cursor  = ok ? 'pointer' : 'not-allowed';
}

async function executarLimparDados() {
  fecharModalLimpar();
  const r = await fetch(`${API}/dados/limpar`, {
    method: 'DELETE', headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const d = await r.json();
  if (r.ok) {
    alert(`✅ Dados removidos! ${d.produtos} produtos e ${d.movimentacoes} movimentações excluídos.`);
    carregarDashboard();
  } else {
    alert(`❌ Erro: ${d.erro}`);
  }
}

function fecharModal(id) { document.getElementById(id).classList.add('hidden'); }

function toggleSidebar() {
  const sb = document.getElementById('sidebar');
  const ov = document.getElementById('sidebar-overlay');
  const hb = document.getElementById('btn-hamburger');
  const open = sb.classList.toggle('open');
  ov.classList.toggle('open', open);
  hb.classList.toggle('open', open);
}

function fecharSidebar() {
  document.getElementById('sidebar').classList.remove('open');
  document.getElementById('sidebar-overlay').classList.remove('open');
  document.getElementById('btn-hamburger').classList.remove('open');
}

// ── Recolher/mostrar sidebar (desktop) ───────────────────────
function toggleSidebarColapsada() {
  const app = document.getElementById('app');
  const colapsada = app.classList.toggle('sidebar-colapsada');
  document.getElementById('btn-sidebar-expand').classList.toggle('hidden', !colapsada);
  localStorage.setItem('pp_sidebar_colapsada', colapsada ? '1' : '0');
}
(function aplicarSidebarColapsadaSalva() {
  if (localStorage.getItem('pp_sidebar_colapsada') === '1') {
    document.addEventListener('DOMContentLoaded', () => {
      document.getElementById('app').classList.add('sidebar-colapsada');
      document.getElementById('btn-sidebar-expand').classList.remove('hidden');
    });
  }
})();

// ── Swipe lateral (borda esquerda) ───────────────────────
(function() {
  let startX = 0, startY = 0, ativo = false;
  const BORDA = 30; // px da borda esquerda para iniciar o gesto
  const THRESHOLD = 60; // px mínimos para acionar

  function paginaAtual() {
    return paginas.find(p => !document.getElementById(`pg-${p}`).classList.contains('hidden'));
  }

  document.addEventListener('touchstart', e => {
    startX = e.touches[0].clientX;
    startY = e.touches[0].clientY;
    ativo = startX <= BORDA;
  }, { passive: true });

  document.addEventListener('touchend', e => {
    if (!ativo) return;
    ativo = false;
    const dx = e.changedTouches[0].clientX - startX;
    const dy = Math.abs(e.changedTouches[0].clientY - startY);
    if (dx < THRESHOLD || dy > dx) return; // movimento muito pequeno ou vertical

    const pg = paginaAtual();
    if (pg === 'dashboard') {
      // No painel: abre sidebar com animação
      const sb = document.getElementById('sidebar');
      if (!sb.classList.contains('open')) toggleSidebar();
    } else {
      // Em qualquer outra página: volta para o painel
      mostrarPagina('dashboard');
    }
  }, { passive: true });
})();

// ── Pull to refresh (mobile) ─────────────────────────────
(function() {
  let startY = 0, pulling = false;
  const threshold = 72;

  const indicator = document.createElement('div');
  indicator.id = 'ptr-indicator';
  indicator.style.cssText = `
    position:fixed;top:0;left:50%;transform:translateX(-50%) translateY(-60px);
    background:var(--navy);color:#fff;border-radius:0 0 20px 20px;
    padding:8px 20px;font-size:13px;font-weight:600;z-index:9999;
    transition:transform 0.2s;pointer-events:none;`;
  indicator.textContent = '↓ Solte para atualizar';
  document.body.appendChild(indicator);

  function atualizarPaginaAtual() {
    const pg = [...document.querySelectorAll('.page-section')]
      .find(el => !el.classList.contains('hidden'))?.id?.replace('pg-','');
    if (pg === 'dashboard') carregarDashboard();
    else if (pg === 'estoque') carregarProdutos();
    else if (pg === 'compras') carregarCompras();
  }

  document.addEventListener('touchstart', e => {
    if (window.scrollY === 0) { startY = e.touches[0].clientY; pulling = true; }
  }, { passive: true });

  document.addEventListener('touchmove', e => {
    if (!pulling) return;
    const dy = e.touches[0].clientY - startY;
    if (dy > 10 && dy < threshold + 20) {
      const pct = Math.min(dy / threshold, 1);
      indicator.style.transform = `translateX(-50%) translateY(${-60 + pct * 70}px)`;
      indicator.textContent = dy >= threshold ? '↑ Atualizando...' : '↓ Solte para atualizar';
    }
  }, { passive: true });

  document.addEventListener('touchend', e => {
    if (!pulling) return;
    pulling = false;
    const dy = e.changedTouches[0].clientY - startY;
    indicator.style.transform = 'translateX(-50%) translateY(-60px)';
    if (dy >= threshold) atualizarPaginaAtual();
  });
})();

// Verifica login ao carregar
if (TOKEN) {
  fetch(`${API}/auth/perfil`, { headers: { 'Authorization': `Bearer ${TOKEN}` } })
    .then(r => r.ok ? r.json() : null)
    .then(d => {
      if (d) {
        document.getElementById('sidebar-nome').textContent = d.nome;
        const planoLabels = { trial: '⏳ Trial', essencial: '⚡ Essencial', pro: '⭐ Pro', premium: '💎 Premium' };
        const planoEl = document.getElementById('sidebar-plano');
        if (planoEl) planoEl.textContent = planoLabels[d.plano] || d.plano || '—';
        atualizarAvisoExpiracao(d.plano, d.plano_expira_em);
        PLANO_ATUAL = d.plano || 'trial';
        ROLE_ATUAL = d.role || 'user';
        if (d.role === 'admin') document.getElementById('nav-admin').classList.remove('hidden');
        entrar();
      }
    });
}

// ── Scanner de código de barras ──────────────────────────
let scannerCtx = 'estoque';
let html5Qr = null;
let _scanProduto = null;

function abrirScanner(ctx) {
  scannerCtx = ctx;
  document.getElementById('modal-scanner').classList.remove('hidden');
  document.getElementById('scan-resultado').classList.add('hidden');
  document.getElementById('scan-resultado').textContent = '';

  html5Qr = new Html5Qrcode('scanner-view');
  html5Qr.start(
    { facingMode: 'environment' },
    { fps: 10, qrbox: { width: 260, height: 120 } },
    async (codigo) => {
      await fecharScanner();
      await processarCodigoBarras(codigo, scannerCtx);
    },
    () => {}
  ).catch(err => {
    document.getElementById('scan-resultado').textContent = '❌ Câmera não disponível: ' + err;
    document.getElementById('scan-resultado').classList.remove('hidden');
  });
}

async function fecharScanner() {
  if (html5Qr) {
    try { await html5Qr.stop(); } catch(e) {}
    html5Qr = null;
  }
  document.getElementById('modal-scanner').classList.add('hidden');
}

function scanAcaoEntrada() {
  if (!_scanProduto) return;
  fecharModal('modal-acao-scan');
  movRapido(_scanProduto.id, 'entrada');
}

function scanAcaoSaida() {
  if (!_scanProduto) return;
  fecharModal('modal-acao-scan');
  const p = _scanProduto;
  document.getElementById('saida-rapida-info').innerHTML =
    `<strong>${p.nome}</strong><br>
     <span style="color:var(--slate-500);">Saldo atual: <strong>${fmtQtd(p.estoque_atual)} ${p.unidade}</strong></span>`;
  document.getElementById('saida-rapida-qtd').value = '';
  document.getElementById('saida-rapida-obs').value = '';
  document.getElementById('modal-saida-rapida').classList.remove('hidden');
  setTimeout(() => document.getElementById('saida-rapida-qtd').focus(), 100);
}

function scanAcaoEditar() {
  if (!_scanProduto) return;
  fecharModal('modal-acao-scan');
  editarProduto(_scanProduto.id);
}

async function confirmarSaidaRapida() {
  if (!_scanProduto) return;
  const qtd = parseFloat(document.getElementById('saida-rapida-qtd').value);
  if (!qtd || qtd <= 0) { alert('Informe a quantidade.'); return; }
  const obs = document.getElementById('saida-rapida-obs').value.trim();

  const btn = document.querySelector('#modal-saida-rapida .btn-danger');
  setBtnLoading(btn, true);
  try {
    const r = await fetch(`${API}/movimentacoes`, {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
      body: JSON.stringify({
        produto_id: _scanProduto.id,
        tipo: 'saida',
        quantidade: qtd,
        custo_unit: _scanProduto.custo_unitario,
        observacao: obs || null,
      })
    });
    const d = await r.json();
    if (!r.ok) { alert('Erro: ' + d.erro); return; }
    fecharModal('modal-saida-rapida');
    _scanProduto = null;
    carregarProdutos();
  } catch(e) {
    alert('Erro ao registrar saída.');
  } finally {
    setBtnLoading(btn, false);
  }
}

async function processarCodigoBarras(codigo, ctx) {
  document.getElementById('scan-status').textContent = `🔍 Buscando ${codigo}...`;
  document.getElementById('scanner-view').innerHTML = '';

  const r = await fetch(`${API}/produtos?busca=${encodeURIComponent(codigo)}`, {
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const lista = await r.json();
  const prod = lista.find(p => p.codigo_barras && p.codigo_barras.toString().trim() === codigo.toString().trim())
            || (lista.length === 1 ? lista[0] : null);

  await fecharScanner();

  if (prod) {
    _scanProduto = prod;
    document.getElementById('scan-acao-info').innerHTML =
      `<strong>${prod.nome}</strong><br>
       <span style="color:var(--slate-500);">Saldo: <strong>${fmtQtd(prod.estoque_atual)} ${prod.unidade}</strong> · Custo: R$ ${parseFloat(prod.custo_unitario).toFixed(2)}</span>`;
    document.getElementById('modal-acao-scan').classList.remove('hidden');
    return;
  }

  document.getElementById('scan-status').textContent = '🌐 Buscando na base pública...';
  document.getElementById('modal-scanner').classList.remove('hidden');
  document.getElementById('scanner-view').innerHTML = `<div style="padding:24px;text-align:center;color:#fff;font-size:14px;">🔍 Buscando produto na base global...</div>`;

  let nomeSugerido = '', catSugerida = '';
  try {
    const r1 = await fetch(`https://br.openfoodfacts.org/api/v0/product/${codigo}.json`);
    const d1 = await r1.json();
    if (d1.status === 1 && d1.product) {
      const p = d1.product;
      nomeSugerido = p.product_name_pt || p.product_name || '';
      catSugerida  = p.categories_tags?.[0]?.replace('en:','').replace(/-/g,' ') || '';
    }
  } catch(e) {}

  if (!nomeSugerido) {
    try {
      const r2 = await fetch(`https://world.openfoodfacts.org/api/v0/product/${codigo}.json`);
      const d2 = await r2.json();
      if (d2.status === 1 && d2.product) {
        const p = d2.product;
        nomeSugerido = p.product_name_pt || p.product_name || '';
        catSugerida  = p.categories_tags?.[0]?.replace('en:','').replace(/-/g,' ') || '';
      }
    } catch(e) {}
  }

  if (!nomeSugerido) {
    try {
      const r3 = await fetch(`https://api.upcitemdb.com/prod/trial/lookup?upc=${codigo}`);
      const d3 = await r3.json();
      if (d3.code === 'OK' && d3.items?.length) {
        nomeSugerido = d3.items[0].title || '';
        catSugerida  = d3.items[0].category || '';
      }
    } catch(e) {}
  }

  await fecharScanner();

  abrirModalProduto();
  document.getElementById('prod-cod').value  = codigo;
  document.getElementById('prod-nome').value = nomeSugerido;
  if (nomeSugerido) {
    document.getElementById('modal-titulo').textContent = '📦 Novo produto (dados sugeridos)';
    document.getElementById('prod-qtd-inicial')?.focus?.() || document.getElementById('prod-saldo').focus();
  } else {
    document.getElementById('prod-nome').focus();
  }
  const banner = document.createElement('div');
  banner.id = 'banner-off';
  banner.style.cssText = 'background:#eff6ff;border:1px solid #bfdbfe;border-radius:8px;padding:10px 14px;margin-bottom:14px;font-size:13px;';
  banner.innerHTML = nomeSugerido
    ? `🌐 Dados encontrados na base Open Food Facts.<br><span style="color:#64748b;">Confira e ajuste se necessário antes de salvar.</span>`
    : `⚠️ Código <strong>${codigo}</strong> não encontrado na base pública.<br><span style="color:#64748b;">Preencha o nome do produto manualmente.</span>`;
  const form = document.getElementById('form-produto');
  const antigo = document.getElementById('banner-off');
  if (antigo) antigo.remove();
  form.prepend(banner);
}

// ── Editar nome da padaria ────────────────────────────────────
function abrirEditarPadaria() {
  fecharSidebar();
  document.getElementById('input-nome-padaria').value = document.getElementById('sidebar-nome').textContent;
  document.getElementById('modal-editar-padaria').classList.remove('hidden');
  setTimeout(() => document.getElementById('input-nome-padaria').focus(), 100);
}

function fecharModalPadaria() {
  document.getElementById('modal-editar-padaria').classList.add('hidden');
}

async function salvarNomePadaria() {
  const nome = document.getElementById('input-nome-padaria').value.trim();
  if (!nome) return alert('Digite o nome da padaria.');
  const r = await api('/auth/padaria', { method: 'PUT', body: JSON.stringify({ nome }) });
  if (r && r.ok) {
    document.getElementById('sidebar-nome').textContent = r.nome;
    fecharModalPadaria();
  }
}

// ── Admin ──────────────────────────────────────────────────────────────────
function mostrarTabAdmin(aba) {
  ['padarias','codigos'].forEach(a => {
    document.getElementById(`admin-painel-${a}`).classList.toggle('hidden', a !== aba);
    document.getElementById(`tab-admin-${a}`).classList.toggle('active', a === aba);
  });
  if (aba === 'codigos') carregarCodigos();
}

// Admin "entra como" uma padaria específica sem precisar da senha dela —
// guarda o próprio token de admin de lado, troca pra o token da padaria
// escolhida, e recarrega. Um aviso fixo no topo permite voltar pro admin
// a qualquer momento (ver renderizarFaixaImpersonando).
async function adminEntrarComoPadaria(id, nome) {
  if (!(await confirmarBonito(`Entrar como "${nome}"? Você vai navegar no sistema dela até clicar em "Voltar ao admin".`))) return;
  const r = await api(`/admin/padarias/${id}/entrar`, { method: 'POST' });
  if (!r) return;
  // Só guarda o token de admin original se ainda não tiver um guardado —
  // evita perder o admin de verdade se a pessoa entrar numa padaria de
  // dentro de outra padaria por engano.
  if (!sessionStorage.getItem('admin_token_original')) {
    sessionStorage.setItem('admin_token_original', TOKEN);
  }
  localStorage.setItem('pptoken', r.token);
  sessionStorage.removeItem('pptoken');
  window.location.reload();
}

function voltarAoAdmin() {
  const original = sessionStorage.getItem('admin_token_original');
  if (!original) return;
  sessionStorage.removeItem('admin_token_original');
  localStorage.setItem('pptoken', original);
  window.location.reload();
}

// Faixa fixa avisando "você está vendo como outra padaria", com botão de voltar.
function renderizarFaixaImpersonando() {
  const original = sessionStorage.getItem('admin_token_original');
  const el = document.getElementById('faixa-impersonando');
  const app = document.getElementById('app');
  if (!el) return;
  el.classList.toggle('hidden', !original);
  app?.classList.toggle('com-faixa-impersonando', !!original);
}

async function abrirTelaAdmin() {
  document.getElementById('tela-admin').classList.remove('hidden');
  mostrarTabAdmin('padarias');
  const lista = document.getElementById('admin-lista');
  lista.innerHTML = '<p style="color:var(--slate-500)">Carregando...</p>';
  const rows = await api('/admin/padarias');
  if (!rows) { lista.innerHTML = '<p style="color:red">Erro ao carregar.</p>'; return; }
  const planoLabel = { essencial: 'Essencial', pro: 'Pro', premium: 'Premium' };

  // Banner de alerta: contas que vencem nos próximos 7 dias
  const vencendo = rows.filter(p => p.role !== 'admin' && !p.plano_bloqueado
    && p.dias_para_expirar !== null && p.dias_para_expirar >= 0 && p.dias_para_expirar <= 7);
  const expiradas = rows.filter(p => p.role !== 'admin'
    && p.dias_para_expirar !== null && p.dias_para_expirar < 0);
  const alerta = (vencendo.length || expiradas.length) ? `
    <div style="background:#fef3c7;border:1px solid #fbbf24;border-radius:12px;padding:14px 18px;margin-bottom:4px;">
      <div style="font-weight:700;font-size:14px;color:#92400e;margin-bottom:4px;">⚠️ Atenção às renovações</div>
      <div style="font-size:13px;color:#92400e;line-height:1.6;">
        ${vencendo.length ? `<strong>${vencendo.length}</strong> conta(s) vencem nos próximos 7 dias: ${vencendo.map(p => p.nome).join(', ')}.<br>` : ''}
        ${expiradas.length ? `<strong>${expiradas.length}</strong> conta(s) já expiradas e bloqueadas: ${expiradas.map(p => p.nome).join(', ')}.` : ''}
      </div>
    </div>` : '';

  lista.innerHTML = alerta + rows.map(p => {
    const expira = p.plano_expira_em ? new Date(p.plano_expira_em).toLocaleDateString('pt-BR') : '—';
    // Usa o cálculo do servidor; se ausente, cai para o cálculo local pela data
    const dias = p.dias_para_expirar ?? (p.plano_expira_em
      ? Math.ceil((new Date(p.plano_expira_em) - new Date()) / 86400000) : null);
    const expirado = dias !== null && dias < 0;
    const proximo = dias !== null && dias >= 0 && dias <= 7;
    const statusPlano = p.role === 'admin'
      ? `<span style="color:var(--slate-400);">— Admin —</span>`
      : p.plano_bloqueado || expirado
        ? `<span style="color:#dc2626;font-weight:600;">🔴 Expirado (${expira})</span>`
        : proximo
          ? `<span style="color:#d97706;font-weight:600;">⚠️ Vence em ${dias} dia${dias === 1 ? '' : 's'} (${expira})</span>`
          : p.plano_expira_em
            ? `<span style="color:#16a34a;">✅ Ativo até ${expira}</span>`
            : `<span style="color:var(--slate-400);">Sem validade</span>`;
    const borda = (p.role !== 'admin' && (expirado || p.plano_bloqueado)) ? 'border-left:4px solid #dc2626;'
                : proximo ? 'border-left:4px solid #f59e0b;' : '';
    return `
    <div style="background:var(--white);border-radius:12px;${borda}padding:16px 20px;box-shadow:0 1px 4px rgba(0,0,0,0.08);display:flex;flex-wrap:wrap;gap:12px;align-items:center;">
      <div style="flex:1;min-width:0;">
        <div style="font-weight:700;font-size:15px;">${p.nome}</div>
        <div style="font-size:13px;color:var(--slate-500);">${p.email}</div>
        <div style="font-size:12px;color:var(--slate-400);margin-top:2px;">
          ${p.total_produtos} produto(s) · Plano: <strong>${planoLabel[p.plano] || p.plano}</strong> · ${statusPlano}
        </div>
      </div>
      <div style="display:flex;gap:8px;flex-shrink:0;flex-wrap:wrap;">
        ${p.role !== 'admin' ? `
          <button onclick="adminEntrarComoPadaria(${p.id}, '${p.nome.replace(/'/g,"\\'")}')" class="btn-primary" style="font-size:13px;padding:7px 12px;">🔀 Entrar como</button>
          <button onclick="adminRenovarPlano(${p.id}, '${p.nome.replace(/'/g,"\\'")}')" class="btn-secondary" style="font-size:13px;padding:7px 12px;">🔄 Renovar</button>
          <button onclick="adminToggleAtivo(${p.id}, ${p.ativo ? 0 : 1})" class="btn-secondary" style="font-size:13px;padding:7px 12px;">${p.ativo ? '🔒 Desativar' : '✅ Reativar'}</button>
          <button onclick="adminApagarPadaria(${p.id}, '${p.nome.replace(/'/g,"\\'")}' )" class="btn-danger" style="font-size:13px;padding:7px 12px;">🗑️ Apagar</button>
        ` : '<span style="font-size:13px;color:var(--slate-400);">— Admin —</span>'}
      </div>
    </div>`;
  }).join('');
}

function fecharTelaAdmin() {
  document.getElementById('tela-admin').classList.add('hidden');
}

async function adminToggleAtivo(id, novoAtivo) {
  const acao = novoAtivo ? 'reativar' : 'desativar';
  if (!confirm(`Deseja ${acao} esta padaria?`)) return;
  const r = await api(`/admin/padarias/${id}/ativo`, { method: 'PATCH', body: { ativo: novoAtivo } });
  if (r) abrirTelaAdmin();
}

async function adminApagarPadaria(id, nome) {
  if (!confirm(`⚠️ Apagar "${nome}" permanentemente? Todos os dados serão perdidos!`)) return;
  if (!confirm(`Confirma a exclusão definitiva de "${nome}"?`)) return;
  const r = await api(`/admin/padarias/${id}`, { method: 'DELETE' });
  if (r) abrirTelaAdmin();
}

async function carregarCodigos() {
  const lista = document.getElementById('admin-codigos-lista');
  lista.innerHTML = '<p style="color:var(--slate-500)">Carregando...</p>';
  const rows = await api('/admin/codigos');
  if (!rows) { lista.innerHTML = '<p style="color:red">Erro ao carregar.</p>'; return; }
  if (!rows.length) { lista.innerHTML = '<p style="color:var(--slate-400);">Nenhum código gerado ainda.</p>'; return; }
  const planoLabel = { essencial: 'Essencial', pro: 'Pro', premium: 'Premium' };
  const planoCor = { essencial: 'var(--slate-600)', pro: 'var(--orange)', premium: '#7c3aed' };
  lista.innerHTML = rows.map(c => `
    <div style="background:var(--white);border-radius:12px;padding:14px 18px;box-shadow:0 1px 4px rgba(0,0,0,0.08);display:flex;flex-wrap:wrap;gap:12px;align-items:center;">
      <div style="flex:1;min-width:0;">
        <div style="display:flex;align-items:center;gap:10px;flex-wrap:wrap;">
          <span style="font-family:monospace;font-size:16px;font-weight:700;letter-spacing:0.1em;">${c.codigo}</span>
          <span style="font-size:12px;font-weight:600;color:${planoCor[c.plano] || 'inherit'};background:rgba(0,0,0,0.05);padding:2px 8px;border-radius:20px;">${planoLabel[c.plano] || c.plano}</span>
          <span style="font-size:12px;font-weight:600;color:var(--slate-600);background:rgba(0,0,0,0.05);padding:2px 8px;border-radius:20px;">${c.dias ? `${c.dias} dia${c.dias === 1 ? '' : 's'}` : `${c.meses || 1} ${(c.meses || 1) === 1 ? 'mês' : 'meses'}`}</span>
          ${c.usado
            ? `<span style="font-size:12px;color:#16a34a;">✅ Usado por ${c.padaria_nome || '—'} (${c.padaria_email || ''})</span>`
            : `<span style="font-size:12px;color:var(--slate-400);">Disponível</span>`}
        </div>
        <div style="font-size:11px;color:var(--slate-400);margin-top:3px;">
          Criado em ${new Date(c.criado_em).toLocaleDateString('pt-BR')}
          ${c.usado_em ? ' · Usado em ' + new Date(c.usado_em).toLocaleDateString('pt-BR') : ''}
        </div>
      </div>
      <div style="display:flex;gap:8px;flex-shrink:0;">
        <div style="display:flex;gap:8px;">
          ${!c.usado ? `<button onclick="copiarCodigo('${c.codigo}')" class="btn-secondary" style="font-size:13px;padding:7px 12px;">📋 Copiar</button>` : ''}
          <button onclick="apagarCodigo(${c.id})" class="btn-danger" style="font-size:13px;padding:7px 12px;">🗑️</button>
        </div>
      </div>
    </div>
  `).join('');
}

function presetDuracao(valor, unidade) {
  document.getElementById('admin-novo-valor').value = valor;
  document.getElementById('admin-novo-unidade').value = unidade;
}

async function gerarCodigo() {
  const plano = document.getElementById('admin-novo-plano').value;
  const unidade = document.getElementById('admin-novo-unidade').value;
  const valor = Number(document.getElementById('admin-novo-valor').value) || 1;
  const r = await api('/admin/codigos', { method: 'POST', body: { plano, unidade, valor } });
  if (r) {
    mostrarToast(`Código ${r.codigo} gerado (${valor} ${unidade})!`, 'success');
    carregarCodigos();
  }
}

function copiarCodigo(codigo) {
  navigator.clipboard.writeText(codigo).then(() => mostrarToast('Código copiado!', 'success'));
}

async function apagarCodigo(id) {
  if (!confirm('Apagar este código?')) return;
  const r = await api(`/admin/codigos/${id}`, { method: 'DELETE' });
  if (r) carregarCodigos();
}

async function adminRenovarPlano(id, nome) {
  const meses = prompt(`Renovar plano de "${nome}"\nQuantos meses?`, '1');
  if (!meses || isNaN(meses) || Number(meses) < 1) return;
  const planos = ['essencial','pro','premium'];
  const plano = prompt(`Qual plano? (essencial / pro / premium)\nDeixe em branco para manter o atual.`,'');
  const body = { meses: Number(meses) };
  if (plano && planos.includes(plano.toLowerCase())) body.plano = plano.toLowerCase();
  const r = await api(`/admin/padarias/${id}/renovar`, { method: 'POST', body });
  if (r?.ok) { mostrarToast(`Plano renovado até ${new Date(r.plano_expira_em).toLocaleDateString('pt-BR')}`, 'success'); abrirTelaAdmin(); }
}

function exportarExcel(tipo) {
  const mes = document.getElementById('rel-mes')?.value || new Date().toISOString().slice(0,7);
  const url = tipo === 'produtos'
    ? `${API}/exportar/produtos`
    : `${API}/exportar/movimentacoes?mes=${mes}`;
  const a = document.createElement('a');
  a.href = url;
  a.setAttribute('download', '');
  // Injeta token via fetch para download autenticado
  fetch(url, { headers: { Authorization: `Bearer ${TOKEN}` } })
    .then(r => r.blob())
    .then(blob => {
      const burl = URL.createObjectURL(blob);
      a.href = burl;
      a.click();
      setTimeout(() => URL.revokeObjectURL(burl), 5000);
    });
}

async function abrirHistoricoFornecedor(id, nome) {
  const modal = document.getElementById('modal-historico-forn');
  document.getElementById('historico-forn-titulo').textContent = `Histórico — ${nome}`;
  const corpo = document.getElementById('historico-forn-corpo');
  corpo.innerHTML = '<p style="color:var(--slate-400);padding:20px;text-align:center;">Carregando...</p>';
  modal.classList.remove('hidden');
  const rows = await api(`/fornecedores/${id}/historico`);
  if (!rows) { corpo.innerHTML = '<p style="color:red;padding:20px;">Erro ao carregar.</p>'; return; }
  if (!rows.length) { corpo.innerHTML = '<p style="color:var(--slate-400);padding:20px;text-align:center;">Nenhuma compra registrada.</p>'; return; }
  const total = rows.reduce((s, r) => s + parseFloat(r.total || 0), 0);
  corpo.innerHTML = `
    <div style="padding:12px 0;margin-bottom:8px;border-bottom:2px solid var(--slate-200);display:flex;justify-content:space-between;">
      <span style="font-weight:700;">${rows.length} pedido(s)</span>
      <span style="font-weight:700;color:var(--orange);">Total: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>
    </div>
    ${rows.map(r => `
      <div style="padding:10px 0;border-bottom:1px solid var(--slate-100);">
        <div style="display:flex;justify-content:space-between;align-items:center;gap:8px;">
          <span style="font-size:13px;color:var(--slate-500);">${new Date(r.data).toLocaleDateString('pt-BR')}</span>
          <span style="font-weight:700;color:var(--orange);">R$ ${parseFloat(r.total||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</span>
        </div>
        <div style="font-size:12px;color:var(--slate-400);margin-top:2px;">${r.produtos || '—'}</div>
      </div>`).join('')}`;
}

// ── Fichas Técnicas ────────────────────────────────────────────────────────
let fichasCache = [];
let produtosCache = [];

// ── Códigos de balança e NCM já usados (ajuda a não repetir/escolher o próximo livre) ──
let _codigosUsadosTipo = 'balanca';
async function abrirModalCodigosUsados(tipo) {
  _codigosUsadosTipo = tipo;
  if (!produtosCache.length) {
    const prods = await api('/produtos');
    produtosCache = prods || [];
  }
  document.getElementById('codigos-usados-titulo').textContent =
    tipo === 'ncm' ? '🔎 NCM já usados' : '🔎 Códigos de balança já usados';
  document.getElementById('codigos-usados-busca').value = '';
  renderCodigosUsados();
  document.getElementById('modal-codigos-usados').classList.remove('hidden');
}

function renderCodigosUsados() {
  const campo = _codigosUsadosTipo === 'ncm' ? 'ncm' : 'codigo_balanca';
  const rotuloColuna = _codigosUsadosTipo === 'ncm' ? 'NCM' : 'Cód. balança';
  const termo = document.getElementById('codigos-usados-busca').value.trim().toLowerCase();
  const el = document.getElementById('codigos-usados-lista');
  const usados = produtosCache
    .filter(p => p[campo] && (!termo || p.nome.toLowerCase().includes(termo)))
    .sort((a, b) => String(a[campo]).localeCompare(String(b[campo])));

  if (!usados.length) {
    el.innerHTML = `<div class="cmd-vazio">Nenhum produto com ${rotuloColuna.toLowerCase()} cadastrado ainda.</div>`;
    return;
  }

  let dicaLivre = '';
  if (_codigosUsadosTipo === 'balanca') {
    // Sugere o próximo código de balança livre (olhando só os numéricos já usados)
    const numericos = produtosCache.map(p => parseInt(p.codigo_balanca, 10)).filter(n => !isNaN(n));
    const proximoLivre = numericos.length ? Math.max(...numericos) + 1 : 1;
    dicaLivre = `
      <div style="background:var(--slate-50);padding:8px 12px;border-radius:8px;font-size:12.5px;color:var(--slate-600);margin-bottom:10px;">
        💡 Próximo código de balança livre (sugestão): <strong>${String(proximoLivre).padStart(6, '0')}</strong>
      </div>`;
  }

  el.innerHTML = `
    ${dicaLivre}
    <table style="width:100%;border-collapse:collapse;font-size:13px;table-layout:fixed;">
      <thead>
        <tr style="text-align:left;color:var(--slate-500);font-size:11.5px;text-transform:uppercase;">
          <th style="padding:6px 8px;width:auto;">Produto</th>
          <th style="padding:6px 8px;width:150px;">${rotuloColuna}</th>
        </tr>
      </thead>
      <tbody>
        ${usados.map(p => `
          <tr style="border-top:1px solid var(--slate-200);">
            <td style="padding:6px 8px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">${p.nome}</td>
            <td style="padding:6px 8px;font-variant-numeric:tabular-nums;white-space:nowrap;">${p[campo]}</td>
          </tr>
        `).join('')}
      </tbody>
    </table>`;
}
let fichaEditandoItens = [];

async function carregarFichas() {
  const _btnConf = document.getElementById('btn-config-prec');
  const _btnNova = document.getElementById('btn-nova-ficha');
  if (ROLE_ATUAL !== 'admin' && !['pro', 'premium'].includes(PLANO_ATUAL)) {
    if (_btnConf) _btnConf.style.display = 'none';
    if (_btnNova) _btnNova.style.display = 'none';
    const lista = document.getElementById('fichas-lista');
    const detalhe = document.getElementById('fichas-detalhe');
    if (detalhe) detalhe.classList.add('hidden');
    if (lista) lista.innerHTML = `
      <div class="fichas-lock">
        <div class="fichas-lock-icon">🔒</div>
        <h3>Fichas Técnicas — Plano Pro ou Premium</h3>
        <p>Calcule o CMV real de cada receita e forme preços com base nos seus custos.<br>
           Disponível nos planos <strong>Pro</strong> e <strong>Premium</strong>.</p>
        <p style="color:var(--slate-400);font-size:13px;">Seu plano atual: <strong>${{ trial: 'Trial', essencial: 'Essencial' }[PLANO_ATUAL] || PLANO_ATUAL}</strong></p>
        <button onclick="mostrarPagina('planos')" class="btn-primary" style="margin-top:8px;padding:10px 28px;border-radius:10px;border:none;cursor:pointer;font-size:15px;font-weight:600;">Ver planos →</button>
      </div>`;
    return;
  }
  if (_btnConf) _btnConf.style.display = '';
  if (_btnNova) _btnNova.style.display = '';
  const fichas = await api('/fichas');
  if (!fichas || !Array.isArray(fichas)) return;
  fichasCache = fichas;

  // KPIs
  const cmvMedio = fichas.length
    ? fichas.filter(f => f.preco_venda > 0)
        .reduce((acc, f) => {
          const cmv = f.preco_venda > 0 ? (f.custo_total / f.rendimento) / f.preco_venda * 100 : 0;
          return acc + cmv;
        }, 0) / Math.max(1, fichas.filter(f => f.preco_venda > 0).length)
    : 0;

  document.getElementById('fichas-kpis').innerHTML = `
    <div class="kpi-card"><div class="kpi-label">Receitas</div><div class="kpi-value">${fichas.length}</div></div>
    <div class="kpi-card"><div class="kpi-label">CMV Médio</div><div class="kpi-value" style="color:${cmvMedio < 35 ? '#16a34a' : cmvMedio < 50 ? '#f59e0b' : '#dc2626'}">${cmvMedio.toFixed(1)}%</div></div>
  `;

  // Grid de cards
  if (!fichas.length) {
    document.getElementById('fichas-lista').innerHTML = '<div class="empty-state"><p>Nenhuma receita cadastrada ainda.</p><button class="btn-primary" onclick="abrirModalFicha()">+ Criar primeira receita</button></div>';
    return;
  }

  document.getElementById('fichas-lista').innerHTML = fichas.map(f => {
    const custoPorUnidade = f.custo_total / (f.rendimento || 1);
    const cmv = f.preco_venda > 0 ? (custoPorUnidade / f.preco_venda * 100) : null;
    const margem = cmv ? 100 - cmv : null;
    const cmvClass = cmv === null ? '' : cmv < 35 ? 'cmv-ok' : cmv < 50 ? 'cmv-warn' : 'cmv-bad';
    const cmvLabel = cmv !== null ? `CMV ${cmv.toFixed(0)}%` : 'Sem preço';
    return `
      <div class="ficha-card" onclick="verFicha(${f.id})">
        <div class="ficha-card-header">
          <div>
            <div class="ficha-nome">${f.nome}</div>
            <div class="ficha-rendimento">Rende ${fmtQtd(f.rendimento)} ${f.unidade_rendimento}</div>
          </div>
          <span class="cmv-pill ${cmvClass}">${cmvLabel}</span>
        </div>
        <div class="ficha-metrics">
          <div><div class="fm-label">Custo total</div><div class="fm-value">R$ ${parseFloat(f.custo_total||0).toFixed(2)}</div></div>
          <div><div class="fm-label">Custo/unid.</div><div class="fm-value">R$ ${custoPorUnidade.toFixed(2)}</div></div>
          <div><div class="fm-label">Preço venda</div><div class="fm-value">${f.preco_venda ? 'R$ '+parseFloat(f.preco_venda).toFixed(2) : '—'}</div></div>
          <div><div class="fm-label">Margem</div><div class="fm-value" style="color:${margem && margem > 40 ? '#16a34a' : margem && margem > 20 ? '#f59e0b' : '#dc2626'}">${margem !== null ? margem.toFixed(0)+'%' : '—'}</div></div>
        </div>
        <div class="ficha-card-footer">
          <span style="font-size:11px;color:var(--slate-400);">${f.total_ingredientes} ingredientes</span>
          <div style="display:flex;gap:8px;">
            <button class="btn-ghost" style="padding:4px 10px;font-size:11px;" onclick="event.stopPropagation();editarFicha(${f.id})">✏️ Editar</button>
            <button class="btn-danger" style="padding:4px 10px;font-size:11px;" onclick="event.stopPropagation();excluirFicha(${f.id})">🗑️</button>
          </div>
        </div>
      </div>`;
  }).join('');
}

async function verFicha(id) {
  const ficha = await api(`/fichas/${id}`);
  if (!ficha) return;

  const custoTotal = ficha.itens.reduce((s, i) => s + (i.custo_item || 0), 0);
  const custoPorUnidade = custoTotal / (ficha.rendimento || 1);
  const cmv = ficha.preco_venda > 0 ? (custoPorUnidade / ficha.preco_venda * 100) : null;
  const margem = cmv ? 100 - cmv : null;

  const det = document.getElementById('fichas-detalhe');
  det.classList.remove('hidden');
  det.innerHTML = `
    <div class="ficha-detalhe-header">
      <div>
        <div class="ficha-detalhe-nome">🧾 ${ficha.nome}</div>
        <div style="font-size:12px;color:rgba(255,255,255,0.6);margin-top:2px;">Rende ${fmtQtd(ficha.rendimento)} ${ficha.unidade_rendimento}${ficha.descricao ? ' · '+ficha.descricao : ''}</div>
      </div>
    </div>
    <div class="ficha-detalhe-summary">
      <div class="fds-item"><div class="fds-label">Custo de produção</div><div class="fds-value">R$ ${custoTotal.toFixed(2)}</div></div>
      <div class="fds-item"><div class="fds-label">Custo por unidade</div><div class="fds-value">R$ ${custoPorUnidade.toFixed(3)}</div></div>
      <div class="fds-item"><div class="fds-label">CMV</div><div class="fds-value" style="color:${!cmv ? 'var(--slate-400)' : cmv < 35 ? '#16a34a' : cmv < 50 ? '#f59e0b' : '#dc2626'}">${cmv !== null ? cmv.toFixed(1)+'%' : '—'}</div></div>
      <div class="fds-item"><div class="fds-label">Margem</div><div class="fds-value" style="color:${!margem ? 'var(--slate-400)' : margem > 40 ? '#16a34a' : margem > 20 ? '#f59e0b' : '#dc2626'}">${margem !== null ? margem.toFixed(1)+'%' : '—'}</div></div>
      <div class="fds-item">
        <div class="fds-label">Preço Sugerido</div>
        <div class="fds-value" style="color:var(--orange)">
          ${(() => { const ps = calcularPrecoSugerido(custoTotal, ficha.rendimento); return ps ? 'R$ '+ps.toFixed(2) : '—'; })()}
        </div>
      </div>
    </div>
    <table class="ficha-ingredientes-table">
      <thead><tr><th>Ingrediente</th><th class="right">Quantidade</th><th class="right">Custo unit.</th><th class="right">Custo na receita</th></tr></thead>
      <tbody>
        ${ficha.itens.map(i => `<tr>
          <td style="font-weight:600">${i.produto_nome}</td>
          <td class="right">${fmtQtd(i.quantidade)} ${i.unidade}</td>
          <td class="right">R$ ${parseFloat(i.custo_unitario||0).toFixed(4)}</td>
          <td class="right" style="font-weight:700">R$ ${parseFloat(i.custo_item||0).toFixed(2)}</td>
        </tr>`).join('')}
      </tbody>
    </table>
    <div class="ficha-total-row">
      <span>Custo total (${fmtQtd(ficha.rendimento)} ${ficha.unidade_rendimento})</span>
      <span style="font-size:18px;font-weight:800;color:var(--orange)">R$ ${custoTotal.toFixed(2)}</span>
    </div>
  `;
  det.scrollIntoView({ behavior: 'smooth', block: 'start' });
}

async function abrirModalFicha(ficha = null) {
  if (!produtosCache.length) {
    const prods = await api('/produtos');
    produtosCache = prods || [];
  }
  fichaEditandoItens = [];

  document.getElementById('ficha-id').value = ficha ? ficha.id : '';
  document.getElementById('modal-ficha-titulo').textContent = ficha ? 'Editar Receita' : 'Nova Receita';
  document.getElementById('ficha-nome').value = ficha ? ficha.nome : '';
  document.getElementById('ficha-preco').value = ficha ? (ficha.preco_venda || '') : '';
  document.getElementById('ficha-rendimento').value = ficha ? parseFloat(ficha.rendimento) : 1;
  document.getElementById('ficha-unidade-rendimento').value = ficha ? ficha.unidade_rendimento : 'unidades';
  document.getElementById('ficha-descricao').value = ficha ? (ficha.descricao || '') : '';
  document.getElementById('fichas-ingredientes-lista').innerHTML = '';

  if (ficha && ficha.itens) {
    ficha.itens.forEach(i => adicionarLinhaIngrediente(i));
  } else {
    adicionarLinhaIngrediente();
  }

  document.getElementById('modal-ficha').classList.remove('hidden');
}

function fecharModalFicha() {
  document.getElementById('modal-ficha').classList.add('hidden');
}

// Unidades de entrada compatíveis com a unidade base do produto (ex: produto
// em kg pode ter a quantidade da receita digitada em kg ou g). Espelha a
// mesma lógica do backend (src/utils/unidades.js) para o dropdown já vir
// coerente antes de salvar.
function unidadesCompativeisFrontend(unidadeProduto) {
  const n = String(unidadeProduto || '').trim().toLowerCase();
  if (n === 'kg') return [unidadeProduto, 'g'];
  if (n === 'g')  return [unidadeProduto, 'kg'];
  if (n === 'l' || n === 'litro') return [unidadeProduto, 'ml'];
  if (n === 'ml') return [unidadeProduto, 'L'];
  return [unidadeProduto];
}

const UNIDADES_SEM_CUSTO = ['ml','L','g','kg','un'];

function adicionarLinhaIngrediente(item = null) {
  const idx = fichaEditandoItens.length;
  fichaEditandoItens.push(item || {});
  const produtoSelecionado = item && item.produto_id ? produtosCache.find(p => p.id == item.produto_id) : null;
  const ehSemCusto = item && !produtoSelecionado && item.nome_livre;
  const unidadeBase = produtoSelecionado ? produtoSelecionado.unidade : 'un';
  const unidadeAtual = item ? item.unidade : unidadeBase;
  const listaUnidades = ehSemCusto ? UNIDADES_SEM_CUSTO : unidadesCompativeisFrontend(unidadeBase);
  const unidadeOpts = (listaUnidades.includes(unidadeAtual) ? listaUnidades : [unidadeAtual, ...listaUnidades])
    .map(u => `<option value="${u}" ${u === unidadeAtual ? 'selected' : ''}>${u}</option>`).join('');
  const nomeExibido = produtoSelecionado ? produtoSelecionado.nome : (item && item.nome_livre ? item.nome_livre : '');
  const div = document.createElement('div');
  div.className = 'ficha-ingrediente-linha';
  div.innerHTML = `
    <div class="fi-busca-wrap" style="position:relative;flex:1;">
      <input type="text" class="form-control fi-produto-texto" placeholder="Buscar produto..." autocomplete="off"
        value="${nomeExibido}" oninput="filtrarIngredienteFicha(this)" onfocus="filtrarIngredienteFicha(this)"/>
      <input type="hidden" class="fi-produto-id" value="${produtoSelecionado ? produtoSelecionado.id : ''}"/>
      <input type="hidden" class="fi-nome-livre" value="${item && !produtoSelecionado && item.nome_livre ? item.nome_livre : ''}"/>
      <div class="autocomplete-lista fi-lista hidden"></div>
    </div>
    <input type="number" class="form-control fi-qtd" placeholder="Qtd" min="0" step="any" value="${item && item.quantidade != null ? parseFloat(item.quantidade) : ''}">
    <select class="form-control fi-unidade" style="width:70px;">${unidadeOpts}</select>
    <button class="btn-danger" style="padding:6px 10px;font-size:12px;" onclick="this.parentElement.remove()">✕</button>
  `;
  document.getElementById('fichas-ingredientes-lista').appendChild(div);
}

function filtrarIngredienteFicha(input) {
  const termo = input.value.trim().toLowerCase();
  const lista = input.parentElement.querySelector('.fi-lista');
  if (!termo) { lista.classList.add('hidden'); return; }
  const filtrados = produtosCache.filter(p => p.nome.toLowerCase().includes(termo)).slice(0, 8);
  const itensHtml = filtrados.map(p =>
    `<div class="autocomplete-item fi-item" data-produto-id="${p.id}" data-nome="${p.nome.replace(/"/g,'&quot;')}" data-unidade="${p.unidade||'un'}">${p.nome} <span style="color:var(--slate-400);font-size:12px;">${p.unidade||'un'}</span></div>`
  );
  itensHtml.push(`<div class="autocomplete-item fi-item" data-produto-id="__semcusto__" data-nome="${input.value.trim().replace(/"/g,'&quot;')}" data-unidade="un" style="color:var(--slate-500);">💧 Ingrediente sem custo/estoque (ex: água): "${input.value.trim()}"</div>`);
  lista.innerHTML = itensHtml.join('');
  lista.classList.remove('hidden');
}

function selecionarIngredienteFicha(item) {
  const wrap = item.closest('.fi-busca-wrap');
  const linha = item.closest('.ficha-ingrediente-linha');
  const produtoId = item.dataset.produtoId;
  const nome = item.dataset.nome;
  const unidadeBase = item.dataset.unidade || 'un';
  const textoInput = wrap.querySelector('.fi-produto-texto');
  const idInput = wrap.querySelector('.fi-produto-id');
  const nomeLivreInput = wrap.querySelector('.fi-nome-livre');
  const selUnidade = linha.querySelector('.fi-unidade');

  textoInput.value = nome;
  wrap.querySelector('.fi-lista').classList.add('hidden');

  if (produtoId === '__semcusto__') {
    idInput.value = '';
    nomeLivreInput.value = nome;
    selUnidade.innerHTML = UNIDADES_SEM_CUSTO.map(u => `<option value="${u}">${u}</option>`).join('');
  } else {
    idInput.value = produtoId;
    nomeLivreInput.value = '';
    const unidadeOpts = unidadesCompativeisFrontend(unidadeBase)
      .map(u => `<option value="${u}">${u}</option>`).join('');
    selUnidade.innerHTML = unidadeOpts;
  }
}

document.addEventListener('mousedown', e => {
  const item = e.target.closest('.fi-item');
  if (item) {
    e.preventDefault();
    selecionarIngredienteFicha(item);
    return;
  }
  if (!e.target.closest('.fi-busca-wrap')) {
    document.querySelectorAll('.fi-lista').forEach(l => l.classList.add('hidden'));
  }
});

/* ===================== COMANDAS ===================== */
let comandaAtualId = null;
let comandaAtualDados = null; // guarda o último objeto da comanda carregada, usado na impressão
function fmtMoeda(v) { return parseFloat(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' }); }

// Converte data/hora vinda do banco (UTC) pro fuso do navegador, no formato DD/MM/AAAA HH:MM.
// Substitui o corte de string ingênuo que mostrava a hora errada (não convertia de UTC).
function fmtDataHoraBR(valor) {
  if (!valor) return '';
  const d = new Date(valor);
  if (isNaN(d.getTime())) return '';
  return d.toLocaleString('pt-BR', { day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' }).replace(',', '');
}

async function carregarComandas() {
  // Modo Balcão pula o dashboard, então a lista de produtos nunca seria carregada — garante aqui.
  if (!produtosCache.length) {
    const prods = await api('/produtos');
    produtosCache = prods || [];
  }
  const data = await api('/comandas');
  if (!data) return;
  const elAbertas = document.getElementById('cmd-lista-abertas');

  // No tablet de Modo Lançamento, some da lista assim que o pedido é enviado pro caixa —
  // quem lança pedido não precisa (nem deve) continuar vendo/mexendo numa comanda que já
  // foi concluída e está só esperando ser cobrada.
  const abertas = MODO_LANCAMENTO ? data.abertas.filter(c => !c.pronta_pagamento) : data.abertas;

  elAbertas.innerHTML = abertas.length
    ? abertas.map(cardComandaHtml).join('')
    : `<div class="cmd-vazio">Nenhuma comanda aberta no momento.</div>`;

  await carregarCaixaFaixa();
}

/* ===================== CAIXA ===================== */
// Cada tablet/aparelho lembra qual é o "seu" caixa (podem existir vários abertos ao mesmo tempo).
let caixaAtualCache = null;
let CAIXA_LOCAL_ID = localStorage.getItem('pp_caixa_id') || null;

// ── Pausar/retomar caixa (intervalo do atendente) ──────────────────────
async function pausarCaixaUI() {
  if (!CAIXA_LOCAL_ID) return;
  if (!(await confirmarBonito('Pausar o caixa? Ninguém consegue vender até alguém retomar com o PIN.'))) return;
  const r = await api(`/caixa/${CAIXA_LOCAL_ID}/pausar`, { method: 'POST' });
  if (!r) return;
  await carregarCaixaFaixa();
}

async function retomarCaixaUI() {
  if (!CAIXA_LOCAL_ID) return;
  await comLoginAtendente(async () => {
    const r = await api(`/caixa/${CAIXA_LOCAL_ID}/retomar`, { method: 'POST' });
    if (!r) return r;
    mostrarToast(`Caixa retomado${r.retomado_por ? ' por ' + r.retomado_por : ''}!`, 'ok');
    await carregarCaixaFaixa();
    return r;
  });
}

async function carregarCaixaFaixa() {
  const el = document.getElementById('cmd-caixa-faixa');
  if (!el) return;

  // Tablet de lançamento não mexe com caixa — só lança pedido, cobrança é nos PCs.
  if (MODO_LANCAMENTO) {
    el.innerHTML = `<div class="cmd-caixa-card fechado"><span>📋 Modo Lançamento — só cadastro de pedidos. A cobrança é feita no caixa.</span></div>`;
    return;
  }

  if (CAIXA_LOCAL_ID) {
    const caixa = await api(`/caixa/${CAIXA_LOCAL_ID}`);
    if (caixa && caixa.status === 'aberto') {
      caixaAtualCache = caixa;
      if (caixa.pausado) {
        el.innerHTML = `
          <div class="cmd-caixa-card fechado">
            <span>⏸️ Caixa pausado${caixa.pausado_por ? ' por ' + caixa.pausado_por : ''}</span>
            <button class="btn-primary" style="padding:7px 14px;font-size:12.5px;" onclick="retomarCaixaUI()">▶️ Retomar caixa</button>
          </div>`;
        return;
      }
      const desde = fmtDataHoraBR(caixa.aberto_em);
      el.innerHTML = `
        <div class="cmd-caixa-card aberto">
          <span>🟢 ${caixa.nome} aberto ${caixa.atendente ? 'por ' + caixa.atendente : ''} desde ${desde}</span>
          <div style="display:flex;gap:8px;flex-wrap:wrap;">
            <button class="btn-ghost" style="padding:7px 12px;font-size:12.5px;" onclick="abrirModalCaixa('sangria')">💸 Sangria</button>
            <button class="btn-ghost" style="padding:7px 12px;font-size:12.5px;" onclick="abrirModalCaixa('suprimento')">💰 Suprimento</button>
            <button class="btn-ghost" style="padding:7px 12px;font-size:12.5px;" onclick="pausarCaixaUI()">⏸️ Pausar</button>
            <button class="btn-primary" style="padding:7px 12px;font-size:12.5px;" onclick="abrirModalCaixa('fechar')">Fechar caixa</button>
          </div>
        </div>`;
      return;
    }
    // Caixa local não existe mais ou já foi fechado noutro lugar — esquece e reavalia.
    localStorage.removeItem('pp_caixa_id');
    CAIXA_LOCAL_ID = null;
    caixaAtualCache = null;
  }

  // Esse tablet não tem caixa próprio ainda — confere se já tem algum caixa aberto (de outro aparelho)
  // que essa pessoa queira assumir aqui, ou se precisa abrir um novo.
  const abertos = await api('/caixa/abertos');
  if (abertos && abertos.length) {
    el.innerHTML = `
      <div class="cmd-caixa-card fechado">
        <span>🔒 Nenhum caixa aberto neste aparelho</span>
        <div style="display:flex;gap:8px;flex-wrap:wrap;">
          ${abertos.map(c => `<button class="btn-ghost" style="padding:8px 14px;" onclick="usarCaixaLocal(${c.id})">Usar ${c.nome}</button>`).join('')}
          <button class="btn-primary" style="padding:8px 16px;" onclick="abrirModalCaixa('abrir')">+ Abrir novo caixa</button>
        </div>
      </div>`;
    return;
  }

  el.innerHTML = `
    <div class="cmd-caixa-card fechado">
      <span>🔒 Caixa fechado — abra o caixa pra começar a vender</span>
      <button class="btn-primary" style="padding:8px 16px;" onclick="abrirModalCaixa('abrir')">Abrir caixa</button>
    </div>`;
}

function usarCaixaLocal(id) {
  localStorage.setItem('pp_caixa_id', id);
  CAIXA_LOCAL_ID = id;
  carregarCaixaFaixa();
}

async function abrirModalCaixa(modo) {
  const corpo = document.getElementById('cmd-caixa-corpo');
  const titulo = document.getElementById('cmd-caixa-titulo');

  if (modo === 'abrir') {
    titulo.textContent = '💰 Abrir caixa';
    const sugestao = await sugerirNomeCaixa();
    corpo.innerHTML = `
      <div class="form-group">
        <label class="form-label">Nome deste caixa</label>
        <input id="caixa-nome" type="text" class="form-control" value="${sugestao}" placeholder="Ex: Caixa 1"/>
      </div>
      <div class="form-group">
        <label class="form-label">Valor inicial (troco em caixa)</label>
        <input id="caixa-valor-abertura" type="number" class="form-control" min="0" step="0.01" placeholder="0,00"/>
      </div>
      <div class="form-group">
        <label class="form-label">Atendente</label>
        <select id="caixa-atendente" class="form-control" onchange="if(this.value==='__novo__') adicionarAtendenteInline(this)"></select>
      </div>
      <div class="form-group" id="caixa-pin-wrap">
        <label class="form-label">PIN do atendente (4 dígitos)</label>
        <input id="caixa-pin" type="password" inputmode="numeric" maxlength="4" class="form-control" placeholder="••••"/>
      </div>
      <button class="btn-primary full" style="margin-top:6px;" onclick="confirmarAbrirCaixa()">Abrir caixa</button>
    `;
    await carregarAtendentesSelect('caixa-atendente');
  } else if (modo === 'sangria' || modo === 'suprimento') {
    const label = modo === 'sangria' ? 'Sangria (retirar dinheiro do caixa)' : 'Suprimento (colocar dinheiro no caixa)';
    titulo.textContent = modo === 'sangria' ? '💸 Sangria' : '💰 Suprimento';
    corpo.innerHTML = `
      <div class="form-group">
        <label class="form-label">${label}</label>
        <input id="caixa-mov-valor" type="number" class="form-control" min="0.01" step="0.01" placeholder="0,00"/>
      </div>
      <div class="form-group">
        <label class="form-label">Motivo (opcional)</label>
        <input id="caixa-mov-obs" type="text" class="form-control" placeholder="Ex: pagamento fornecedor, troco..."/>
      </div>
      <button class="btn-primary full" style="margin-top:6px;" onclick="confirmarMovimentoCaixa('${modo}')">Confirmar</button>
    `;
  } else if (modo === 'fechar') {
    titulo.textContent = '💰 Fechar caixa';
    const caixa = caixaAtualCache;
    const r = caixa?.resumo;
    const linhasForma = (r?.porForma || []).map(f => `<div class="cmd-resumo-linha"><span>${f.forma_pagamento}</span><span>${fmtMoeda(f.total)}</span></div>`).join('');
    const naoDinheiro = (r?.porForma || []).filter(f => f.forma_pagamento !== 'Dinheiro');
    const linhasNaoDinheiro = naoDinheiro.map(f => `<div class="cmd-resumo-linha"><span>${f.forma_pagamento}</span><span>${fmtMoeda(f.total)}</span></div>`).join('');
    const totalNaoDinheiro = naoDinheiro.reduce((s, f) => s + parseFloat(f.total), 0);
    corpo.innerHTML = `
      <div class="cmd-resumo-caixa">
        <div class="cmd-resumo-linha"><span>Abertura</span><span>${fmtMoeda(caixa?.valor_abertura)}</span></div>
        <div class="cmd-resumo-secao">Vendas por forma de pagamento</div>
        ${linhasForma || '<div class="cmd-resumo-linha"><span>Nenhuma venda nesse caixa</span><span>—</span></div>'}
        <div class="cmd-resumo-linha subtotal"><span>Total geral de vendas</span><span>${fmtMoeda(r?.totalVendas)}</span></div>
        ${(r?.totalDescontos > 0 || r?.totalAcrescimos > 0) ? `
          <div class="cmd-resumo-secao">Ajustes concedidos nas comandas</div>
          ${r.totalDescontos > 0 ? `<div class="cmd-resumo-linha"><span>Descontos dados</span><span>-${fmtMoeda(r.totalDescontos)}</span></div>` : ''}
          ${r.totalAcrescimos > 0 ? `<div class="cmd-resumo-linha"><span>Acréscimos cobrados</span><span>+${fmtMoeda(r.totalAcrescimos)}</span></div>` : ''}
        ` : ''}
        <div class="cmd-resumo-linha"><span>Sangrias</span><span>-${fmtMoeda(r?.totalSangrias)}</span></div>
        <div class="cmd-resumo-linha"><span>Suprimentos</span><span>+${fmtMoeda(r?.totalSuprimentos)}</span></div>
        <div class="cmd-resumo-linha total"><span>Esperado em dinheiro na gaveta</span><span>${fmtMoeda(r?.esperadoEmDinheiro)}</span></div>
        ${naoDinheiro.length ? `
          <div class="cmd-resumo-secao">Recebido fora da gaveta (não conferir na conta física)</div>
          ${linhasNaoDinheiro}
          <div class="cmd-resumo-linha subtotal"><span>Total fora da gaveta</span><span>${fmtMoeda(totalNaoDinheiro)}</span></div>
        ` : ''}
      </div>
      <div class="form-group" style="margin-top:10px;">
        <label class="form-label">Valor contado em dinheiro</label>
        <input id="caixa-valor-fechamento" type="number" class="form-control" min="0" step="0.01" placeholder="0,00"/>
      </div>
      <div class="form-group">
        <label class="form-label">Observação (opcional)</label>
        <input id="caixa-fechamento-obs" type="text" class="form-control"/>
      </div>
      <button class="btn-primary full" style="margin-top:6px;background:#dc2626;" onclick="confirmarFecharCaixa()">Fechar caixa</button>
    `;
  }
  document.getElementById('modal-caixa').classList.remove('hidden');
}

// Sugere "Caixa 1", "Caixa 2"... olhando quantos já estão abertos agora
async function sugerirNomeCaixa() {
  const abertos = await api('/caixa/abertos');
  const n = (abertos ? abertos.length : 0) + 1;
  return `Caixa ${n}`;
}

async function confirmarAbrirCaixa() {
  const nome = document.getElementById('caixa-nome').value.trim() || 'Caixa 1';
  const valor_abertura = document.getElementById('caixa-valor-abertura').value;
  const atendente_id = document.getElementById('caixa-atendente').value;
  const pin = document.getElementById('caixa-pin').value.trim();
  if (atendente_id && atendente_id !== '__novo__' && !/^\d{4}$/.test(pin)) {
    mostrarToast('Digite o PIN de 4 dígitos do atendente.', 'warn');
    return;
  }
  const r = await api('/caixa/abrir', {
    method: 'POST',
    body: { nome, valor_abertura, atendente_id: atendente_id && atendente_id !== '__novo__' ? atendente_id : null, pin }
  });
  if (!r) return;
  localStorage.setItem('pp_caixa_id', r.id);
  CAIXA_LOCAL_ID = r.id;
  mostrarToast('Caixa aberto!', 'ok');
  document.getElementById('modal-caixa').classList.add('hidden');
  await carregarCaixaFaixa();
}

async function confirmarMovimentoCaixa(tipo) {
  const valor = document.getElementById('caixa-mov-valor').value;
  const observacao = document.getElementById('caixa-mov-obs').value;
  if (!valor || parseFloat(valor) <= 0) { mostrarToast('Informe um valor válido.', 'warn'); return; }
  const r = await api(`/caixa/${CAIXA_LOCAL_ID}/${tipo}`, { method: 'POST', body: { valor, observacao } });
  if (!r) return;
  mostrarToast(tipo === 'sangria' ? 'Sangria registrada.' : 'Suprimento registrado.', 'ok');
  document.getElementById('modal-caixa').classList.add('hidden');
  await carregarCaixaFaixa();
}

async function confirmarFecharCaixa() {
  const valor_fechamento = document.getElementById('caixa-valor-fechamento').value;
  const observacao = document.getElementById('caixa-fechamento-obs').value;
  if (!confirm('Fechar o caixa agora? Confira o valor contado antes de confirmar.')) return;
  const caixaSnapshot = caixaAtualCache; // guarda o resumo antes de fechar, pro comprovante impresso
  const r = await api(`/caixa/${CAIXA_LOCAL_ID}/fechar`, { method: 'POST', body: { valor_fechamento, observacao } });
  if (!r) return;
  localStorage.removeItem('pp_caixa_id');
  CAIXA_LOCAL_ID = null;
  const dif = r.diferenca;
  const msg = Math.abs(dif) < 0.01
    ? 'Caixa fechado — valores batem certinho! ✅'
    : `Caixa fechado. Diferença: ${dif > 0 ? '+' : ''}${fmtMoeda(dif)} (${dif > 0 ? 'sobrou' : 'faltou'})`;
  mostrarToast(msg, Math.abs(dif) < 0.01 ? 'ok' : 'warn');
  document.getElementById('modal-caixa').classList.add('hidden');
  await carregarCaixaFaixa();
  if (confirm('Imprimir o comprovante de fechamento de caixa?')) {
    imprimirFechamentoCaixa(caixaSnapshot, parseFloat(valor_fechamento) || 0, dif);
  }
}

// Comprovante impresso do fechamento de caixa — formato "relatório completo de
// sessão" (mesmo padrão que a gerente pediu, igual ao relatório do Saurus).
function imprimirFechamentoCaixa(caixa, informado, diferenca) {
  const r = caixa?.resumo;
  const nomePadaria = document.getElementById('sidebar-nome')?.textContent || 'PanificaPro';
  const agora = new Date().toLocaleString('pt-BR');
  const abertura = fmtDataHoraBR ? fmtDataHoraBR(caixa?.aberto_em) : new Date(caixa?.aberto_em).toLocaleString('pt-BR');

  const porForma = r?.porForma || [];
  // Dinheiro é o único que se confere fisicamente (conta o dinheiro na gaveta) —
  // as outras formas (cartão, pix, faturado...) não têm contagem física, então
  // "Fechado" é igual ao valor do sistema e a diferença é sempre 0.
  const linhasFormaPag = porForma.map(f => `
    <div class="linha"><span class="nome">${f.forma_pagamento} (${f.qtd})</span><span class="valor">${fmtMoeda(f.total)}</span></div>
  `).join('');

  const linhasFechamento = porForma.map(f => {
    const ehDinheiro = f.forma_pagamento === 'Dinheiro';
    const emCaixa = ehDinheiro ? parseFloat(caixa?.valor_abertura || 0) + parseFloat(f.total) + (r?.totalSuprimentos || 0) - (r?.totalSangrias || 0) : parseFloat(f.total);
    const fechado = ehDinheiro ? informado : emCaixa;
    const dif = fechado - emCaixa;
    return `<tr><td>${f.forma_pagamento}</td><td>${fmtMoeda(emCaixa)}</td><td>${fmtMoeda(fechado)}</td><td>${fmtMoeda(dif)}</td></tr>`;
  }).join('');

  const difLabel = Math.abs(diferenca) < 0.01 ? '0,00' : fmtMoeda(diferenca);

  abrirJanelaImpressaoTermica(`
    <h1>${nomePadaria}</h1>
    <div class="sub">Relatório Completo de Sessão</div>
    <div class="sub">Sessão ${caixa?.id} · Terminal: ${caixa?.nome || '-'} · Operador: ${caixa?.atendente || '-'}</div>
    <div class="sub">Data Inicial: ${abertura}</div>
    <div class="sub">Data Final: ${agora}</div>
    <hr/>
    <div class="rodape" style="text-align:left;font-weight:bold;">Forma Pag.</div>
    ${linhasFormaPag || '<div class="linha"><span class="nome">Nenhuma venda nesse caixa</span><span class="valor">—</span></div>'}
    <div class="linha total"><span>TOTAL DA SESSÃO (${r?.qtdVendas || 0})</span><span>${fmtMoeda(r?.totalVendas)}</span></div>
    <hr/>
    <div class="rodape" style="text-align:left;font-weight:bold;">Resumo Movimentação</div>
    <div class="linha"><span class="nome">Abertura</span><span class="valor">${fmtMoeda(caixa?.valor_abertura)}</span></div>
    <div class="linha"><span class="nome">Suprimento</span><span class="valor">${fmtMoeda(r?.totalSuprimentos)}</span></div>
    <div class="linha"><span class="nome">Sangria</span><span class="valor">${fmtMoeda(r?.totalSangrias)}</span></div>
    <hr/>
    <div class="rodape" style="text-align:left;font-weight:bold;">Fechamento Caixa</div>
    <table style="width:100%;font-size:11px;border-collapse:collapse;margin-top:4px;">
      <thead><tr><th style="text-align:left;">Forma</th><th style="text-align:right;">Em Caixa</th><th style="text-align:right;">Fechado</th><th style="text-align:right;">Difer.</th></tr></thead>
      <tbody>${linhasFechamento}</tbody>
    </table>
    <hr/>
    <div class="linha"><span class="nome">Total Vendido</span><span class="valor">${fmtMoeda(r?.totalVendas)}</span></div>
    <div class="linha"><span class="nome">Abertura</span><span class="valor">${fmtMoeda(caixa?.valor_abertura)}</span></div>
    <div class="linha"><span class="nome">Suprimento</span><span class="valor">${fmtMoeda(r?.totalSuprimentos)}</span></div>
    <div class="linha"><span class="nome">Sangria</span><span class="valor">${fmtMoeda(r?.totalSangrias)}</span></div>
    <hr/>
    <div class="linha"><span class="nome">Valor em Caixa</span><span class="valor">${fmtMoeda(r?.esperadoEmDinheiro)}</span></div>
    <div class="linha"><span class="nome">Valor Fechamento</span><span class="valor">${fmtMoeda(informado)}</span></div>
    <div class="total"><span>Diferença</span><span>${difLabel}</span></div>
    <hr/>
    <div class="rodape" style="text-align:left;font-weight:bold;">Resumo de Vendas</div>
    <div class="linha"><span class="nome">SubTotal</span><span class="valor">${fmtMoeda(r?.totalVendas)}</span></div>
    <div class="linha"><span class="nome">Desconto</span><span class="valor">${fmtMoeda(r?.totalDescontos)}</span></div>
    <div class="linha"><span class="nome">Acréscimo</span><span class="valor">${fmtMoeda(r?.totalAcrescimos)}</span></div>
    <div class="linha"><span class="nome">Total</span><span class="valor">${fmtMoeda(r?.totalVendas)}</span></div>
    <div class="linha"><span class="nome">Qtd. Vendas</span><span class="valor">${r?.qtdVendas || 0}</span></div>
    <div class="linha"><span class="nome">Total Itens</span><span class="valor">${fmtQtd(r?.totalItens || 0)}</span></div>
    <hr/>
    <div class="rodape">${nomePadaria} · PanificaPro</div>
    <div class="rodape">Fim do Relatório · ${agora}</div>
  `);
}

/* ===================== EQUIPE (tela própria de gerenciar atendentes) ===================== */
const PAPEL_LABEL = { atendente: 'Atendente', caixa: 'Caixa', gerente: 'Gerente' };
const PAPEL_COR = { atendente: '#64748b', caixa: '#2563eb', gerente: '#f97316' };

async function carregarEquipe() {
  const lista = await api('/atendentes');
  const el = document.getElementById('equipe-lista');
  if (!lista || !lista.length) {
    el.innerHTML = `<div class="cmd-vazio">Nenhum atendente cadastrado ainda.</div>`;
    return;
  }
  el.innerHTML = lista.map(a => `
    <div class="cmd-item-linha">
      <div class="cmd-item-nome">
        <strong>${a.nome}</strong>
        <span class="cmd-item-numero" style="color:${PAPEL_COR[a.role] || '#64748b'};font-weight:700;">${PAPEL_LABEL[a.role] || a.role}</span>
      </div>
      <div class="cmd-item-direita" style="gap:6px;">
        <select class="form-control" style="width:auto;font-size:12px;padding:4px 8px;" onchange="trocarPapelAtendente(${a.id}, this.value)">
          <option value="atendente" ${a.role === 'atendente' ? 'selected' : ''}>Atendente</option>
          <option value="caixa" ${a.role === 'caixa' ? 'selected' : ''}>Caixa</option>
          <option value="gerente" ${a.role === 'gerente' ? 'selected' : ''}>Gerente</option>
        </select>
        <button class="btn-icon" title="Desativar" onclick="desativarAtendenteUI(${a.id}, '${a.nome.replace(/'/g,"\\'")}')">✕</button>
      </div>
    </div>
  `).join('');
}

function abrirModalNovoAtendente() {
  document.getElementById('equipe-nome').value = '';
  document.getElementById('equipe-pin').value = '';
  document.getElementById('equipe-papel').value = 'atendente';
  document.getElementById('modal-novo-atendente').classList.remove('hidden');
}

async function salvarNovoAtendente() {
  const nome = document.getElementById('equipe-nome').value.trim();
  const pin = document.getElementById('equipe-pin').value.trim();
  const role = document.getElementById('equipe-papel').value;
  if (!nome) { mostrarToast('Informe o nome.', 'warn'); return; }
  if (!/^\d{4}$/.test(pin)) { mostrarToast('PIN precisa ter exatamente 4 números.', 'warn'); return; }
  const r = await api('/atendentes', { method: 'POST', body: { nome, pin, role } });
  if (!r) return;
  mostrarToast(`${nome} cadastrado(a) como ${PAPEL_LABEL[role]}!`, 'ok');
  fecharModal('modal-novo-atendente');
  await carregarEquipe();
}

async function trocarPapelAtendente(id, role) {
  const r = await api(`/atendentes/${id}/papel`, { method: 'POST', body: { role } });
  if (!r) return;
  mostrarToast('Papel atualizado!', 'ok');
}

async function desativarAtendenteUI(id, nome) {
  if (!confirm(`Desativar ${nome}? Ela(e) não vai mais conseguir fazer login.`)) return;
  const r = await api(`/atendentes/${id}`, { method: 'DELETE' });
  if (!r) return;
  mostrarToast('Atendente desativado.', 'ok');
  await carregarEquipe();
}

/* ===================== ATENDENTES (select rápido, usado ao abrir caixa) ===================== */
let atendentesCache = [];

async function carregarAtendentesSelect(selectId) {
  const r = await api('/atendentes');
  atendentesCache = r || [];
  const sel = document.getElementById(selectId);
  if (!sel) return;
  sel.innerHTML = '<option value="">— Selecione —</option>' +
    atendentesCache.map(a => `<option value="${a.id}">${a.nome}</option>`).join('') +
    '<option value="__novo__">+ Novo atendente...</option>';
}

async function adicionarAtendenteInline(selectEl) {
  const nome = prompt('Nome do atendente:');
  if (!nome || !nome.trim()) { selectEl.value = ''; return; }
  const pin = prompt(`Crie um PIN de 4 números pra ${nome.trim()} (usado pra fazer login no tablet):`);
  if (!pin || !/^\d{4}$/.test(pin.trim())) {
    mostrarToast('PIN precisa ter exatamente 4 números. Atendente não criado.', 'warn');
    selectEl.value = '';
    return;
  }
  const papel = (prompt('Qual o papel desse atendente?\n\nDigite: atendente, caixa ou gerente', 'atendente') || 'atendente').trim().toLowerCase();
  const role = ['atendente','caixa','gerente'].includes(papel) ? papel : 'atendente';
  const r = await api('/atendentes', { method: 'POST', body: { nome: nome.trim(), pin: pin.trim(), role } });
  if (!r) { selectEl.value = ''; return; }
  await carregarAtendentesSelect(selectEl.id);
  selectEl.value = r.id;
}

// ── Login de atendente (identifica quem tá usando o tablet, trava ação por papel) ──
let _loginAtendenteResolve = null;

function pedirLoginAtendente() {
  return new Promise((resolve) => {
    _loginAtendenteResolve = resolve;
    const input = document.getElementById('login-atendente-pin');
    if (input) input.value = '';
    document.getElementById('login-atendente-erro')?.classList.add('hidden');
    document.getElementById('modal-login-atendente').classList.remove('hidden');
    setTimeout(() => input?.focus(), 100);
  });
}

function cancelarLoginAtendente() {
  document.getElementById('modal-login-atendente').classList.add('hidden');
  if (_loginAtendenteResolve) { const r = _loginAtendenteResolve; _loginAtendenteResolve = null; r(false); }
}

async function confirmarLoginAtendente() {
  const pin = document.getElementById('login-atendente-pin').value.trim();
  if (!/^\d{4}$/.test(pin)) { mostrarToast('Digite os 4 números do PIN.', 'warn'); return; }
  const r = await fetch(`${API}/atendentes/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${TOKEN}` },
    body: JSON.stringify({ pin })
  });
  const data = await r.json().catch(() => null);
  if (!r.ok) {
    document.getElementById('login-atendente-erro').textContent = data?.erro || 'PIN incorreto.';
    document.getElementById('login-atendente-erro').classList.remove('hidden');
    document.getElementById('login-atendente-pin').value = '';
    document.getElementById('login-atendente-pin').focus();
    return;
  }
  sessionStorage.setItem('func_token', data.token);
  sessionStorage.setItem('func_nome', data.nome);
  sessionStorage.setItem('func_role', data.role);
  document.getElementById('modal-login-atendente').classList.add('hidden');
  if (_loginAtendenteResolve) { const res = _loginAtendenteResolve; _loginAtendenteResolve = null; res(true); }
}

// Chama fn() (que faz uma chamada api()); se a API disser que precisa de login de
// atendente com papel específico, pede o PIN na hora e tenta de novo automaticamente.
// limparDepois=true (padrão): esquece o PIN logo após usar — cada ação de gerente
// exige digitar de novo. limparDepois=false: mantém o acesso liberado (usado só
// na entrada de telas como o Histórico, onde o PIN é pedido 1x e vale pra tudo
// que a pessoa fizer ali dentro — excluir/reimprimir não pedem PIN de novo).
async function comLoginAtendente(fn, limparDepois = true) {
  let r = await fn();
  if (r && r.precisa_login_funcionario) {
    const ok = await pedirLoginAtendente();
    if (!ok) return null;
    r = await fn();
  }
  if (limparDepois) {
    sessionStorage.removeItem('func_token');
    sessionStorage.removeItem('func_nome');
    sessionStorage.removeItem('func_role');
  }
  return r;
}

// Esquece o PIN de gerente ao sair de uma tela que ficou liberada (ex: Histórico).
function esquecerLoginAtendente() {
  sessionStorage.removeItem('func_token');
  sessionStorage.removeItem('func_nome');
  sessionStorage.removeItem('func_role');
}

function cardComandaHtml(c) {
  const statusLabel = c.status === 'aberta' && c.pronta_pagamento
    ? '💰 Pronta pra cobrar'
    : { aberta: '🟢 Aberta', fechada: '✅ Fechada', cancelada: '🚫 Cancelada' }[c.status] || c.status;
  const dataRef = fmtDataHoraBR(c.status === 'aberta' ? c.aberta_em : (c.fechada_em || c.aberta_em));
  const podeExcluir = c.status !== 'aberta';
  return `
    <div class="cmd-card" onclick="abrirModalComanda(${c.id})">
      <div class="cmd-card-topo">
        <strong>${c.identificador}</strong>
        <span class="cmd-card-topo-direita">
          <span class="cmd-card-status">${statusLabel}</span>
          ${podeExcluir ? `<button class="cmd-card-excluir" onclick="event.stopPropagation();excluirComandaUI(${c.id})" title="Excluir comanda">🗑️</button>` : ''}
        </span>
      </div>
      <div class="cmd-card-info">
        <span>${c.qtd_itens} ${c.qtd_itens === 1 ? 'item' : 'itens'}</span>
        <span>${fmtMoeda(c.total)}</span>
      </div>
      <div class="cmd-card-data">${dataRef}</div>
    </div>
  `;
}

async function excluirComandaUI(id) {
  if (!(await confirmarBonito('Excluir essa comanda definitivamente? Essa ação não pode ser desfeita.'))) return;
  // Ação sensível — exige login de atendente com papel "gerente", e limpa
  // depois (fora do Histórico, cada exclusão pede o PIN de novo).
  const r = await comLoginAtendente(() => api(`/comandas/${id}`, { method: 'DELETE' }));
  if (!r || r.precisa_login_funcionario) return;
  mostrarToast('Comanda excluída.', 'ok');
  await carregarComandas();
}

// Excluir de dentro do Histórico usa o PIN já digitado na entrada da tela —
// não pede de novo pra cada item.
async function excluirComandaHistoricoUI(id) {
  if (!(await confirmarBonito('Excluir essa comanda definitivamente? Essa ação não pode ser desfeita.'))) return;
  const r = await api(`/comandas/${id}`, { method: 'DELETE' });
  if (!r || r.precisa_login_funcionario) { esquecerLoginAtendente(); return; }
  mostrarToast('Comanda excluída.', 'ok');
  carregarHistoricoComandas();
}

/* ===================== HISTÓRICO DE COMANDAS (restrito a gerente) ===================== */
async function abrirHistoricoComandas() {
  // limparDepois=false: pede o PIN só aqui na entrada — excluir/reimprimir
  // dentro do histórico não pedem de novo, até fechar a tela.
  await comLoginAtendente(async () => {
    const r = await api('/comandas/historico');
    if (!r || r.precisa_login_funcionario) return r;
    document.getElementById('modal-historico-comandas').classList.remove('hidden');
    renderHistoricoComandas(r.recentes || []);
    return r;
  }, false);
}

function fecharHistoricoComandas() {
  fecharModal('modal-historico-comandas');
  esquecerLoginAtendente();
}

async function carregarHistoricoComandas() {
  const r = await api('/comandas/historico');
  if (!r) return;
  renderHistoricoComandas(r.recentes || []);
}

function renderHistoricoComandas(recentes) {
  const el = document.getElementById('historico-comandas-lista');
  const statusLabel = { fechada: 'Fechada', cancelada: 'Cancelada' };
  if (!recentes.length) {
    el.innerHTML = `<div class="cmd-vazio">Nenhuma comanda finalizada ainda.</div>`;
    return;
  }
  el.innerHTML = recentes.map(c => `
    <div class="historico-item ${c.status}">
      <div class="historico-item-info">
        <div class="historico-item-topo">
          <span class="historico-item-id">${c.identificador}</span>
          <span class="historico-item-badge ${c.status}">${statusLabel[c.status] || c.status}</span>
        </div>
        <span class="historico-item-meta">${fmtDataHoraBR(c.fechada_em || c.aberta_em)} · <span class="historico-item-valor">${fmtMoeda(c.total)}</span></span>
      </div>
      <div class="historico-item-acoes">
        <button class="btn-icon" title="Reimprimir notinha (recibo comum)" onclick="reimprimirComandaUI(${c.id})">🖨️</button>
        <button class="btn-icon" title="Reimprimir nota fiscal (NFC-e), se essa comanda teve uma emitida" onclick="imprimirDanfeNFCe(${c.id})">🧾</button>
        <button class="btn-icon" title="Excluir" onclick="excluirComandaHistoricoUI(${c.id})">🗑️</button>
      </div>
    </div>
  `).join('');
}

async function reimprimirComandaUI(id) {
  const c = await api(`/comandas/${id}`);
  if (!c) return;
  const formaResumo = c.forma_pagamento || '';
  imprimirReciboComanda(c, formaResumo);
}

async function abrirModalNovaComanda() {
  document.getElementById('cmd-novo-identificador').value = '';
  await carregarAtendentesSelect('cmd-novo-atendente');
  // Pré-seleciona o último atendente usado, se ele ainda estiver na lista.
  const opcaoAtual = [...document.getElementById('cmd-novo-atendente').options].find(o => o.textContent === _atendentePendente);
  if (opcaoAtual) document.getElementById('cmd-novo-atendente').value = opcaoAtual.value;
  document.getElementById('modal-nova-comanda').classList.remove('hidden');
  setTimeout(() => document.getElementById('cmd-novo-identificador').focus(), 100);
}

function fecharModalNovaComanda() {
  document.getElementById('modal-nova-comanda').classList.add('hidden');
}

async function criarComanda() {
  const identificador = document.getElementById('cmd-novo-identificador').value.trim() || 'Comanda';
  const atendenteId = document.getElementById('cmd-novo-atendente').value;
  const atendenteNome = atendentesCache.find(a => String(a.id) === atendenteId)?.nome || null;
  const r = await api('/comandas', { method: 'POST', body: { identificador, atendente: atendenteNome } });
  if (!r) return;
  if (atendenteNome) _atendentePendente = atendenteNome;
  fecharModalNovaComanda();
  await carregarComandas();
  abrirModalComanda(r.id);
}

// ── Atendente do balcão (quem atendeu, pode ser diferente de quem tá no caixa) ──
// Fica gravado desde a abertura da comanda, pra rastrear quem lançou os itens.
let _atendentePendente = ''; // usado quando a comanda ainda nem foi criada (venda de balcão lazy)

async function definirAtendenteComandaUI() {
  await carregarAtendentesSelect('sel-atendente-comanda');
  const atual = comandaAtualDados?.atendente || _atendentePendente || '';
  const opcaoAtual = [...document.getElementById('sel-atendente-comanda').options].find(o => o.textContent === atual);
  document.getElementById('sel-atendente-comanda').value = opcaoAtual ? opcaoAtual.value : '';
  document.getElementById('modal-selecionar-atendente').classList.remove('hidden');
}

async function confirmarAtendenteComanda() {
  const atendenteId = document.getElementById('sel-atendente-comanda').value;
  const novoNome = atendentesCache.find(a => String(a.id) === atendenteId)?.nome || null;
  if (comandaAtualId) {
    const r = await api(`/comandas/${comandaAtualId}/atendente`, { method: 'PATCH', body: { atendente: novoNome } });
    if (!r) return;
    if (comandaAtualDados) comandaAtualDados.atendente = novoNome;
  } else {
    _atendentePendente = novoNome || '';
  }
  fecharModal('modal-selecionar-atendente');
  atualizarLabelAtendenteComanda();
}

function atualizarLabelAtendenteComanda() {
  const el = document.getElementById('cmd-detalhe-atendente');
  if (!el) return;
  const nome = comandaAtualDados?.atendente || _atendentePendente;
  el.textContent = nome ? `Atendente: ${nome}` : 'Toque pra dizer quem tá atendendo';
}

// ── Tela de venda de balcão contínua (estilo Saurus) ──────
// Ao entrar em Comandas com caixa aberto, já abre direto na venda em andamento
// (ou numa venda em branco pronta pra escanear), sem passar pela lista de cards.
// A comanda só é criada de verdade no banco quando o 1º item é lançado — assim
// não fica sobrando comanda vazia se o caixa só entrar na tela e sair sem vender nada.
async function abrirTelaVendaBalcao() {
  if (!CAIXA_LOCAL_ID || MODO_LANCAMENTO) return; // sem caixa aberto ou tablet de lançamento: mostra a lista normal
  if (_balcaoComandaAtiva) { abrirModalComanda(_balcaoComandaAtiva); return; }

  // Recarregou a página (F5) no meio de uma venda? A comanda continua aberta no banco
  // mesmo com a variável local perdida — recupera ela em vez de começar do zero.
  const data = await api('/comandas');
  const pendente = data?.abertas?.find(c => c.identificador?.startsWith('Balcão '));
  if (pendente) { _balcaoComandaAtiva = pendente.id; abrirModalComanda(pendente.id); return; }

  abrirVendaBalcaoVazia();
}

function abrirVendaBalcaoVazia() {
  comandaAtualId = null;
  comandaAtualDados = { itens: [], total: 0, desconto: 0, acrescimo: 0, status: 'aberta' };
  comandaPagamentosPendentes = [];
  document.getElementById('cmd-detalhe-titulo').textContent = '🧾 Nova venda';
  document.getElementById('cmd-item-busca').value = '';
  document.getElementById('cmd-item-produto-id').value = '';
  document.getElementById('cmd-item-qtd').value = '1';
  document.getElementById('cmd-item-preco').value = '';
  document.getElementById('cmd-desconto').value = '';
  document.getElementById('cmd-acrescimo').value = '';
  renderItensComanda(comandaAtualDados);
  renderRapidoGrid();

  document.getElementById('cmd-detalhe-acoes').style.display = 'block';
  document.querySelector('.cmd-add-item').style.display = 'flex';
  document.getElementById('cmd-ajuste-row').style.display = 'flex';
  const btnCancelar = document.querySelector('#modal-comanda .btn-ghost');
  if (btnCancelar) btnCancelar.style.display = 'block';

  document.getElementById('modal-comanda').classList.remove('hidden');
  atualizarTopbarPdv();
  setTimeout(() => document.getElementById('cmd-item-busca')?.focus(), 100);
}

// Garante que existe uma comanda de balcão de verdade no banco — cria na hora se ainda
// não existir (1ª venda da tela em branco). Usado antes de qualquer lançamento de item.
async function garantirComandaBalcaoAtiva() {
  if (comandaAtualId) return comandaAtualId;
  const identificador = 'Balcão ' + new Date().toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
  const nova = await api('/comandas', { method: 'POST', body: { identificador, atendente: _atendentePendente || null } });
  if (!nova) return null;
  comandaAtualId = nova.id;
  _balcaoComandaAtiva = nova.id;
  document.getElementById('cmd-detalhe-titulo').textContent = `🧾 ${identificador}`;
  if (comandaAtualDados) comandaAtualDados.atendente = _atendentePendente || null;
  return nova.id;
}

async function abrirModalComanda(id) {
  const c = await api(`/comandas/${id}`);
  if (!c) return;
  comandaAtualId = c.id;
  comandaPagamentosPendentes = [];
  document.getElementById('cmd-detalhe-titulo').textContent = `🧾 ${c.identificador}${c.atendente ? ' · ' + c.atendente : ''}`;
  document.getElementById('cmd-item-busca').value = '';
  document.getElementById('cmd-item-produto-id').value = '';
  document.getElementById('cmd-item-qtd').value = '1';
  document.getElementById('cmd-item-preco').value = '';
  document.getElementById('cmd-desconto').value = c.desconto > 0 ? parseFloat(c.desconto) : '';
  document.getElementById('cmd-acrescimo').value = c.acrescimo > 0 ? parseFloat(c.acrescimo) : '';

  renderItensComanda(c);
  renderRapidoGrid();

  const acoes = document.getElementById('cmd-detalhe-acoes');
  const btnCancelar = document.querySelector('#modal-comanda .btn-ghost');
  const btnConcluir = document.getElementById('cmd-btn-concluir-lancamento');
  const bloqueada = c.status !== 'aberta';
  // Modo Lançamento: tablet do salão só lança pedido, sem cobrança nem desconto/acréscimo.
  // Quem cancela/cobra a comanda é sempre o caixa, não o tablet do salão.
  acoes.style.display = (bloqueada || MODO_LANCAMENTO) ? 'none' : 'block';
  document.querySelector('.cmd-add-item').style.display = bloqueada ? 'none' : 'flex';
  document.getElementById('cmd-ajuste-row').style.display = (bloqueada || MODO_LANCAMENTO) ? 'none' : 'flex';
  // Calculadora e a faixa "Total a Receber" também são coisa de cobrança — não fazem
  // sentido no tablet de lançamento, que só cadastra pedido.
  document.getElementById('cmd-calculadora').style.display = MODO_LANCAMENTO ? 'none' : 'block';
  const totalRow = document.querySelector('.cmd-pdv-total-row');
  if (totalRow) totalRow.style.display = MODO_LANCAMENTO ? 'none' : 'flex';
  if (bloqueada) document.getElementById('cmd-rapido-grid').style.display = 'none';
  if (btnCancelar) btnCancelar.style.display = (bloqueada || MODO_LANCAMENTO) ? 'none' : 'block';
  if (btnConcluir) btnConcluir.classList.toggle('hidden', bloqueada || !MODO_LANCAMENTO);

  document.getElementById('modal-comanda').classList.remove('hidden');
  atualizarTopbarPdv();
}

// Barrinha "Vendedor / Cliente / Relógio" do topo da tela de venda, estilo PDV.
let _cmdRelogioTimer = null;
function atualizarTopbarPdv() {
  const vendedorEl = document.getElementById('cmd-pdv-vendedor');
  if (vendedorEl) vendedorEl.textContent = 'Caixa: ' + (caixaAtualCache?.atendente || '—');
  atualizarLabelAtendenteComanda();
  if (_cmdRelogioTimer) clearInterval(_cmdRelogioTimer);
  const tick = () => {
    const el = document.getElementById('cmd-pdv-relogio');
    if (el) el.textContent = new Date().toLocaleTimeString('pt-BR');
  };
  tick();
  _cmdRelogioTimer = setInterval(tick, 1000);
}

// Grid de toque rápido — produtos marcados como "venda rápida" no Estoque
function renderRapidoGrid() {
  const el = document.getElementById('cmd-rapido-grid');
  if (!el) return;
  const rapidos = produtosCache.filter(p => p.venda_rapida);
  if (!rapidos.length) { el.innerHTML = ''; el.style.display = 'none'; return; }
  el.style.display = 'grid';
  el.innerHTML = rapidos.map(p => `
    <button class="cmd-rapido-btn" onclick="adicionarItemRapido(${p.id})">
      <span class="cmd-rapido-nome">${p.nome}</span>
      <span class="cmd-rapido-preco">${fmtMoeda(p.preco_venda || 0)}</span>
    </button>
  `).join('');
}

async function adicionarItemRapido(produtoId) {
  if (!comandaAtualId) return;
  const produto = produtosCache.find(p => p.id === produtoId);
  if (!produto) return;
  const r = await api(`/comandas/${comandaAtualId}/itens`, {
    method: 'POST',
    body: { produto_id: produto.id, nome_produto: produto.nome, quantidade: 1, preco_unitario: produto.preco_venda || 0 }
  });
  if (!r) return;
  const c = await api(`/comandas/${comandaAtualId}`);
  if (c) renderItensComanda(c);
}

// Desconto/acréscimo
async function salvarAjusteComanda() {
  if (!comandaAtualId) return;
  const desconto = document.getElementById('cmd-desconto').value || 0;
  const acrescimo = document.getElementById('cmd-acrescimo').value || 0;
  const r = await api(`/comandas/${comandaAtualId}/ajuste`, { method: 'PATCH', body: { desconto, acrescimo } });
  if (!r) return;
  const c = await api(`/comandas/${comandaAtualId}`);
  if (c) renderItensComanda(c);
}

function renderItensComanda(c) {
  comandaAtualDados = c;
  const el = document.getElementById('cmd-detalhe-itens');
  const ultimoIdx = c.itens.length - 1;
  el.innerHTML = c.itens.length
    ? c.itens.map((i, idx) => `
      <div class="cmd-item-linha${idx === ultimoIdx ? ' cmd-item-atual' : ''}${i._pendente ? ' cmd-item-pendente' : ''}">
        <div class="cmd-item-nome">
          <span class="cmd-item-numero">Item Nº: ${idx + 1}${i.produto_id ? ' · Cód: ' + i.produto_id : ''}${i._pendente ? ' · ⏳ sem conexão' : ''}</span>
          <strong>${i.nome_produto}</strong>
        </div>
        <div class="cmd-item-qtdpreco">${fmtQtd(i.quantidade)} ${i.unidade} × ${fmtMoeda(i.preco_unitario)}</div>
        <div class="cmd-item-direita">
          <span class="cmd-item-subtotal">${fmtMoeda(i.subtotal)}</span>
          ${c.status === 'aberta' ? `<button class="btn-icon" onclick="removerItemComandaPedirPin('${i.id}')" title="Excluir item (requer PIN de gerente)">✕</button>` : ''}
        </div>
      </div>
    `).join('')
    : `<div class="cmd-vazio">Nenhum item adicionado ainda.</div>`;
  const qtdeTotal = c.itens.reduce((s, i) => s + parseFloat(i.quantidade), 0);
  document.getElementById('cmd-detalhe-qtde').textContent = fmtQtd(qtdeTotal);
  document.getElementById('cmd-detalhe-total').textContent = fmtMoeda(c.total);
  atualizarPagamentoUI();
}

// Modo Lançamento: "Concluir e voltar" marca a comanda como pronta pro caixa cobrar —
// ela some da lista de quem lança pedido, mas continua aberta pra quem tá no caixa ver.
async function concluirLancamentoUI() {
  if (comandaAtualId) {
    const r = await api(`/comandas/${comandaAtualId}/enviar`, { method: 'POST' });
    if (!r) return;
  }
  fecharModalComanda();
}

function fecharModalComanda() {
  document.getElementById('modal-comanda').classList.add('hidden');
  comandaAtualId = null;
  if (_cmdRelogioTimer) { clearInterval(_cmdRelogioTimer); _cmdRelogioTimer = null; }
  // Sem isso, o card da comanda na lista ficava com os dados antigos (0 itens, R$ 0,00)
  // até a pessoa puxar a tela pra baixo pra atualizar manualmente.
  carregarComandas();
}

// ── Código de balança (peso variável) ────────────────────
// Formato usado pela maioria das balanças de padaria/açougue (Toledo, Filizola, Urano):
// EAN-13 começando com "2", seguido de 6 dígitos de código interno do produto,
// 5 dígitos de preço em centavos, e 1 dígito verificador. Ex: 2 052000 01400 4 = R$14,00.
function decodificarCodigoBalanca(codigo) {
  const c = String(codigo || '').trim();
  if (!/^2\d{12}$/.test(c)) return null;
  const codigoProduto = c.slice(1, 7);
  const precoCentavos = parseInt(c.slice(7, 12), 10);
  if (isNaN(precoCentavos)) return null;
  return { codigoProduto, preco: precoCentavos / 100 };
}

// ── Leitor de código de barras "global" na tela de Comandas ──
// O leitor físico digita rápido e manda Enter no final, como um teclado. Isso captura
// esse bipe em qualquer lugar da tela (sem precisar clicar no campo de busca antes),
// desde que o cursor não esteja dentro de outro campo de texto sendo usado pra digitar algo.
let _scanBuffer = '';
let _scanBufferTimer = null;

document.addEventListener('keydown', (e) => {
  const telaComandas = !document.getElementById('pg-comandas')?.classList.contains('hidden');
  if (!telaComandas) return;

  const ae = document.activeElement;
  const emCampoTexto = ae && (ae.tagName === 'INPUT' || ae.tagName === 'TEXTAREA');
  // Campo de busca já tem seu próprio handler (onkeydown) — não duplica aqui.
  if (emCampoTexto && (ae.id === 'cmd-busca-numero' || ae.id === 'cmd-item-busca')) return;
  // Cursor em outro campo (ex: desconto, nome de cliente) — é digitação de verdade, não intercepta.
  if (emCampoTexto) return;

  if (e.key === 'Enter') {
    const codigo = _scanBuffer;
    _scanBuffer = '';
    if (!codigo) return;
    e.preventDefault();
    processarScanGlobalComandas(codigo);
    return;
  }
  if (/^[0-9]$/.test(e.key)) {
    _scanBuffer += e.key;
    clearTimeout(_scanBufferTimer);
    _scanBufferTimer = setTimeout(() => { _scanBuffer = ''; }, 300);
  }
});

async function processarScanGlobalComandas(codigo) {
  const modalComandaAberto = !document.getElementById('modal-comanda')?.classList.contains('hidden');
  if (modalComandaAberto) {
    const input = document.getElementById('cmd-item-busca');
    input.value = codigo;
    await onKeydownBuscaComanda({ key: 'Enter', preventDefault(){} }, input);
  } else {
    document.getElementById('cmd-busca-numero').value = codigo;
    await onKeydownBuscaRapidaComanda({ key: 'Enter', preventDefault(){} });
  }
}

// Enter no campo de busca da comanda: se for um código de balança, resolve e lança direto.
// Formato "peso * código" (ex: "0,300*224") — usado quando a atendente pesa numa
// balança separada (sem etiqueta impressa) e digita o peso direto na hora da venda,
// igual o Saurus já faz. Aceita vírgula ou ponto decimal, com ou sem espaço no "*".
function decodificarPesoVezesCodigo(texto) {
  const m = String(texto || '').trim().match(/^(\d+[.,]\d+)\s*\*\s*(\d+)$/);
  if (!m) return null;
  const peso = parseFloat(m[1].replace(',', '.'));
  const codigoProduto = m[2];
  if (!peso || peso <= 0) return null;
  return { peso, codigoProduto };
}

async function onKeydownBuscaComanda(e, input) {
  if (e.key !== 'Enter') return;

  const pesoVezes = decodificarPesoVezesCodigo(input.value.trim());
  if (pesoVezes) {
    e.preventDefault();
    input.parentElement.querySelector('.cmd-item-lista')?.classList.add('hidden');
    // Busca por código de balança primeiro (o mais comum pra item pesado), depois
    // pelo ID do produto e pelo código de barras, pra cobrir o que já tiver cadastrado.
    const produto = produtosCache.find(p => p.codigo_balanca && p.codigo_balanca.trim() === pesoVezes.codigoProduto)
      || produtosCache.find(p => String(p.id) === pesoVezes.codigoProduto)
      || produtosCache.find(p => p.codigo_barras && p.codigo_barras.trim() === pesoVezes.codigoProduto);
    if (!produto) {
      mostrarToast(`Nenhum produto encontrado com o código ${pesoVezes.codigoProduto}.`, 'warn');
      return;
    }
    document.getElementById('cmd-item-busca').value = produto.nome;
    document.getElementById('cmd-item-produto-id').value = produto.id;
    document.getElementById('cmd-item-qtd').value = pesoVezes.peso;
    document.getElementById('cmd-item-preco').value = parseFloat(produto.preco_venda || 0).toFixed(2);
    await adicionarItemComandaUI();
    return;
  }

  const info = decodificarCodigoBalanca(input.value.trim());
  if (!info) {
    // Texto normal (nome de produto digitado ou já selecionado no autocomplete) —
    // Enter lança o item direto, igual clicar no "+", sem precisar tocar em mais nada.
    e.preventDefault();
    input.parentElement.querySelector('.cmd-item-lista')?.classList.add('hidden');
    await adicionarItemComandaUI();
    return;
  }
  e.preventDefault();
  input.parentElement.querySelector('.cmd-item-lista')?.classList.add('hidden');

  const produto = produtosCache.find(p => p.codigo_balanca && p.codigo_balanca.trim() === info.codigoProduto);
  if (produto) {
    document.getElementById('cmd-item-busca').value = produto.nome;
    document.getElementById('cmd-item-produto-id').value = produto.id;
    document.getElementById('cmd-item-qtd').value = '1';
    document.getElementById('cmd-item-preco').value = info.preco.toFixed(2);
    await adicionarItemComandaUI();
    return;
  }

  input.value = '';
  abrirModalVinculoBalanca(info.codigoProduto, info.preco, async (produtoVinculado) => {
    document.getElementById('cmd-item-busca').value = produtoVinculado.nome;
    document.getElementById('cmd-item-produto-id').value = produtoVinculado.id;
    document.getElementById('cmd-item-qtd').value = '1';
    document.getElementById('cmd-item-preco').value = info.preco.toFixed(2);
    await adicionarItemComandaUI();
  });
}

// ── Vinculação rápida de código de balança a um produto ──
let _vincCodigoBalanca = null;
let _vincCallback = null;

function abrirModalVinculoBalanca(codigo, preco, callback) {
  _vincCodigoBalanca = codigo;
  _vincCallback = callback;
  document.getElementById('vinc-balanca-codigo').textContent = codigo;
  document.getElementById('vinc-balanca-preco').textContent = fmtMoeda(preco);
  document.getElementById('vinc-busca-produto').value = '';
  const lista = document.getElementById('vinc-lista');
  lista.innerHTML = '';
  lista.classList.add('hidden');
  document.getElementById('modal-vinculo-balanca').classList.remove('hidden');
  setTimeout(() => document.getElementById('vinc-busca-produto').focus(), 100);
}

function filtrarVinculoBalanca(input) {
  const termo = input.value.trim().toLowerCase();
  const lista = document.getElementById('vinc-lista');
  if (!termo) { lista.classList.add('hidden'); lista.innerHTML = ''; return; }
  const filtrados = produtosCache.filter(p => p.nome.toLowerCase().includes(termo)).slice(0, 8);
  if (!filtrados.length) {
    lista.innerHTML = `<div class="autocomplete-item" style="color:var(--slate-400);cursor:default;">Nenhum produto encontrado.</div>`;
    lista.classList.remove('hidden');
    return;
  }
  lista.innerHTML = filtrados.map(p => `
    <div class="autocomplete-item" onclick="vincularProdutoBalanca(${p.id})">
      ${p.nome}${p.codigo_balanca ? ` <span style="color:var(--slate-400);font-size:12px;">· já tem cód ${p.codigo_balanca}</span>` : ''}
    </div>
  `).join('');
  lista.classList.remove('hidden');
}

async function vincularProdutoBalanca(produtoId) {
  const r = await api(`/produtos/${produtoId}`, { method: 'PUT', body: { codigo_balanca: _vincCodigoBalanca } });
  if (!r) return;
  const produto = produtosCache.find(p => p.id === produtoId);
  if (produto) produto.codigo_balanca = _vincCodigoBalanca;
  fecharModal('modal-vinculo-balanca');
  mostrarToast(`Código ${_vincCodigoBalanca} vinculado a "${produto?.nome}"!`, 'ok');
  if (_vincCallback && produto) await _vincCallback(produto);
}

function criarProdutoParaVinculoBalanca() {
  const codigo = _vincCodigoBalanca;
  fecharModal('modal-vinculo-balanca');
  mostrarPagina('estoque');
  abrirModalProduto();
  setTimeout(() => { document.getElementById('prod-cod-balanca').value = codigo; }, 50);
}

// ── Categorias/produtos em grade colorida (estilo Saurus) ──
const CAT_COMANDA_CORES = ['#0f172a','#7c3aed','#0891b2','#dc2626','#16a34a','#ca8a04','#db2777','#4f46e5','#0d9488','#ea580c','#65a30d','#9333ea'];

function abrirCategoriasComanda() {
  const categorias = [...new Set(produtosCache.map(p => p.categoria || 'Sem categoria'))].sort((a, b) => a.localeCompare(b, 'pt-BR'));
  const grid = document.getElementById('cat-comanda-grid');
  grid.innerHTML = categorias.map((c, i) => `
    <button class="cat-tile" style="background:${CAT_COMANDA_CORES[i % CAT_COMANDA_CORES.length]}" onclick="abrirProdutosDaCategoria('${c.replace(/'/g, "\\'")}')">
      <span class="cat-tile-nome">${c}</span>
    </button>
  `).join('') || '<div class="cmd-vazio">Nenhum produto cadastrado ainda.</div>';
  document.getElementById('cat-comanda-titulo').textContent = 'Categorias Disponíveis';
  document.getElementById('cat-comanda-voltar').classList.add('hidden');
  document.getElementById('modal-categorias-comanda').classList.remove('hidden');
}

function abrirProdutosDaCategoria(categoria) {
  const produtos = produtosCache
    .filter(p => (p.categoria || 'Sem categoria') === categoria)
    .sort((a, b) => a.nome.localeCompare(b.nome, 'pt-BR'));
  const grid = document.getElementById('cat-comanda-grid');
  grid.innerHTML = produtos.map((p, i) => `
    <button class="cat-tile" style="background:${CAT_COMANDA_CORES[i % CAT_COMANDA_CORES.length]}" onclick="adicionarProdutoCategoriaUI(${p.id})">
      <span class="cat-tile-nome">${p.nome}</span>
      <span class="cat-tile-preco">${fmtMoeda(p.preco_venda || 0)}</span>
    </button>
  `).join('') || '<div class="cmd-vazio">Nenhum produto nessa categoria.</div>';
  document.getElementById('cat-comanda-titulo').textContent = categoria;
  document.getElementById('cat-comanda-voltar').classList.remove('hidden');
}

async function adicionarProdutoCategoriaUI(produtoId) {
  const produto = produtosCache.find(p => p.id === produtoId);
  if (!produto) return;
  const comandaId = await garantirComandaBalcaoAtiva();
  if (!comandaId) return;
  const r = await api(`/comandas/${comandaId}/itens`, {
    method: 'POST',
    body: { produto_id: produto.id, nome_produto: produto.nome, quantidade: 1, preco_unitario: produto.preco_venda || 0 }
  });
  if (!r) return;
  const c = await api(`/comandas/${comandaId}`);
  if (c) renderItensComanda(c);
  mostrarToast(`${produto.nome} adicionado!`, 'ok');
}

function filtrarProdutoComanda(input) {
  const termo = input.value.trim().toLowerCase();
  const lista = input.parentElement.querySelector('.cmd-item-lista');
  document.getElementById('cmd-item-produto-id').value = '';
  if (!termo) { lista.classList.add('hidden'); return; }
  const souNumero = /^\d+$/.test(termo);
  const filtrados = souNumero
    ? produtosCache.filter(p => String(p.id) === termo || (p.codigo_barras && p.codigo_barras.startsWith(termo))).slice(0, 8)
    : produtosCache.filter(p => p.nome.toLowerCase().includes(termo)).slice(0, 8);
  const itensHtml = filtrados.map(p =>
    `<div class="autocomplete-item cmd-item-opt" data-produto-id="${p.id}" data-nome="${p.nome.replace(/"/g,'&quot;')}" data-preco="${p.preco_venda || 0}" data-unidade="${p.unidade||'un'}">${p.nome} <span style="color:var(--slate-400);font-size:12px;">${p.codigo_barras ? 'Cód '+p.codigo_barras+' · ' : ''}${fmtMoeda(p.preco_venda||0)}</span></div>`
  );
  lista.innerHTML = itensHtml.join('');
  lista.classList.toggle('hidden', !itensHtml.length);
}

document.addEventListener('mousedown', e => {
  const opt = e.target.closest('.cmd-item-opt');
  if (opt) {
    e.preventDefault();
    const wrap = opt.closest('.fi-busca-wrap');
    wrap.querySelector('#cmd-item-busca').value = opt.dataset.nome;
    document.getElementById('cmd-item-produto-id').value = opt.dataset.produtoId;
    document.getElementById('cmd-item-preco').value = parseFloat(opt.dataset.preco).toFixed(2);
    wrap.querySelector('.cmd-item-lista').classList.add('hidden');
    return;
  }
  if (!e.target.closest('#cmd-item-busca')) {
    const lista = document.querySelector('.cmd-item-lista');
    if (lista) lista.classList.add('hidden');
  }
});

// ── Teclado numérico estilo caixa (busca por código digitado) ───────────
function toggleTecladoCaixa() {
  document.getElementById('cmd-teclado-caixa').classList.toggle('hidden');
}
function tecladoCaixaNum(n) {
  const v = document.getElementById('teclado-caixa-visor');
  v.value += n;
}
function tecladoCaixaApagar() {
  const v = document.getElementById('teclado-caixa-visor');
  v.value = v.value.slice(0, -1);
}
function tecladoCaixaClear() {
  document.getElementById('teclado-caixa-visor').value = '';
}
async function tecladoCaixaBuscar() {
  const codigo = document.getElementById('teclado-caixa-visor').value.trim();
  if (!codigo) return;
  // Mesma ordem de busca usada no código digitado no campo principal: balança, id, barras
  const produto = produtosCache.find(p => p.codigo_balanca && p.codigo_balanca.trim() === codigo)
    || produtosCache.find(p => String(p.id) === codigo)
    || produtosCache.find(p => p.codigo_barras && p.codigo_barras.trim() === codigo);
  if (!produto) {
    mostrarToast(`Nenhum produto encontrado com o código ${codigo}.`, 'warn');
    return;
  }
  document.getElementById('cmd-item-busca').value = produto.nome;
  document.getElementById('cmd-item-produto-id').value = produto.id;
  document.getElementById('cmd-item-qtd').value = '1';
  document.getElementById('cmd-item-preco').value = parseFloat(produto.preco_venda || 0).toFixed(2);
  await adicionarItemComandaUI();
  tecladoCaixaClear();
}

// ── Leitor de código de barras pela câmera do celular ────────────────────
let _scannerStream = null;
let _scannerAtivo = false;
async function abrirScannerCodigoBarras() {
  if (!('BarcodeDetector' in window)) {
    mostrarToast('Esse navegador não tem suporte a leitura de código de barras pela câmera. Digite o código manualmente.', 'warn');
    return;
  }
  document.getElementById('modal-scanner').classList.remove('hidden');
  const video = document.getElementById('scanner-video');
  const status = document.getElementById('scanner-status');
  try {
    _scannerStream = await navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } });
    video.srcObject = _scannerStream;
    await video.play();
  } catch (e) {
    status.textContent = 'Não consegui acessar a câmera. Verifique a permissão do navegador.';
    return;
  }
  _scannerAtivo = true;
  const detector = new BarcodeDetector({ formats: ['ean_13', 'ean_8', 'code_128', 'upc_a', 'upc_e', 'code_39'] });
  const loop = async () => {
    if (!_scannerAtivo) return;
    try {
      const codigos = await detector.detect(video);
      if (codigos.length) {
        const valor = codigos[0].rawValue.trim();
        status.textContent = `Código lido: ${valor}`;
        const produto = produtosCache.find(p => p.codigo_barras && p.codigo_barras.trim() === valor)
          || produtosCache.find(p => p.codigo_balanca && p.codigo_balanca.trim() === valor);
        if (produto) {
          fecharScannerCodigoBarras();
          document.getElementById('cmd-item-busca').value = produto.nome;
          document.getElementById('cmd-item-produto-id').value = produto.id;
          document.getElementById('cmd-item-qtd').value = '1';
          document.getElementById('cmd-item-preco').value = parseFloat(produto.preco_venda || 0).toFixed(2);
          await adicionarItemComandaUI();
          return;
        } else {
          mostrarToast(`Nenhum produto cadastrado com o código ${valor}.`, 'warn');
        }
      }
    } catch (e) { /* detector falhou nesse frame, tenta de novo */ }
    requestAnimationFrame(loop);
  };
  requestAnimationFrame(loop);
}
function fecharScannerCodigoBarras() {
  _scannerAtivo = false;
  if (_scannerStream) { _scannerStream.getTracks().forEach(t => t.stop()); _scannerStream = null; }
  document.getElementById('modal-scanner').classList.add('hidden');
}

async function adicionarItemComandaUI() {
  if (caixaAtualCache?.pausado) { mostrarToast('Caixa pausado — retome o caixa antes de lançar item.', 'warn'); return; }
  const nome = document.getElementById('cmd-item-busca').value.trim();
  const produto_id = document.getElementById('cmd-item-produto-id').value || null;
  const quantidade = parseFloat(document.getElementById('cmd-item-qtd').value);
  const precoInput = document.getElementById('cmd-item-preco').value;
  const preco_unitario = precoInput !== '' ? parseFloat(precoInput) : null;

  if (!nome) { mostrarToast('Digite ou selecione um item.', 'warn'); return; }
  if (!quantidade || quantidade <= 0) { mostrarToast('Quantidade inválida.', 'warn'); return; }

  // Modo Resiliente: sem conexão, mas a comanda já existe (não precisa criar nada
  // no servidor) — lança localmente na hora e guarda pra sincronizar quando voltar.
  if (MODO_OFFLINE && comandaAtualId) {
    const produto = produto_id ? produtosCache.find(p => p.id == produto_id) : null;
    const precoFinal = preco_unitario != null ? preco_unitario : (produto?.preco_venda || 0);
    const localId = 'offline-' + Date.now() + '-' + Math.random().toString(36).slice(2);
    _filaOfflineItens.push({ _localId: localId, comandaId: comandaAtualId, produto_id, nome_produto: nome, quantidade, preco_unitario: precoFinal });
    comandaAtualDados.itens.push({
      id: localId,
      produto_id, nome_produto: nome, unidade: produto?.unidade || 'un',
      quantidade, preco_unitario: precoFinal, subtotal: quantidade * precoFinal, _pendente: true
    });
    comandaAtualDados.total = comandaAtualDados.itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
    renderItensComanda(comandaAtualDados);
    atualizarFaixaOffline('offline');
    document.getElementById('cmd-item-busca').value = '';
    document.getElementById('cmd-item-produto-id').value = '';
    document.getElementById('cmd-item-qtd').value = '1';
    document.getElementById('cmd-item-preco').value = '';
    mostrarToast(`${nome} lançado sem conexão — sincroniza quando voltar.`, 'warn');
    return;
  }

  const comandaId = await garantirComandaBalcaoAtiva();
  if (!comandaId) return;

  const r = await api(`/comandas/${comandaId}/itens`, {
    method: 'POST',
    body: { produto_id, nome_produto: nome, quantidade, preco_unitario }
  });
  if (!r) return;

  document.getElementById('cmd-item-busca').value = '';
  document.getElementById('cmd-item-produto-id').value = '';
  document.getElementById('cmd-item-qtd').value = '1';
  document.getElementById('cmd-item-preco').value = '';

  const c = await api(`/comandas/${comandaAtualId}`);
  if (c) renderItensComanda(c);
}

// Excluir item é uma ação sensível — exige login de atendente com papel "gerente".
function removerItemComandaPedirPin(itemId) {
  removerItemComandaUI(itemId);
}

async function removerItemComandaUI(itemId) {
  if (!comandaAtualId) return;
  // Item lançado sem conexão (ainda não existe no servidor) — remove só localmente e da fila.
  if (String(itemId).startsWith('offline-')) {
    comandaAtualDados.itens = comandaAtualDados.itens.filter(i => i.id !== itemId);
    _filaOfflineItens = _filaOfflineItens.filter(f => f._localId !== itemId);
    comandaAtualDados.total = comandaAtualDados.itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
    renderItensComanda(comandaAtualDados);
    return;
  }
  const r = await comLoginAtendente(() => api(`/comandas/${comandaAtualId}/itens/${itemId}`, { method: 'DELETE' }));
  if (!r || r.precisa_login_funcionario) return;
  const c = await api(`/comandas/${comandaAtualId}`);
  if (c) renderItensComanda(c);
}

// ── Pagamento dividido (estilo Saurus: toca a forma, informa o valor, pode repetir com outra forma) ──
let comandaPagamentosPendentes = [];

// ── Calculadora rápida (dentro da comanda) ───────────────────────
let _calcExpressao = '';
function toggleCalculadora() {
  document.getElementById('cmd-calculadora').classList.toggle('hidden');
}
function calcAtualizarVisor() {
  document.getElementById('calc-visor').value = _calcExpressao
    ? _calcExpressao.replace(/\*/g, '×').replace(/\//g, '÷')
    : '0';
}
function calcNum(n) {
  if (n === '.' && _calcExpressao.split(/[-+*/]/).pop().includes('.')) return; // só 1 vírgula por número
  _calcExpressao += n;
  calcAtualizarVisor();
}
function calcOp(op) {
  if (!_calcExpressao) return;
  // Troca o operador se a pessoa clicar em outro logo em seguida, em vez de acumular.
  if (/[-+*/]$/.test(_calcExpressao)) _calcExpressao = _calcExpressao.slice(0, -1);
  _calcExpressao += op;
  calcAtualizarVisor();
}
function calcApagar() {
  _calcExpressao = _calcExpressao.slice(0, -1);
  calcAtualizarVisor();
}
function calcClear() {
  _calcExpressao = '';
  calcAtualizarVisor();
}
function calcIgual() {
  if (!_calcExpressao) return;
  try {
    // Só dígitos, vírgula/ponto e os 4 operadores básicos — nunca roda texto arbitrário.
    if (!/^[0-9.+\-*/]+$/.test(_calcExpressao)) throw new Error('inválido');
    const resultado = Function(`"use strict"; return (${_calcExpressao})`)();
    if (!isFinite(resultado)) throw new Error('inválido');
    _calcExpressao = String(Math.round(resultado * 100) / 100);
  } catch {
    _calcExpressao = '';
    document.getElementById('calc-visor').value = 'Erro';
    return;
  }
  calcAtualizarVisor();
}

// ── Confirmação bonita (substitui o confirm() feio do navegador) ──────────
// Popup no meio da tela, navegável com ← → e confirma com Enter — sem precisar
// tocar na tela, do jeito que se usa uma maquininha/PDV de verdade.
let _resolverConfirmarBonitoAtual = null;
function confirmarBonito(mensagem) {
  return new Promise((resolve) => {
    _resolverConfirmarBonitoAtual = resolve;
    document.getElementById('confirmar-bonito-msg').textContent = mensagem;
    document.getElementById('modal-confirmar-bonito').classList.remove('hidden');
    const btnOk = document.getElementById('confirmar-bonito-ok');
    btnOk.focus();
    document.addEventListener('keydown', _teclasConfirmarBonito);
  });
}
function _teclasConfirmarBonito(e) {
  const btnOk = document.getElementById('confirmar-bonito-ok');
  const btnCancelar = document.getElementById('confirmar-bonito-cancelar');
  if (e.key === 'ArrowLeft') { e.preventDefault(); btnCancelar.focus(); }
  if (e.key === 'ArrowRight') { e.preventDefault(); btnOk.focus(); }
  if (e.key === 'Escape') { e.preventDefault(); _resolverConfirmarBonito(false); }
  if (e.key === 'Enter') {
    e.preventDefault();
    _resolverConfirmarBonito(document.activeElement === btnCancelar ? false : true);
  }
}
function _resolverConfirmarBonito(valor) {
  document.getElementById('modal-confirmar-bonito').classList.add('hidden');
  document.removeEventListener('keydown', _teclasConfirmarBonito);
  if (_resolverConfirmarBonitoAtual) { const r = _resolverConfirmarBonitoAtual; _resolverConfirmarBonitoAtual = null; r(valor); }
}

function calcularRestante() {
  const total = comandaAtualDados ? parseFloat(comandaAtualDados.total) : 0;
  const pago = comandaPagamentosPendentes.reduce((s, p) => s + p.valor, 0);
  return Math.max(0, Math.round((total - pago) * 100) / 100);
}

// Atalhos F1–F5 pras formas de pagamento (padrão de PDV) enquanto a comanda está aberta.
const CMD_PGTO_ATALHOS = { F1: 'Dinheiro', F2: 'Crédito', F3: 'Débito', F4: 'Pix', F5: 'Voucher', F6: 'Faturado', F7: 'Padaria' };
document.addEventListener('keydown', (e) => {
  const forma = CMD_PGTO_ATALHOS[e.key];
  if (!forma) return;
  const modalAberto = !document.getElementById('modal-comanda')?.classList.contains('hidden');
  if (!modalAberto) return;
  e.preventDefault(); // evita o comportamento padrão do navegador pra tecla F (ex: F1 = ajuda)
  adicionarPagamentoUI(forma);
});

function adicionarPagamentoUI(forma) {
  if (caixaAtualCache?.pausado) { mostrarToast('Caixa pausado — retome o caixa antes de cobrar.', 'warn'); return; }
  if (MODO_OFFLINE) { mostrarToast('Sem conexão — aguarda a internet voltar pra cobrar.', 'warn'); return; }
  if (!comandaAtualDados || !comandaAtualDados.itens || !comandaAtualDados.itens.length) {
    mostrarToast('Adicione itens antes de lançar pagamento.', 'warn');
    return;
  }
  const restante = calcularRestante();
  if (restante <= 0) { mostrarToast('Essa comanda já está totalmente paga.', 'warn'); return; }

  // Dinheiro sempre pede o valor recebido — é o único jeito de calcular troco.
  if (forma === 'Dinheiro') {
    abrirModalValorPagamento(forma, restante, true);
    return;
  }

  // Primeiro toque numa forma de pagamento (que não seja dinheiro): assume que é o valor
  // total (caso mais comum, venda de balcão à vista numa forma só) e já cobra tudo, sem
  // precisar digitar nada. Só pede o valor a partir do 2º toque, quando é divisão de verdade.
  if (comandaPagamentosPendentes.length === 0) {
    comandaPagamentosPendentes.push({ forma_pagamento: forma, valor: restante });
    atualizarPagamentoUI();
    if (calcularRestante() <= 0) finalizarVendaUI();
    return;
  }

  abrirModalValorPagamento(forma, restante, false);
}

// ── Modal de valor recebido (troco no dinheiro + divisão de pagamento) ──
let _pgtoForma = null, _pgtoRestante = 0, _pgtoEhDinheiro = false;

function abrirModalValorPagamento(forma, restante, ehDinheiro) {
  _pgtoForma = forma;
  _pgtoRestante = restante;
  _pgtoEhDinheiro = ehDinheiro;
  document.getElementById('pgto-valor-titulo').textContent = `${forma} — valor recebido`;
  document.getElementById('pgto-valor-sub').textContent = `Falta receber: ${fmtMoeda(restante)}`;
  const input = document.getElementById('pgto-valor-input');
  input.value = ehDinheiro ? '' : restante.toFixed(2);
  document.getElementById('pgto-valor-troco-linha').classList.add('hidden');
  document.getElementById('modal-valor-pagamento').classList.remove('hidden');
  setTimeout(() => { input.focus(); input.select(); }, 100);
  atualizarTrocoUI();
}

function atualizarTrocoUI() {
  if (!_pgtoEhDinheiro) return;
  const valor = parseFloat(document.getElementById('pgto-valor-input').value) || 0;
  const linha = document.getElementById('pgto-valor-troco-linha');
  if (valor <= 0) { linha.classList.add('hidden'); return; }
  const troco = Math.max(0, Math.round((valor - _pgtoRestante) * 100) / 100);
  linha.classList.remove('hidden');
  linha.classList.toggle('zero', troco <= 0);
  linha.textContent = troco > 0 ? `Troco: ${fmtMoeda(troco)}` : 'Sem troco';
}

function confirmarValorPagamento() {
  const valor = parseFloat((document.getElementById('pgto-valor-input').value || '').replace(',', '.'));
  if (!valor || valor <= 0) { mostrarToast('Digite um valor válido.', 'warn'); return; }
  // Dinheiro pode vir maior que o restante (o excedente é troco); qualquer outra forma
  // não pode passar do que falta, senão a comanda "receberia" mais do que o total.
  if (!_pgtoEhDinheiro && valor > _pgtoRestante + 0.01) {
    mostrarToast(`O valor não pode passar do restante (${fmtMoeda(_pgtoRestante)}).`, 'warn');
    return;
  }
  const aplicado = Math.min(valor, _pgtoRestante);
  const troco = _pgtoEhDinheiro ? Math.max(0, Math.round((valor - _pgtoRestante) * 100) / 100) : 0;
  comandaPagamentosPendentes.push({ forma_pagamento: _pgtoForma, valor: aplicado, troco });
  document.getElementById('modal-valor-pagamento').classList.add('hidden');
  atualizarPagamentoUI();
  if (troco > 0) {
    mostrarToast(`Troco: ${fmtMoeda(troco)}`, 'ok');
  }
  if (calcularRestante() <= 0) finalizarVendaUI();
}

function removerPagamentoPendente(idx) {
  comandaPagamentosPendentes.splice(idx, 1);
  atualizarPagamentoUI();
}

function atualizarPagamentoUI() {
  const lista = document.getElementById('cmd-pagamentos-lista');
  const label = document.getElementById('cmd-pgto-label');
  const btnFinalizar = document.getElementById('cmd-btn-finalizar');
  const btnRefazer = document.getElementById('cmd-btn-refazer');
  const resumoEl = document.getElementById('cmd-resumo-venda');
  if (!lista || !label || !btnFinalizar) return;

  lista.innerHTML = comandaPagamentosPendentes.map((p, idx) => `
    <div class="cmd-pagamento-linha">
      <span>${p.forma_pagamento}</span>
      <span>${fmtMoeda(p.valor)}</span>
      <button class="btn-icon" onclick="removerPagamentoPendente(${idx})">✕</button>
    </div>
  `).join('');

  // Resumo da Venda — Valor Total / Desconto / Acréscimo / Total Recebido
  if (resumoEl && comandaAtualDados) {
    const subtotal = (comandaAtualDados.itens || []).reduce((s, i) => s + parseFloat(i.subtotal), 0);
    const desconto = parseFloat(comandaAtualDados.desconto || 0);
    const acrescimo = parseFloat(comandaAtualDados.acrescimo || 0);
    const totalRecebido = comandaPagamentosPendentes.reduce((s, p) => s + p.valor, 0);
    resumoEl.innerHTML = `
      <div class="cmd-resumo-venda-titulo">Resumo da Venda</div>
      <div class="cmd-resumo-linha"><span>Valor Total</span><span>${fmtMoeda(subtotal)}</span></div>
      <div class="cmd-resumo-linha"><span>Desconto Total</span><span>-${fmtMoeda(desconto)}</span></div>
      <div class="cmd-resumo-linha"><span>Acréscimo Total</span><span>+${fmtMoeda(acrescimo)}</span></div>
      <div class="cmd-resumo-linha total"><span>Total Recebido</span><span>${fmtMoeda(totalRecebido)}</span></div>
    `;
  }

  btnRefazer?.classList.toggle('hidden', !comandaPagamentosPendentes.length);

  const restante = calcularRestante();
  if (restante <= 0 && comandaPagamentosPendentes.length) {
    label.textContent = '✅ Pagamento completo';
    btnFinalizar.classList.remove('hidden');
  } else {
    label.textContent = `Restante: ${fmtMoeda(restante)} — toque na forma de pagamento`;
    btnFinalizar.classList.add('hidden');
  }
}

function refazerPagamentos() {
  comandaPagamentosPendentes = [];
  atualizarPagamentoUI();
}

// NFC-e ainda em homologação (teste) — só oferece o botão de emitir pras padarias
// que já configuraram certificado fiscal, pra não incomodar quem ainda não usa isso.
let _fiscalConfiguradoCache = null;
async function fiscalConfigurado() {
  if (_fiscalConfiguradoCache === null) {
    try {
      const r = await api('/fiscal/certificado/status');
      _fiscalConfiguradoCache = !!(r && r.configurado && r.valido);
    } catch (e) { _fiscalConfiguradoCache = false; }
  }
  return _fiscalConfiguradoCache;
}

async function emitirNotaFiscalComanda(comandaId) {
  mostrarToast('Emitindo nota fiscal...');
  const nf = await api(`/fiscal/nfce/comanda/${comandaId}`, { method: 'POST' });
  if (nf && nf.ok) {
    mostrarToast(`Nota fiscal autorizada! Protocolo ${nf.protocolo}`);
    if (await confirmarBonito('Imprimir a nota fiscal (DANFE-NFCe)?')) {
      await imprimirDanfeNFCe(comandaId);
    }
  } else if (nf) {
    mostrarToast(`Nota fiscal rejeitada: ${nf.motivo || 'erro desconhecido'}`);
  }
}

async function imprimirDanfeNFCe(comandaId) {
  const r = await api(`/fiscal/nfce/comanda/${comandaId}/danfe`);
  if (!r || !r.html) return;
  const janela = window.open('', '_blank', 'width=400,height=700');
  if (!janela) { mostrarToast('O navegador bloqueou a janela de impressão — permite pop-up nesse site.', 'warn'); return; }
  janela.document.write(r.html);
  janela.document.close();
  // Sem isso, o diálogo de impressão às vezes abre ATRÁS da janela principal e
  // trava a tela (a pessoa acha que travou, mas é só o diálogo escondido).
  janela.focus();
}

async function finalizarVendaUI() {
  if (!comandaAtualId || !comandaPagamentosPendentes.length) return;
  if (MODO_OFFLINE) { mostrarToast('Sem conexão — aguarda a internet voltar pra cobrar.', 'warn'); return; }
  if (!CAIXA_LOCAL_ID) {
    mostrarToast('Abra o caixa deste aparelho antes de cobrar.', 'warn');
    return;
  }
  const resumo = comandaPagamentosPendentes.map(p => `${p.forma_pagamento}: ${fmtMoeda(p.valor)}`).join(' + ');
  if (!(await confirmarBonito(`Confirmar recebimento — ${resumo}?`))) return;
  const comandaFechadaId = comandaAtualId; // guarda ANTES de fechar o modal, que zera comandaAtualId
  const snapshot = comandaAtualDados; // guarda os itens antes de fechar, pro recibo
  const formaResumo = comandaPagamentosPendentes.map(p => p.forma_pagamento).join(' + ');
  const r = await api(`/comandas/${comandaAtualId}/fechar`, { method: 'POST', body: { pagamentos: comandaPagamentosPendentes, caixa_id: CAIXA_LOCAL_ID } });
  if (!r) return;
  const foiBalcao = comandaAtualId === _balcaoComandaAtiva;
  if (foiBalcao) _balcaoComandaAtiva = null;
  mostrarToast(`Comanda fechada — ${formaResumo}!`, 'ok');
  fecharModalComanda();
  await carregarComandas();
  // "Padaria" é consumo interno — não teve venda de verdade, então não faz sentido
  // (nem é permitido) emitir nota fiscal em cima disso.
  const consumoInterno = comandaPagamentosPendentes.some(p => p.forma_pagamento === 'Padaria');
  // Pergunta a nota fiscal ANTES de abrir a janela de impressão — a janela de
  // impressão fica na frente e escondia esse aviso atrás dela.
  if (!consumoInterno && await fiscalConfigurado()) {
    if (await confirmarBonito('Emitir Nota Fiscal (NFC-e) dessa comanda? (ainda em ambiente de teste — não vale legalmente)')) {
      await emitirNotaFiscalComanda(comandaFechadaId);
    }
  }
  if (snapshot && await confirmarBonito('Imprimir o recibo dessa comanda?')) {
    imprimirReciboComanda(snapshot, formaResumo);
  }
  // Venda de balcão: volta direto pra uma tela em branco, pronta pro próximo cliente
  // (fluxo contínuo, sem precisar passar pela lista de comandas de novo).
  if (foiBalcao) abrirVendaBalcaoVazia();
}

// ── Impressão térmica (80mm) ─────────────────────────────────────
function abrirJanelaImpressaoTermica(bodyHtml) {
  const html = `<!doctype html><html><head><meta charset="utf-8">
    <title>Imprimir</title>
    <style>
      @page { size: 80mm auto; margin: 0; }
      * { box-sizing: border-box; }
      body { width: 80mm; margin: 0; padding: 6px 8px; font-family: 'Courier New', monospace; font-size: 12px; color: #000; }
      h1 { font-size: 15px; text-align: center; margin: 0 0 2px; }
      .sub { text-align: center; font-size: 11px; margin-bottom: 8px; }
      hr { border: none; border-top: 1px dashed #000; margin: 6px 0; }
      .linha { display: flex; justify-content: space-between; gap: 6px; margin: 3px 0; }
      .linha .qtd { flex-shrink: 0; }
      .linha .nome { flex: 1; }
      .linha .valor { flex-shrink: 0; text-align: right; }
      .total { font-size: 14px; font-weight: bold; display: flex; justify-content: space-between; margin-top: 6px; }
      .rodape { text-align: center; font-size: 10px; margin-top: 10px; }
    </style></head><body>
    ${bodyHtml}
    <script>
      window.onload = () => { window.print(); window.onafterprint = () => window.close(); };
    <\/script>
    </body></html>`;
  const w = window.open('', '_blank', 'width=380,height=600');
  if (!w) { mostrarToast('O navegador bloqueou a janela de impressão — permite pop-up nesse site.', 'warn'); return; }
  w.document.write(html);
  w.document.close();
  // Sem isso, o diálogo de impressão às vezes abre ATRÁS da janela principal e
  // trava a tela (a pessoa acha que travou, mas é só o diálogo escondido).
  w.focus();
}

// Ficha pra cozinha/produção — sem valores, só os itens pra separar/preparar
async function imprimirFichaCozinha() {
  const c = comandaAtualDados;
  if (!c || !c.itens || !c.itens.length) { mostrarToast('Adicione itens antes de imprimir.', 'warn'); return; }
  // Abrir a impressão sempre sai da tela cheia (o navegador não deixa evitar isso quando
  // abre uma janela nova) — pelo menos confirma antes, pra não abrir sem querer.
  if (!(await confirmarBonito('Imprimir a ficha pra cozinha?'))) return;
  const agora = new Date().toLocaleString('pt-BR');
  const linhas = c.itens.map(i => `
    <div class="linha">
      <span class="qtd">${fmtQtd(i.quantidade)}x</span>
      <span class="nome">${i.nome_produto}</span>
    </div>
  `).join('');
  abrirJanelaImpressaoTermica(`
    <h1>🧾 COMANDA ${c.identificador}</h1>
    <div class="sub">${agora}</div>
    <hr/>
    ${linhas}
    <hr/>
    <div class="rodape">PanificaPro</div>
  `);
}

// Recibo do cliente — com valores e forma de pagamento, impresso após o fechamento
function imprimirReciboComanda(c, forma_pagamento) {
  const nomePadaria = document.getElementById('sidebar-nome')?.textContent || 'PanificaPro';
  const agora = new Date().toLocaleString('pt-BR');
  const linhas = c.itens.map(i => `
    <div class="linha">
      <span class="qtd">${fmtQtd(i.quantidade)}x</span>
      <span class="nome">${i.nome_produto}</span>
      <span class="valor">${fmtMoeda(i.subtotal)}</span>
    </div>
  `).join('');
  const total = c.itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
  abrirJanelaImpressaoTermica(`
    <h1>${nomePadaria}</h1>
    <div class="sub">Comanda ${c.identificador} · ${agora}</div>
    <hr/>
    ${linhas}
    <hr/>
    <div class="total"><span>TOTAL</span><span>${fmtMoeda(total)}</span></div>
    <div class="sub" style="margin-top:4px;">Pagamento: ${forma_pagamento}</div>
    <div class="rodape">Obrigado pela preferência!</div>
  `);
}

// Busca rápida por número/identificação da comanda (estilo "Digite ou passe a comanda" do PDV)
// Busca produtos por nome ou por ID/código enquanto digita no campo principal
// (ex: "coca" → lista todas as Cocas; "3967" → acha o produto de ID/código 3967 E ainda permite abrir a comanda 3967)
function filtrarBuscaComanda(input) {
  const termo = input.value.trim().toLowerCase();
  const lista = document.getElementById('cmd-busca-produtos-lista');
  if (!termo) { lista.classList.add('hidden'); return; }

  const souNumero = /^\d+$/.test(termo);
  const filtrados = souNumero
    // Número: busca por ID exato ou por código de barras que comece com o número digitado
    ? produtosCache.filter(p => String(p.id) === termo || (p.codigo_barras && p.codigo_barras.startsWith(termo))).slice(0, 10)
    // Texto: busca por nome
    : produtosCache.filter(p => p.nome.toLowerCase().includes(termo)).slice(0, 10);

  if (souNumero && !filtrados.length) { lista.classList.add('hidden'); return; }
  if (!filtrados.length) {
    lista.innerHTML = `<div class="cmd-busca-produtos-vazio">Nenhum produto encontrado para "${input.value.trim()}"</div>`;
    lista.classList.remove('hidden');
    return;
  }
  lista.innerHTML = filtrados.map(p => `
    <div class="cmd-busca-produto-item" onclick="selecionarProdutoBuscaComanda(${p.id})">
      <div class="cmd-busca-produto-texto">
        <span class="cmd-busca-produto-codigo">Código: ${p.codigo_barras || p.id}</span>
        <span class="cmd-busca-produto-nome">${p.nome}</span>
      </div>
      <div class="cmd-busca-produto-direita">
        <span class="cmd-busca-produto-un">${p.unidade || 'UN'}</span>
        <span class="cmd-busca-produto-preco">${fmtMoeda(p.preco_venda || 0)}</span>
      </div>
    </div>
  `).join('');
  lista.classList.remove('hidden');
}

// Clicar num produto da busca principal: pergunta em qual comanda lançar (abre/cria) e já adiciona o item.
async function selecionarProdutoBuscaComanda(produtoId) {
  const produto = produtosCache.find(p => p.id === produtoId);
  if (!produto) return;

  const numero = prompt(`Adicionar "${produto.nome}" em qual comanda?`, document.getElementById('cmd-busca-numero').value.trim());
  if (!numero || !numero.trim()) return;
  const termo = numero.trim();

  document.getElementById('cmd-busca-produtos-lista').classList.add('hidden');
  document.getElementById('cmd-busca-numero').value = '';

  const data = await api('/comandas');
  if (!data) return;
  const todas = [...data.abertas, ...data.recentes];
  let alvo = data.abertas.find(c => c.identificador === termo) || todas.find(c => c.identificador === termo);

  if (!alvo) {
    if (!confirm(`Nenhuma comanda "${termo}" aberta. Abrir uma nova com esse número?`)) return;
    const r = await api('/comandas', { method: 'POST', body: { identificador: termo } });
    if (!r) return;
    alvo = { id: r.id };
  } else if (alvo.status && alvo.status !== 'aberta') {
    mostrarToast('Essa comanda já foi fechada.', 'warn');
    return;
  }

  const add = await api(`/comandas/${alvo.id}/itens`, {
    method: 'POST',
    body: { produto_id: produto.id, nome_produto: produto.nome, quantidade: 1, preco_unitario: produto.preco_venda || 0 }
  });
  if (!add) return;
  mostrarToast(`${produto.nome} adicionado na comanda ${termo}!`, 'ok');
  await carregarComandas();
  abrirModalComanda(alvo.id);
}

document.addEventListener('mousedown', e => {
  if (!e.target.closest('#cmd-busca-produtos-lista') && !e.target.closest('#cmd-busca-numero')) {
    document.getElementById('cmd-busca-produtos-lista')?.classList.add('hidden');
  }
});

// Enter na busca rápida da tela de Comandas: se for etiqueta de balança, abre uma comanda
// nova de balcão na hora e já lança o item — pro cliente que vem direto do setor de pães,
// sem passar por atendimento de mesa/comanda prévia.
async function onKeydownBuscaRapidaComanda(e) {
  if (e.key !== 'Enter') return;
  const input = document.getElementById('cmd-busca-numero');
  const info = decodificarCodigoBalanca(input.value.trim());
  if (!info) { buscarComandaPorNumero(); return; }
  e.preventDefault();

  input.value = '';
  const produto = produtosCache.find(p => p.codigo_balanca && p.codigo_balanca.trim() === info.codigoProduto);

  const lancar = async (produtoFinal) => {
    // Se já tem uma venda de balcão em aberto (cliente bipando vários produtos seguidos),
    // soma nela em vez de abrir uma comanda nova a cada item.
    let comandaId = _balcaoComandaAtiva;
    if (!comandaId) {
      const identificador = 'Balcão ' + new Date().toLocaleTimeString('pt-BR', { hour: '2-digit', minute: '2-digit' });
      const nova = await api('/comandas', { method: 'POST', body: { identificador } });
      if (!nova) return;
      comandaId = nova.id;
      _balcaoComandaAtiva = comandaId;
    }
    const add = await api(`/comandas/${comandaId}/itens`, {
      method: 'POST',
      body: { produto_id: produtoFinal.id, nome_produto: produtoFinal.nome, quantidade: 1, preco_unitario: info.preco }
    });
    if (!add) return;
    await carregarComandas();
    abrirModalComanda(comandaId);
    mostrarToast(`${produtoFinal.nome} — ${fmtMoeda(info.preco)}`, 'ok');
    document.getElementById('cmd-busca-numero').focus();
  };

  if (produto) { await lancar(produto); return; }
  abrirModalVinculoBalanca(info.codigoProduto, info.preco, lancar);
}
let _balcaoComandaAtiva = null;

// Busca comanda por número direto da tela de venda (topbar), sem precisar fechar
// pra voltar à lista — é assim que o caixa acha a comanda que o salão/balcão lançou.
async function abrirComandaPorNumeroPdv(termoRaw) {
  const termo = String(termoRaw || '').trim();
  if (!termo) return;
  const data = await api('/comandas');
  if (!data) return;
  const todas = [...data.abertas, ...data.recentes];
  let alvo = data.abertas.find(c => c.identificador === termo) || todas.find(c => c.identificador === termo);

  document.getElementById('cmd-pdv-busca-numero').value = '';

  if (!alvo) {
    if (!confirm(`Nenhuma comanda "${termo}" aberta. Abrir uma nova com esse número?`)) return;
    const r = await api('/comandas', { method: 'POST', body: { identificador: termo } });
    if (!r) return;
    abrirModalComanda(r.id);
    return;
  }
  if (alvo.status && alvo.status !== 'aberta') { mostrarToast('Essa comanda já foi fechada.', 'warn'); return; }
  abrirModalComanda(alvo.id);
}

// Campo dedicado só pra número (teclado numérico no celular/tablet) — mesma lógica
// do campo de busca completa, só que sem a parte de busca por nome de produto.
async function abrirComandaPorNumeroRapido() {
  const input = document.getElementById('cmd-abrir-numero-rapido');
  const termo = input.value.trim();
  if (!termo) return;
  const data = await api('/comandas');
  if (!data) return;
  const todas = [...data.abertas, ...data.recentes];
  let alvo = data.abertas.find(c => c.identificador === termo)
    || todas.find(c => c.identificador === termo);
  if (!alvo) {
    if (!confirm(`Nenhuma comanda "${termo}" aberta. Abrir uma nova com esse número?`)) return;
    const r = await api('/comandas', { method: 'POST', body: { identificador: termo } });
    if (!r) return;
    input.value = '';
    await carregarComandas();
    abrirModalComanda(r.id);
    return;
  }
  input.value = '';
  abrirModalComanda(alvo.id);
}

async function buscarComandaPorNumero() {
  const termo = document.getElementById('cmd-busca-numero').value.trim();
  if (!termo) return;
  const data = await api('/comandas');
  if (!data) return;
  const todas = [...data.abertas, ...data.recentes];
  // Prioriza comanda aberta com esse identificador exato; senão pega a mais recente com esse nome
  let alvo = data.abertas.find(c => c.identificador === termo)
    || todas.find(c => c.identificador === termo);
  if (!alvo) {
    if (!confirm(`Nenhuma comanda "${termo}" aberta. Abrir uma nova com esse número?`)) return;
    const r = await api('/comandas', { method: 'POST', body: { identificador: termo } });
    if (!r) return;
    document.getElementById('cmd-busca-numero').value = '';
    await carregarComandas();
    abrirModalComanda(r.id);
    return;
  }
  document.getElementById('cmd-busca-numero').value = '';
  abrirModalComanda(alvo.id);
}

async function cancelarComandaUI() {
  if (!comandaAtualId) return;
  if (!confirm('Cancelar essa comanda? Nenhum valor será lançado.')) return;
  // Ação sensível — exige login de atendente com papel "gerente".
  const r = await comLoginAtendente(() => api(`/comandas/${comandaAtualId}/cancelar`, { method: 'POST' }));
  if (!r || !r.ok) return;
  if (comandaAtualId === _balcaoComandaAtiva) _balcaoComandaAtiva = null;
  mostrarToast('Comanda cancelada.', 'ok');
  fecharModalComanda();
  await carregarComandas();
}

/* ===================== ENCOMENDAS ===================== */
const ENC_STATUS_LABEL = { pendente: '🕐 Pendente', producao: '👨‍🍳 Em produção', pronta: '✅ Pronta', entregue: '📦 Entregue', cancelada: '🚫 Cancelada' };
const ENC_PROXIMO_STATUS = { pendente: 'producao', producao: 'pronta', pronta: 'entregue' };
const ENC_PROXIMO_LABEL  = { pendente: 'Iniciar produção', producao: 'Marcar como pronta', pronta: 'Marcar como entregue' };

async function carregarEncomendas() {
  const data = await api('/encomendas');
  if (!data) return;
  const hojeStr = new Date().toISOString().slice(0, 10);

  document.getElementById('enc-lista-abertas').innerHTML = data.abertas.length
    ? data.abertas.map(e => cardEncomendaHtml(e, hojeStr)).join('')
    : `<div class="cmd-vazio">Nenhuma encomenda em aberto.</div>`;

  document.getElementById('enc-lista-recentes').innerHTML = data.recentes.length
    ? data.recentes.map(e => cardEncomendaHtml(e, hojeStr)).join('')
    : `<div class="cmd-vazio">Sem histórico ainda.</div>`;
}

function cardEncomendaHtml(e, hojeStr) {
  const atrasada = e.data_entrega < hojeStr && !['entregue', 'cancelada'].includes(e.status);
  const ehHoje = e.data_entrega === hojeStr;
  const dataFmt = new Date(e.data_entrega + 'T00:00:00').toLocaleDateString('pt-BR');
  const horaFmt = e.hora_entrega ? ' às ' + e.hora_entrega.slice(0, 5) : '';
  const classeExtra = atrasada ? 'enc-card-atrasada' : (ehHoje ? 'enc-card-hoje' : '');
  return `
    <div class="enc-card ${classeExtra}" onclick="abrirModalDetalheEncomenda(${e.id})">
      <div class="enc-card-topo">
        <strong>${e.cliente_nome}</strong>
        <span class="enc-card-status">${ENC_STATUS_LABEL[e.status] || e.status}</span>
      </div>
      <div class="enc-card-desc">${e.descricao}</div>
      <div class="enc-card-rodape">
        <span>${atrasada ? '🔴 Atrasada — ' : (ehHoje ? '🟠 Hoje — ' : '')}${dataFmt}${horaFmt}</span>
        <span class="enc-card-valor">${fmtMoeda(e.valor)}</span>
      </div>
    </div>
  `;
}

async function carregarPainelEncomendas() {
  const el = document.getElementById('painel-encomendas-faixa');
  if (!el) return;
  if (!['premium'].includes(PLANO_ATUAL) && PLANO_ATUAL !== 'admin') { el.innerHTML = ''; return; }
  const r = await api('/encomendas/resumo');
  if (!r || (!r.hoje && !r.atrasadas)) { el.innerHTML = ''; return; }
  const partes = [];
  if (r.atrasadas > 0) partes.push(`🔴 ${r.atrasadas} atrasada${r.atrasadas > 1 ? 's' : ''}`);
  if (r.hoje > 0) partes.push(`🟠 ${r.hoje} pra hoje`);
  el.innerHTML = `
    <div class="cmd-caixa-card ${r.atrasadas > 0 ? 'fechado' : 'aberto'}" style="margin-bottom:20px;cursor:pointer;" onclick="mostrarPagina('encomendas')">
      <span>📋 Encomendas: ${partes.join(' · ')}</span>
      <span style="font-size:12px;opacity:.8;">Ver encomendas →</span>
    </div>`;
}

/* ===================== RELATÓRIO DE VENDAS (Comandas) ===================== */
const REL_VENDAS_PERIODO_LABEL = { hoje: 'Hoje', semana: 'Últimos 7 dias', mes: 'Este mês', mes_passado: 'Mês passado' };
let _relVendasDados = null;

// Relatório de vendas é restrito a gerente — pede o PIN antes de mostrar a tela.
// O PIN fica válido enquanto a tela estiver aberta (pra poder trocar o período
// várias vezes sem pedir de novo), e é esquecido ao fechar a tela.
async function abrirRelatorioVendas() {
  await comLoginAtendente(async () => {
    const r = await api(`/comandas/relatorio?periodo=hoje`);
    if (!r || r.precisa_login_funcionario) return r;
    document.getElementById('tela-relatorio-vendas').classList.remove('hidden');
    const buscaEl = document.getElementById('rel-vendas-busca');
    if (buscaEl) buscaEl.value = '';
    carregarRelatorioVendas();
    return r;
  }, false);
}

function fecharRelatorioVendas() {
  document.getElementById('tela-relatorio-vendas').classList.add('hidden');
  esquecerLoginAtendente();
}

async function carregarRelatorioVendas() {
  const periodo = document.getElementById('rel-vendas-periodo').value;
  document.getElementById('rel-vendas-periodo-label').textContent = REL_VENDAS_PERIODO_LABEL[periodo] || '';

  const r = await api(`/comandas/relatorio?periodo=${periodo}`);
  if (!r || r.precisa_login_funcionario) return;
  _relVendasDados = r;

  const dataFmt = d => new Date(d + 'T00:00:00').toLocaleDateString('pt-BR');
  document.getElementById('rel-vendas-resumo').innerHTML = `
    <div class="rel-vendas-kpi"><strong>${fmtMoeda(r.totais.receita_total)}</strong><span>Receita total</span></div>
    <div class="rel-vendas-kpi"><strong>${r.totais.total_comandas}</strong><span>Comandas fechadas</span></div>
    <div class="rel-vendas-kpi"><strong>${r.totais.total_comandas > 0 ? fmtMoeda(r.totais.receita_total / r.totais.total_comandas) : fmtMoeda(0)}</strong><span>Ticket médio</span></div>
    <div class="rel-vendas-kpi"><strong>${dataFmt(r.inicio)} — ${dataFmt(r.fim)}</strong><span>Período</span></div>
  `;

  renderRelatorioVendas();
}

// Filtra a lista de produtos do relatório pelo texto digitado (ignora acento/maiúscula)
// e mostra um total somado só dos itens filtrados — útil pra "quantos almoços vendemos".
function renderRelatorioVendas() {
  const r = _relVendasDados;
  if (!r) return;
  const termoBruto = (document.getElementById('rel-vendas-busca')?.value || '').trim();
  const norm = txt => txt.toString().normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
  const termo = norm(termoBruto);
  const produtos = termo ? r.produtos.filter(p => norm(p.produto).includes(termo)) : r.produtos;

  const totalEl = document.getElementById('rel-vendas-filtro-total');
  if (termo) {
    const qtdTotal = produtos.reduce((s, p) => s + parseFloat(p.quantidade), 0);
    const receitaTotal = produtos.reduce((s, p) => s + parseFloat(p.receita), 0);
    totalEl.classList.remove('hidden');
    totalEl.innerHTML = `Filtrando por "<strong>${termoBruto}</strong>": <strong>${fmtQtd(qtdTotal)}</strong> unidades vendidas · <strong>${fmtMoeda(receitaTotal)}</strong> de receita (${produtos.length} produto${produtos.length === 1 ? '' : 's'})`;
  } else {
    totalEl.classList.add('hidden');
    totalEl.innerHTML = '';
  }

  document.getElementById('rel-vendas-lista').innerHTML = produtos.length
    ? `
      <div style="display:flex;padding:10px 16px;border-bottom:2px solid var(--slate-200);font-size:11.5px;font-weight:700;color:var(--slate-500);text-transform:uppercase;">
        <span style="flex:1;">Produto</span>
        <span style="min-width:90px;text-align:right;">Qtd. vendida</span>
        <span style="min-width:110px;text-align:right;">Receita</span>
      </div>
      ${produtos.map((p, i) => `
        <div class="saida-item${i % 2 === 0 ? ' saida-item-zebra' : ''}">
          <div style="flex:1;min-width:0;">
            <div class="saida-item-nome">${!termo && i < 3 ? ['🥇','🥈','🥉'][i] + ' ' : ''}${p.produto}</div>
            <div class="saida-item-sub">${p.comandas} comanda${p.comandas === 1 ? '' : 's'}</div>
          </div>
          <div style="min-width:90px;text-align:right;font-weight:600;color:var(--slate-700);">${fmtQtd(p.quantidade)} ${p.unidade}</div>
          <div style="min-width:110px;text-align:right;font-weight:700;color:var(--orange);">${fmtMoeda(p.receita)}</div>
        </div>
      `).join('')}
    `
    : `<div class="cmd-vazio" style="padding:24px;">${termo ? 'Nenhum produto encontrado com esse filtro.' : 'Nenhuma venda nesse período.'}</div>`;
}

function imprimirRelatorioVendas() {
  const r = _relVendasDados;
  if (!r) return;
  const nomePadaria = document.getElementById('sidebar-nome')?.textContent || 'PanificaPro';
  const dataFmt = d => new Date(d + 'T00:00:00').toLocaleDateString('pt-BR');

  // Respeita o filtro digitado na tela — imprime só o que está sendo visto ali.
  const termoBruto = (document.getElementById('rel-vendas-busca')?.value || '').trim();
  const norm = txt => txt.toString().normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
  const termo = norm(termoBruto);
  const produtos = termo ? r.produtos.filter(p => norm(p.produto).includes(termo)) : r.produtos;

  const linhas = produtos.map((p, i) => `
    <tr>
      <td>${i + 1}</td>
      <td>${p.produto}</td>
      <td style="text-align:right;">${fmtQtd(p.quantidade)} ${p.unidade}</td>
      <td style="text-align:right;">${fmtMoeda(p.receita)}</td>
    </tr>
  `).join('');

  const qtdFiltrada = produtos.reduce((s, p) => s + parseFloat(p.quantidade), 0);
  const receitaFiltrada = produtos.reduce((s, p) => s + parseFloat(p.receita), 0);

  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Vendas</title>
    <style>
      @page { size: A4; margin: 15mm; }
      body { font-family: Arial, sans-serif; color: #000; }
      h1 { font-size: 22px; margin: 0 0 4px; }
      .sub { color: #555; font-size: 13px; margin-bottom: 16px; }
      table { width: 100%; border-collapse: collapse; }
      th { text-align: left; font-size: 11px; text-transform: uppercase; color: #555; border-bottom: 2px solid #000; padding: 6px 8px; }
      td { padding: 6px 8px; border-bottom: 1px solid #ddd; font-size: 13px; }
      .resumo { display: flex; gap: 24px; margin: 16px 0 20px; }
      .resumo div { font-size: 13px; }
      .resumo strong { display: block; font-size: 18px; }
      .filtro-aviso { background: #fff4e6; border: 1px solid #f9a962; padding: 8px 12px; border-radius: 6px; font-size: 13px; margin-bottom: 16px; }
    </style></head><body>
    <h1>📊 Vendas por produto — ${nomePadaria}</h1>
    <div class="sub">Período: ${dataFmt(r.inicio)} a ${dataFmt(r.fim)} · Impresso em ${new Date().toLocaleString('pt-BR')}</div>
    ${termo ? `<div class="filtro-aviso">Filtrado por "<strong>${termoBruto}</strong>": ${fmtQtd(qtdFiltrada)} unidades · ${fmtMoeda(receitaFiltrada)} de receita (${produtos.length} produto${produtos.length === 1 ? '' : 's'})</div>` : ''}
    <div class="resumo">
      <div><strong>${fmtMoeda(termo ? receitaFiltrada : r.totais.receita_total)}</strong>${termo ? 'Receita filtrada' : 'Receita total'}</div>
      <div><strong>${r.totais.total_comandas}</strong>Comandas fechadas</div>
    </div>
    <table>
      <thead><tr><th>#</th><th>Produto</th><th style="text-align:right;">Qtd.</th><th style="text-align:right;">Receita</th></tr></thead>
      <tbody>${linhas || `<tr><td colspan="4">${termo ? 'Nenhum produto encontrado com esse filtro.' : 'Nenhuma venda nesse período.'}</td></tr>`}</tbody>
    </table>
    <script>window.onload=()=>{window.print();window.onafterprint=()=>window.close();};<\/script>
    </body></html>`;
  const w = window.open('', '_blank');
  w.document.write(html);
  w.document.close();
}

function abrirModalNovaEncomenda() {
  document.getElementById('enc-modal-titulo').textContent = '📋 Nova encomenda';
  document.getElementById('enc-id').value = '';
  document.getElementById('enc-cliente-nome').value = '';
  document.getElementById('enc-cliente-telefone').value = '';
  document.getElementById('enc-descricao').value = '';
  document.getElementById('enc-data-entrega').value = new Date().toISOString().slice(0, 10);
  document.getElementById('enc-hora-entrega').value = '';
  document.getElementById('enc-valor').value = '';
  document.getElementById('enc-sinal').value = '';
  document.getElementById('enc-observacao').value = '';
  document.getElementById('enc-acoes-extra')?.remove();
  document.getElementById('modal-encomenda').classList.remove('hidden');
  setTimeout(() => document.getElementById('enc-cliente-nome').focus(), 100);
}

function fecharModalEncomenda() {
  document.getElementById('modal-encomenda').classList.add('hidden');
}

async function salvarEncomenda() {
  const id = document.getElementById('enc-id').value;
  const cliente_nome = document.getElementById('enc-cliente-nome').value.trim();
  const descricao = document.getElementById('enc-descricao').value.trim();
  const data_entrega = document.getElementById('enc-data-entrega').value;
  if (!cliente_nome) { mostrarToast('Informe o nome do cliente.', 'warn'); return; }
  if (!descricao) { mostrarToast('Descreva o que foi encomendado.', 'warn'); return; }
  if (!data_entrega) { mostrarToast('Informe a data de entrega.', 'warn'); return; }

  const body = {
    cliente_nome,
    cliente_telefone: document.getElementById('enc-cliente-telefone').value.trim(),
    descricao,
    data_entrega,
    hora_entrega: document.getElementById('enc-hora-entrega').value || null,
    valor: document.getElementById('enc-valor').value || 0,
    sinal_pago: document.getElementById('enc-sinal').value || 0,
    observacao: document.getElementById('enc-observacao').value.trim(),
  };

  const r = id
    ? await api(`/encomendas/${id}`, { method: 'PUT', body })
    : await api('/encomendas', { method: 'POST', body });
  if (!r) return;
  mostrarToast(id ? 'Encomenda atualizada!' : 'Encomenda cadastrada!', 'ok');
  fecharModalEncomenda();
  await carregarEncomendas();
}

let encomendaDetalheAtual = null;

async function abrirModalDetalheEncomenda(id) {
  const e = await api(`/encomendas/${id}`);
  if (!e) return;
  encomendaDetalheAtual = e;

  document.getElementById('enc-modal-titulo').textContent = `📋 ${e.cliente_nome}`;
  document.getElementById('enc-id').value = e.id;
  document.getElementById('enc-cliente-nome').value = e.cliente_nome;
  document.getElementById('enc-cliente-telefone').value = e.cliente_telefone || '';
  document.getElementById('enc-descricao').value = e.descricao;
  document.getElementById('enc-data-entrega').value = String(e.data_entrega).slice(0, 10);
  document.getElementById('enc-hora-entrega').value = e.hora_entrega ? e.hora_entrega.slice(0, 5) : '';
  document.getElementById('enc-valor').value = parseFloat(e.valor) || '';
  document.getElementById('enc-sinal').value = parseFloat(e.sinal_pago) || '';
  document.getElementById('enc-observacao').value = e.observacao || '';

  const modalBox = document.querySelector('#modal-encomenda .modal-box');
  let acoes = document.getElementById('enc-acoes-extra');
  if (!acoes) {
    acoes = document.createElement('div');
    acoes.id = 'enc-acoes-extra';
    acoes.style.cssText = 'display:flex;gap:8px;margin-top:10px;flex-wrap:wrap;';
    modalBox.appendChild(acoes);
  }
  const proximo = ENC_PROXIMO_STATUS[e.status];
  acoes.innerHTML = `
    ${proximo ? `<button class="btn-secondary" style="flex:1;min-width:140px;" onclick="mudarStatusEncomendaUI(${e.id}, '${proximo}')">${ENC_PROXIMO_LABEL[e.status]}</button>` : ''}
    <button class="btn-secondary" style="flex:1;min-width:100px;" onclick="imprimirFichaEncomenda(${e.id})">🖨️ Imprimir</button>
    ${e.status !== 'cancelada' && e.status !== 'entregue' ? `<button class="btn-ghost" style="flex:1;min-width:100px;color:#dc2626;" onclick="mudarStatusEncomendaUI(${e.id}, 'cancelada')">Cancelar</button>` : ''}
    <button class="btn-ghost" style="flex:1;min-width:100px;color:#dc2626;" onclick="excluirEncomendaUI(${e.id})">🗑️ Excluir</button>
  `;

  document.getElementById('modal-encomenda').classList.remove('hidden');
}

async function mudarStatusEncomendaUI(id, status) {
  const r = await api(`/encomendas/${id}/status`, { method: 'PATCH', body: { status } });
  if (!r) return;
  mostrarToast(`Status atualizado: ${ENC_STATUS_LABEL[status]}`, 'ok');
  fecharModalEncomenda();
  await carregarEncomendas();
}

async function excluirEncomendaUI(id) {
  if (!confirm('Excluir essa encomenda definitivamente?')) return;
  const r = await api(`/encomendas/${id}`, { method: 'DELETE' });
  if (!r) return;
  mostrarToast('Encomenda excluída.', 'ok');
  fecharModalEncomenda();
  await carregarEncomendas();
}

// Ficha grande pra fixar no mural — não é o recibo de 80mm, é uma folha A4 com letra grande
function imprimirFichaEncomenda(id) {
  const e = encomendaDetalheAtual;
  if (!e || e.id !== id) return;
  const dataFmt = new Date(String(e.data_entrega).slice(0, 10) + 'T00:00:00').toLocaleDateString('pt-BR');
  const horaFmt = e.hora_entrega ? e.hora_entrega.slice(0, 5) : '—';
  const restante = Math.max(0, parseFloat(e.valor || 0) - parseFloat(e.sinal_pago || 0));
  const html = `<!doctype html><html><head><meta charset="utf-8"><title>Encomenda</title>
    <style>
      @page { size: A4; margin: 20mm; }
      body { font-family: Arial, sans-serif; color: #000; }
      h1 { font-size: 28px; text-align: center; margin: 0 0 4px; }
      .sub { text-align: center; font-size: 14px; color: #555; margin-bottom: 24px; }
      .linha { display: flex; justify-content: space-between; border-bottom: 2px solid #000; padding: 10px 0; font-size: 20px; }
      .linha span:first-child { font-weight: bold; }
      .desc-box { border: 3px solid #000; border-radius: 10px; padding: 16px; margin: 20px 0; font-size: 22px; }
      .datahora { text-align: center; font-size: 40px; font-weight: 900; margin: 24px 0; padding: 14px; border: 4px solid #000; border-radius: 12px; }
      .rodape { text-align: center; font-size: 12px; color: #777; margin-top: 30px; }
    </style></head><body>
    <h1>🧾 FICHA DE ENCOMENDA</h1>
    <div class="sub">PanificaPro — impresso em ${new Date().toLocaleString('pt-BR')}</div>
    <div class="linha"><span>Cliente</span><span>${e.cliente_nome}</span></div>
    ${e.cliente_telefone ? `<div class="linha"><span>Telefone</span><span>${e.cliente_telefone}</span></div>` : ''}
    <div class="desc-box">${e.descricao}</div>
    <div class="datahora">📅 ${dataFmt} ${horaFmt !== '—' ? ' — ' + horaFmt : ''}</div>
    <div class="linha"><span>Valor combinado</span><span>${fmtMoeda(e.valor)}</span></div>
    <div class="linha"><span>Sinal pago</span><span>${fmtMoeda(e.sinal_pago)}</span></div>
    <div class="linha"><span>Restante a pagar</span><span>${fmtMoeda(restante)}</span></div>
    ${e.observacao ? `<div class="linha"><span>Observação</span><span>${e.observacao}</span></div>` : ''}
    <div class="rodape">Fixar no mural até a entrega</div>
    <script>window.onload=()=>{window.print();window.onafterprint=()=>window.close();};<\/script>
    </body></html>`;
  const w = window.open('', '_blank');
  w.document.write(html);
  w.document.close();
}

async function salvarFicha() {
  const id = document.getElementById('ficha-id').value;
  const linhas = document.querySelectorAll('.ficha-ingrediente-linha');
  const itens = [];
  for (const linha of linhas) {
    const produto_id = linha.querySelector('.fi-produto-id').value;
    const nome_livre = linha.querySelector('.fi-nome-livre').value;
    const quantidade = parseFloat(linha.querySelector('.fi-qtd').value);
    const unidade = linha.querySelector('.fi-unidade').value;
    if ((produto_id || nome_livre) && quantidade > 0) {
      itens.push({ produto_id: produto_id ? parseInt(produto_id) : null, nome_livre: nome_livre || null, quantidade, unidade });
    }
  }

  const body = {
    nome: document.getElementById('ficha-nome').value.trim(),
    preco_venda: parseMoeda(document.getElementById('ficha-preco').value) || null,
    rendimento: parseFloat(document.getElementById('ficha-rendimento').value) || 1,
    unidade_rendimento: document.getElementById('ficha-unidade-rendimento').value.trim() || 'unidades',
    descricao: document.getElementById('ficha-descricao').value.trim(),
    itens,
  };
  if (!body.nome) return mostrarToast('Informe o nome da receita.', 'err');

  const ok = id
    ? await api(`/fichas/${id}`, { method: 'PUT', body })
    : await api('/fichas', { method: 'POST', body });
  if (!ok) return;

  fecharModalFicha();
  mostrarToast(id ? 'Receita atualizada!' : 'Receita criada!', 'ok');
  carregarFichas();
}

async function editarFicha(id) {
  const ficha = await api(`/fichas/${id}`);
  if (!ficha) return;
  if (!produtosCache.length) {
    const prods = await api('/produtos');
    produtosCache = prods || [];
  }
  await abrirModalFicha(ficha);
}

async function excluirFicha(id) {
  if (!confirm('Excluir esta receita?')) return;
  const ok = await api(`/fichas/${id}`, { method: 'DELETE' });
  if (!ok) return;
  mostrarToast('Receita excluída.', 'info');
  document.getElementById('fichas-detalhe').classList.add('hidden');
  carregarFichas();
}

// ── Helpers de moeda ──────────────────────────────────────────────────────
function parseMoeda(str) {
  if (typeof str === 'number') return str;
  const s = (str || '').trim().replace(/R\$\s*/g, '');
  if (!s) return 0;
  // Formato BR com vírgula decimal: "1.200,50" ou "200.000,00"
  if (s.includes(',')) return parseFloat(s.replace(/\./g, '').replace(',', '.')) || 0;
  // Com ponto mas sem vírgula: distingue milhar BR de decimal
  // "200.000" → milhar (3 dígitos após ponto) → 200000
  // "0.80" ou "1.5" → decimal → valor real
  if (s.includes('.')) {
    const partes = s.split('.');
    const ehMilharBR = partes.length >= 2 && partes.slice(1).every(p => p.length === 3);
    if (ehMilharBR) return parseFloat(s.replace(/\./g, '')) || 0;
    return parseFloat(s) || 0;
  }
  return parseFloat(s) || 0;
}
function formatarMoedaBR(valor) {
  return parseFloat(valor || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}
function mascaraMoeda(input) {
  const v = parseMoeda(input.value);
  input.value = v > 0 ? formatarMoedaBR(v) : '';
}

// ── Precificação ──────────────────────────────────────────────────────────
let precConfig = { faturamento_medio: 0, imposto_pct: 5, perda_pct: 2, lucro_desejado_pct: 10 };
let precDespesas = [];
let precModalidades = [];

async function abrirConfigPrecificacao() {
  const data = await api('/precificacao/config');
  if (!data) return;
  precConfig = data.config || precConfig;
  precDespesas = data.despesas || [];
  precModalidades = data.modalidades || [];

  const fatEl = document.getElementById('prec-faturamento');
  fatEl.value = precConfig.faturamento_medio ? formatarMoedaBR(precConfig.faturamento_medio) : '';
  fatEl.onblur = function() { mascaraMoeda(this); atualizarResumoPrecificacao(); };
  document.getElementById('prec-lucro').value = precConfig.lucro_desejado_pct || 10;
  document.getElementById('prec-imposto').value = precConfig.imposto_pct || 5;
  document.getElementById('prec-perda').value = precConfig.perda_pct || 2;

  renderizarDespesas();
  renderizarModalidades();
  atualizarResumoPrecificacao();

  document.getElementById('modal-precificacao').classList.remove('hidden');
}

function fecharConfigPrecificacao() {
  document.getElementById('modal-precificacao').classList.add('hidden');
}

function renderizarDespesas() {
  const lista = document.getElementById('prec-despesas-lista');
  if (!precDespesas.length) {
    lista.innerHTML = '<div style="color:var(--slate-400);font-size:13px;padding:8px 0;">Nenhuma despesa cadastrada.</div>';
  } else {
    lista.innerHTML = precDespesas.map((d, i) => `
      <div class="prec-linha" style="display:grid;grid-template-columns:1fr auto auto;gap:8px;align-items:center;margin-bottom:6px;">
        <input type="text" class="form-control" value="${d.nome}" onchange="precDespesas[${i}].nome=this.value;atualizarResumoPrecificacao()" placeholder="Nome da despesa">
        <input type="text" class="form-control" value="${d.valor ? formatarMoedaBR(d.valor) : ''}" style="width:150px;" onblur="mascaraMoeda(this);precDespesas[${i}].valor=parseMoeda(this.value);atualizarResumoPrecificacao()" placeholder="R$ 0,00">
        <button class="btn-danger" style="padding:6px 10px;" onclick="precDespesas.splice(${i},1);renderizarDespesas();atualizarResumoPrecificacao()">✕</button>
      </div>`).join('');
  }
  const total = precDespesas.reduce((s, d) => s + (parseFloat(d.valor) || 0), 0);
  const fat = parseMoeda(document.getElementById('prec-faturamento')?.value) || precConfig.faturamento_medio || 0;
  const pct = fat > 0 ? (total / fat * 100).toFixed(1) : '—';
  document.getElementById('prec-despesas-total').innerHTML =
    `<span>Total despesas fixas</span><span style="font-weight:800">R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})} <span style="color:var(--orange);font-size:13px;">(${pct}% do fat.)</span></span>`;
}

function adicionarDespesaFixa() {
  precDespesas.push({ nome: '', valor: 0 });
  renderizarDespesas();
}

function renderizarModalidades() {
  const lista = document.getElementById('prec-modalidades-lista');
  if (!precModalidades.length) {
    lista.innerHTML = '<div style="color:var(--slate-400);font-size:13px;padding:8px 0;">Nenhuma modalidade cadastrada.</div>';
  } else {
    lista.innerHTML = precModalidades.map((m, i) => `
      <div style="display:grid;grid-template-columns:1fr 80px 90px auto;gap:8px;align-items:center;margin-bottom:6px;">
        <input type="text" class="form-control" value="${m.nome}" onchange="precModalidades[${i}].nome=this.value" placeholder="Ex: Crédito">
        <input type="number" class="form-control" value="${m.taxa_pct}" step="0.1" onchange="precModalidades[${i}].taxa_pct=parseFloat(this.value)||0;atualizarResumoPrecificacao()" placeholder="0,0">
        <input type="number" class="form-control" value="${m.participacao_pct}" step="1" onchange="precModalidades[${i}].participacao_pct=parseFloat(this.value)||0;atualizarResumoPrecificacao()" placeholder="0">
        <button class="btn-danger" style="padding:6px 10px;" onclick="precModalidades.splice(${i},1);renderizarModalidades();atualizarResumoPrecificacao()">✕</button>
      </div>`).join('');
  }
  // Taxa ponderada
  const totalPart = precModalidades.reduce((s, m) => s + (parseFloat(m.participacao_pct)||0), 0);
  const taxaPond = totalPart > 0
    ? precModalidades.reduce((s, m) => s + (parseFloat(m.taxa_pct)||0) * (parseFloat(m.participacao_pct)||0), 0) / totalPart
    : 0;
  document.getElementById('prec-modalidades-resultado').innerHTML =
    `<span>Taxa ponderada de venda</span><span style="font-weight:800;color:var(--orange)">${taxaPond.toFixed(2)}%</span>`;
}

function adicionarModalidade() {
  precModalidades.push({ nome: '', taxa_pct: 0, participacao_pct: 0 });
  renderizarModalidades();
}

function atualizarResumoPrecificacao() {
  const fat = parseMoeda(document.getElementById('prec-faturamento')?.value);
  const imposto = parseFloat(document.getElementById('prec-imposto')?.value) || 0;
  const perda = parseFloat(document.getElementById('prec-perda')?.value) || 0;
  const lucro = parseFloat(document.getElementById('prec-lucro')?.value) || 0;

  const totalDespesas = precDespesas.reduce((s, d) => s + (parseFloat(d.valor)||0), 0);
  const despesasPct = fat > 0 ? totalDespesas / fat * 100 : 0;

  const totalPart = precModalidades.reduce((s, m) => s + (parseFloat(m.participacao_pct)||0), 0);
  const taxaVenda = totalPart > 0
    ? precModalidades.reduce((s, m) => s + (parseFloat(m.taxa_pct)||0) * (parseFloat(m.participacao_pct)||0), 0) / totalPart
    : 0;

  const totalMkp = imposto + taxaVenda + despesasPct + perda + lucro;
  const cmvMeta = Math.max(0, 100 - totalMkp);

  const resumo = document.getElementById('prec-resumo');
  if (!resumo) return;
  resumo.innerHTML = `
    <div class="prec-resumo-title">📋 Resumo para Formação de Preço</div>
    <div class="prec-resumo-grid">
      <div class="prec-resumo-item"><span>Impostos</span><span>${imposto.toFixed(1)}%</span></div>
      <div class="prec-resumo-item"><span>Despesas de venda (taxa pond.)</span><span>${taxaVenda.toFixed(2)}%</span></div>
      <div class="prec-resumo-item"><span>Despesas fixas</span><span>${despesasPct.toFixed(1)}%</span></div>
      <div class="prec-resumo-item"><span>Perdas</span><span>${perda.toFixed(1)}%</span></div>
      <div class="prec-resumo-item"><span>Lucro desejado</span><span>${lucro.toFixed(1)}%</span></div>
      <div class="prec-resumo-item total"><span>TOTAL MARKUP</span><span>${totalMkp.toFixed(1)}%</span></div>
      <div class="prec-resumo-item cmv"><span>CMV Meta (ingredientes)</span><span>${cmvMeta.toFixed(1)}%</span></div>
    </div>
    <div class="prec-formula">
      💡 Preço Sugerido = Custo ingredientes ÷ ${(cmvMeta/100).toFixed(4)} &nbsp;|&nbsp; ou × ${cmvMeta > 0 ? (1/(cmvMeta/100)).toFixed(2) : '∞'}
    </div>
  `;
  // Atualiza renderização das despesas (para recalcular % com faturamento novo)
  const listaEl = document.getElementById('prec-despesas-lista');
  if (listaEl && listaEl.children.length) renderizarDespesas();
}

async function salvarConfigPrecificacao() {
  const fat = parseMoeda(document.getElementById('prec-faturamento').value);
  const imposto = parseFloat(document.getElementById('prec-imposto').value) || 5;
  const perda = parseFloat(document.getElementById('prec-perda').value) || 2;
  const lucro = parseFloat(document.getElementById('prec-lucro').value) || 10;

  const [r1, r2, r3] = await Promise.all([
    api('/precificacao/config', { method: 'PUT', body: { faturamento_medio: fat, imposto_pct: imposto, perda_pct: perda, lucro_desejado_pct: lucro } }),
    api('/precificacao/despesas', { method: 'PUT', body: { despesas: precDespesas } }),
    api('/precificacao/modalidades', { method: 'PUT', body: { modalidades: precModalidades } }),
  ]);

  if (r1 && r2 && r3) {
    mostrarToast('✅ Configuração salva! Agora suas fichas técnicas vão sugerir preço automaticamente com base nesses números.', 'ok');
    fecharConfigPrecificacao();
    // Recarregar fichas para atualizar preços sugeridos
    carregarFichas();
  }
}

// Calcula preço sugerido para uma ficha com base na config atual
function calcularPrecoSugerido(custoTotal, rendimento) {
  if (!precConfig || !precConfig.faturamento_medio) return null;
  const fat = precConfig.faturamento_medio || 0;
  const imposto = precConfig.imposto_pct || 0;
  const perda = precConfig.perda_pct || 0;
  const lucro = precConfig.lucro_desejado_pct || 0;
  const totalDespesas = precDespesas.reduce((s, d) => s + (parseFloat(d.valor)||0), 0);
  const despesasPct = fat > 0 ? totalDespesas / fat * 100 : 0;
  const totalPart = precModalidades.reduce((s, m) => s + (parseFloat(m.participacao_pct)||0), 0);
  const taxaVenda = totalPart > 0
    ? precModalidades.reduce((s, m) => s + (parseFloat(m.taxa_pct)||0) * (parseFloat(m.participacao_pct)||0), 0) / totalPart
    : 0;
  const totalMkp = (imposto + taxaVenda + despesasPct + perda + lucro) / 100;
  if (totalMkp >= 1) return null;
  const custoUnid = custoTotal / (rendimento || 1);
  return custoUnid / (1 - totalMkp);
}

// ── Controle de Produção ──────────────────────────────────────────────────
let fichasCacheProducao = [];

function dispensarAvisoProducao() {
  localStorage.setItem('pp_aviso_producao_visto', '1');
  document.getElementById('aviso-producao')?.classList.add('hidden');
}

async function carregarProducao() {
  const avisoEl = document.getElementById('aviso-producao');
  if (avisoEl) avisoEl.classList.toggle('hidden', localStorage.getItem('pp_aviso_producao_visto') === '1');
  const _btn = document.getElementById('btn-nova-producao');
  if (ROLE_ATUAL !== 'admin' && !['premium'].includes(PLANO_ATUAL)) {
    const lista = document.getElementById('prod-lista');
    if (_btn) _btn.style.display = 'none';
    if (lista) lista.innerHTML = `
      <div class="fichas-lock">
        <div class="fichas-lock-icon">🔒</div>
        <h3>Controle de Produção — Plano Premium</h3>
        <p>Registre produções diárias e baixe o estoque automaticamente pelas fichas técnicas.<br>
           Disponível no plano <strong>Premium</strong>.</p>
        <p style="color:var(--slate-400);font-size:13px;">Seu plano atual: <strong>${{ trial: 'Trial', essencial: 'Essencial', pro: 'Pro' }[PLANO_ATUAL] || PLANO_ATUAL}</strong></p>
        <button onclick="mostrarPagina('planos')" class="btn-primary" style="margin-top:8px;padding:10px 28px;border-radius:10px;border:none;cursor:pointer;font-size:15px;font-weight:600;">Ver planos →</button>
      </div>`;
    return;
  }
  if (_btn) _btn.style.display = '';

  const [producoes, fichas] = await Promise.all([
    api('/producao'),
    api('/fichas')
  ]);
  if (!producoes) return;
  fichasCacheProducao = fichas || [];

  // KPIs
  const hoje = new Date().toISOString().slice(0, 10);
  const prodHoje = producoes.filter(p => p.data && p.data.slice(0, 10) === hoje);
  document.getElementById('prod-kpi-hoje').textContent = prodHoje.length;
  document.getElementById('prod-kpi-receitas').textContent = prodHoje.reduce((a, p) => a + (p.total_itens || 0), 0);
  document.getElementById('prod-kpi-total').textContent = producoes.length;

  // Lista
  const lista = document.getElementById('prod-lista');
  if (!producoes.length) {
    lista.innerHTML = '<p style="color:var(--slate-400);text-align:center;padding:40px;">Nenhuma produção registrada ainda.</p>';
    return;
  }

  // Agrupar por data
  const grupos = {};
  producoes.forEach(p => {
    const d = p.data ? p.data.slice(0, 10) : '—';
    if (!grupos[d]) grupos[d] = [];
    grupos[d].push(p);
  });

  lista.innerHTML = Object.entries(grupos).map(([data, prods]) => `
    <div class="prod-grupo">
      <div class="prod-grupo-header">${formatarDataBR(data)}</div>
      ${prods.map(p => `
        <div class="prod-card">
          <div class="prod-card-info">
            <span class="prod-card-icon">🏭</span>
            <div>
              <div class="prod-card-titulo">${p.total_itens} receita(s) produzida(s)</div>
              ${p.observacao ? `<div class="prod-card-obs">${p.observacao}</div>` : ''}
            </div>
          </div>
          <div class="prod-card-actions">
            ${data === hoje ? `<button class="btn-danger-sm" onclick="cancelarProducao(${p.id})">Cancelar</button>` : ''}
          </div>
        </div>
      `).join('')}
    </div>
  `).join('');
}

function formatarDataBR(dataStr) {
  if (!dataStr || dataStr === '—') return '—';
  const [y, m, d] = dataStr.split('-');
  return `${d}/${m}/${y}`;
}

function abrirModalProducao() {
  const hoje = new Date().toISOString().slice(0, 10);
  document.getElementById('prod-data').value = hoje;
  document.getElementById('prod-obs').value = '';
  document.getElementById('prod-itens-lista').innerHTML = '';
  adicionarLinhaProducao();
  document.getElementById('modal-producao').classList.remove('hidden');
}

function fecharModalProducao() {
  document.getElementById('modal-producao').classList.add('hidden');
}

function adicionarLinhaProducao() {
  const container = document.getElementById('prod-itens-lista');
  const opts = fichasCacheProducao.map(f => `<option value="${f.id}">${f.nome}</option>`).join('');
  const div = document.createElement('div');
  div.className = 'prod-item-linha';
  div.innerHTML = `
    <select class="form-control prod-ficha-sel">
      <option value="">Selecione a receita...</option>
      ${opts}
    </select>
    <input type="number" class="form-control prod-qtd" placeholder="Qtd" min="0.1" step="0.1" value="1" style="text-align:center;">
    <button class="btn-danger-sm" onclick="this.parentElement.remove()" style="width:36px;height:36px;padding:0;display:flex;align-items:center;justify-content:center;border-radius:8px;">✕</button>
  `;
  container.appendChild(div);
}

async function salvarProducao() {
  const data = document.getElementById('prod-data').value;
  const observacao = document.getElementById('prod-obs').value.trim();
  if (!data) return mostrarToast('Informe a data da produção.', 'warn');

  const linhas = document.querySelectorAll('#prod-itens-lista .prod-item-linha');
  const itens = [];
  for (const linha of linhas) {
    const ficha_id = parseInt(linha.querySelector('.prod-ficha-sel').value);
    const quantidade = parseFloat(linha.querySelector('.prod-qtd').value);
    if (!ficha_id) continue;
    if (!quantidade || quantidade <= 0) return mostrarToast('Informe a quantidade de cada receita.', 'warn');
    itens.push({ ficha_id, quantidade });
  }
  if (!itens.length) return mostrarToast('Adicione pelo menos uma receita.', 'warn');

  const r = await api('/producao', { method: 'POST', body: JSON.stringify({ data, observacao, itens }) });
  if (!r) return;
  fecharModalProducao();
  mostrarToast('Produção registrada! Estoque atualizado.', 'ok');
  carregarProducao();
}

async function cancelarProducao(id) {
  if (!confirm('Cancelar esta produção? O estoque será revertido.')) return;
  const r = await api(`/producao/${id}`, { method: 'DELETE' });
  if (!r) return;
  mostrarToast('Produção cancelada e estoque revertido.', 'info');
  carregarProducao();
}
