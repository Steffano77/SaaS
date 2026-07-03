const API = '/api';
let TOKEN = localStorage.getItem('pptoken') || '';
let todosProds = [];

// ── Redefinição de senha via link ───────────────────────────────
(function() {
  const params = new URLSearchParams(window.location.search);
  const resetToken = params.get('token');
  if (resetToken && window.location.pathname.includes('redefinir-senha')) {
    document.getElementById('tela-auth').classList.add('hidden');
    document.getElementById('tela-redefinir').classList.remove('hidden');
    window._resetToken = resetToken;
  }
})();

// ── Dark Mode ──────────────────────────────────────────────────
(function() {
  const saved = localStorage.getItem('pp-theme');
  if (saved === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    _setThemeIcons('dark');
  }
})();

function _setThemeIcons(theme) {
  const ids = ['sun-auth','moon-auth','sun-redef','moon-redef','sun-mobile','moon-mobile','sun-sidebar','moon-sidebar'];
  ids.forEach(id => {
    const el = document.getElementById('icon-' + id);
    if (!el) return;
    const isSun = id.includes('sun');
    el.classList.toggle('hidden', theme === 'dark' ? isSun : !isSun);
  });
}

function togglePass(inputId, btn) {
  const input = document.getElementById(inputId);
  const showing = input.type === 'text';
  input.type = showing ? 'password' : 'text';
  btn.querySelector('.eye-open').classList.toggle('hidden', !showing);
  btn.querySelector('.eye-off').classList.toggle('hidden', showing);
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
  document.getElementById('tabs-auth') && document.querySelector('.tabs-auth').classList.add('hidden');
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
    if (!r.ok) { el.textContent = d.erro; el.classList.remove('hidden'); return; }
    TOKEN = d.token;
    localStorage.setItem('pptoken', TOKEN);
    document.getElementById('sidebar-nome').textContent = d.padaria.nome;
    entrar();
  } catch { el.textContent = 'Erro de conexão.'; el.classList.remove('hidden'); }
}

async function fazerRegistro(e) {
  e.preventDefault();
  const el = document.getElementById('erro-registro');
  el.classList.add('hidden');
  try {
    const r = await fetch(`${API}/auth/registrar`, {
      method: 'POST', headers: {'Content-Type':'application/json'},
      body: JSON.stringify({ nome: document.getElementById('reg-nome').value, email: document.getElementById('reg-email').value, senha: document.getElementById('reg-senha').value })
    });
    const d = await r.json();
    if (!r.ok) { el.textContent = d.erro; el.classList.remove('hidden'); return; }
    TOKEN = d.token;
    localStorage.setItem('pptoken', TOKEN);
    document.getElementById('sidebar-nome').textContent = d.padaria.nome;
    entrar();
  } catch { el.textContent = 'Erro de conexão.'; el.classList.remove('hidden'); }
}

function entrar() {
  document.getElementById('tela-auth').classList.add('hidden');
  document.getElementById('app').classList.remove('hidden');
  document.getElementById('app').classList.add('flex');
  history.replaceState({ pg: 'dashboard' }, '', '#dashboard');
  mostrarPagina('dashboard', false);
}

function sair() {
  TOKEN = '';
  localStorage.removeItem('pptoken');
  location.reload();
}

// ── Navegação ───────────────────────────────────────────────
const paginas = ['dashboard','estoque','compras','fornecedores','relatorios','sync'];
function mostrarPagina(pg, pushHistory = true) {
  paginas.forEach(p => {
    document.getElementById(`pg-${p}`).classList.toggle('hidden', p !== pg);
  });
  document.querySelectorAll('.sidebar-link').forEach((el, i) => {
    el.classList.toggle('active', paginas[i] === pg);
  });
  if (pushHistory) history.pushState({ pg }, '', `#${pg}`);
  if (pg === 'dashboard')      carregarDashboard();
  if (pg === 'estoque')        { carregarCategorias(); carregarProdutos(); }
  if (pg === 'compras')        { carregarCompras(); }
  if (pg === 'fornecedores')   { carregarFornecedores(); }
  if (pg === 'relatorios')     { carregarRelatorios(); }
}

window.addEventListener('popstate', () => {
  const visivel = paginas.find(p => !document.getElementById(`pg-${p}`).classList.contains('hidden'));
  if (visivel === 'dashboard' && TOKEN) {
    history.pushState({ pg: 'dashboard' }, '', '#dashboard');
    document.getElementById('modal-sair').classList.remove('hidden');
  } else {
    mostrarPagina('dashboard', false);
  }
});

function confirmarSaida() {
  document.getElementById('modal-sair').classList.add('hidden');
  history.back();
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
    toast.style.cssText = 'position:fixed;bottom:24px;left:50%;transform:translateX(-50%);z-index:9999;padding:12px 20px;border-radius:10px;font-size:14px;font-weight:600;font-family:Inter,sans-serif;box-shadow:0 4px 16px rgba(0,0,0,0.18);transition:opacity 0.3s;pointer-events:none;';
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

// ── API helpers ──────────────────────────────────────────────
// B) 401 -> remove token + reload; C) network error -> toast
async function api(path, opts = {}) {
  opts.headers = { ...opts.headers, 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' };
  if (opts.body && typeof opts.body === 'object' && !(opts.body instanceof FormData)) {
    opts.body = JSON.stringify(opts.body);
  }
  if (opts.body instanceof FormData) delete opts.headers['Content-Type'];
  try {
    const r = await fetch(`${API}${path}`, opts);
    if (r.status === 401) {
      localStorage.removeItem('panificapro_token');
      localStorage.removeItem('pptoken');
      location.reload();
      return null;
    }
    return r.json();
  } catch (err) {
    mostrarToast('Sem conexão. Verifique sua internet.', 'err');
    return null;
  }
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
    <div class="kpi-card"><div class="kpi-value" style="color:var(--orange);font-size:22px">${'R$ ' + parseFloat(k.valor_total_estoque||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div><div class="kpi-label">Valor em estoque</div></div>
  `;
  document.getElementById('lista-repor').innerHTML = d.repor.length
    ? d.repor.map(p => `
        <div class="repor-item">
          <div><div class="repor-item-name">${p.nome}</div>
          <div class="repor-item-sub">Falta: <b>${fmtQtd(p.falta)} ${p.unidade}</b></div></div>
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

  try {
    const movData = await api('/relatorios/movs-semana');
    const ctxM = document.getElementById('chart-movs')?.getContext('2d');
    if (ctxM && movData) {
      if (window._chartMovs) window._chartMovs.destroy();
      window._chartMovs = new Chart(ctxM, {
        type: 'bar',
        data: {
          labels: movData.map(r => r.dia),
          datasets: [
            { label: 'Entradas', data: movData.map(r => r.entradas), backgroundColor: '#22c55e', borderRadius: 6 },
            { label: 'Saídas',   data: movData.map(r => r.saidas),   backgroundColor: '#f97316', borderRadius: 6 }
          ]
        },
        options: { responsive: true, plugins: { legend: { position: 'bottom' } }, scales: { y: { beginAtZero: true } } }
      });
    }
  } catch(e) {}

  try {
    const catData = await api('/relatorios/valor-categorias');
    const ctxC = document.getElementById('chart-cats')?.getContext('2d');
    if (ctxC && catData && catData.length) {
      if (window._chartCats) window._chartCats.destroy();
      window._chartCats = new Chart(ctxC, {
        type: 'doughnut',
        data: {
          labels: catData.map(r => r.categoria || 'Sem categoria'),
          datasets: [{ data: catData.map(r => parseFloat(r.valor)), backgroundColor: ['#1e3a5f','#f97316','#22c55e','#3b82f6','#a855f7','#ec4899','#eab308','#64748b'] }]
        },
        options: { responsive: true, plugins: { legend: { position: 'bottom' } } }
      });
    }
  } catch(e) {}
}

async function abrirModalEstoque(tipo) {
  const prods = await api(`/produtos?alerta=${tipo}`) || [];
  const titulo = tipo === 'zerado' ? '🔴 Produtos sem estoque' : '⚠️ Produtos abaixo do mínimo';

  document.getElementById('modal-estoque-titulo').textContent = titulo;
  document.getElementById('modal-estoque-lista').innerHTML = prods.length
    ? `<table style="width:100%;border-collapse:collapse;font-size:14px;">
        <thead>
          <tr style="border-bottom:2px solid var(--slate-200);">
            <th style="text-align:left;padding:8px 10px;color:var(--slate-500);font-weight:600;">Produto</th>
            <th style="text-align:right;padding:8px 10px;color:var(--slate-500);font-weight:600;">Atual</th>
            <th style="text-align:right;padding:8px 10px;color:var(--slate-500);font-weight:600;">Mínimo</th>
            <th style="text-align:right;padding:8px 10px;color:var(--slate-500);font-weight:600;">Falta</th>
          </tr>
        </thead>
        <tbody>
          ${prods.map(p => {
            const falta = Math.max(0, (p.estoque_minimo || 0) - (p.estoque_atual || 0));
            return `<tr style="border-bottom:1px solid var(--slate-100);">
              <td style="padding:10px 10px;">${p.nome}</td>
              <td style="text-align:right;padding:10px;color:${p.estoque_atual <= 0 ? 'var(--red-500)' : 'var(--yellow-500)'};font-weight:600;">${fmtQtd(p.estoque_atual)} ${p.unidade}</td>
              <td style="text-align:right;padding:10px;color:var(--slate-400);">${fmtQtd(p.estoque_minimo || 0)} ${p.unidade}</td>
              <td style="text-align:right;padding:10px;font-weight:700;color:var(--navy);">${fmtQtd(falta)} ${p.unidade}</td>
            </tr>`;
          }).join('')}
        </tbody>
      </table>`
    : `<p style="text-align:center;padding:24px;color:var(--slate-400);">✅ Nenhum produto nesta situação!</p>`;

  document.getElementById('modal-estoque').classList.remove('hidden');
}

function fecharModalEstoque() {
  document.getElementById('modal-estoque').classList.add('hidden');
}

function irParaCompras() {
  fecharModalEstoque();
  navegarPara('compras');
}

// ── Produtos ─────────────────────────────────────────────────
async function carregarProdutos() {
  const busca  = document.getElementById('busca-produto').value;
  const alerta = document.getElementById('filtro-alerta').value;
  let url = '/produtos?';
  if (busca)  url += `busca=${encodeURIComponent(busca)}&`;
  if (alerta) url += `alerta=${alerta}`;
  const prods = await api(url);
  todosProds = prods || [];
  const tbody = document.getElementById('tabela-produtos');
  // F) col-hide-mobile and col-hide-mobile classes for mobile hiding
  tbody.innerHTML = todosProds.map(p => {
    const status = statusBadge(p);
    const validade = p.validade ? new Date(p.validade).toLocaleDateString('pt-BR') : '—';
    const valorTotal = (p.estoque_atual * p.custo_unitario).toLocaleString('pt-BR',{style:'currency',currency:'BRL'});
    return `<tr>
      <td><div class="td-main">${p.nome}</div><div class="td-sub">${p.codigo_barras || '—'}</div></td>
      <td style="color:var(--slate-600)">${p.categoria || '—'}</td>
      <td class="right td-mono">${fmtQtd(p.estoque_atual)} ${p.unidade}</td>
      <td class="right td-mono" style="color:var(--slate-500)">${fmtQtd(p.estoque_minimo)}</td>
      <td class="right col-hide-mobile">${parseFloat(p.custo_unitario).toLocaleString('pt-BR',{style:'currency',currency:'BRL'})}</td>
      <td class="right" style="font-weight:600">${valorTotal}</td>
      <td class="center col-hide-mobile" style="${p.validade ? 'color:var(--orange-600);font-weight:600' : 'color:var(--slate-400)'}">${validade}</td>
      <td class="center">${status}</td>
      <td class="right" style="white-space:nowrap;">
        <button onclick="movRapido(${p.id},'entrada')" class="btn-icon" title="Entrada" style="color:#16a34a;font-size:16px;">➕</button>
        <button onclick="movRapido(${p.id},'saida')" class="btn-icon" title="Saída" style="color:#dc2626;font-size:16px;">➖</button>
        <button onclick="editarProduto(${p.id})" class="btn-icon">✏️</button>
        <button onclick="excluirProduto(this,${p.id},'${p.nome.replace(/'/g,"\\'")}')" class="btn-icon" title="Excluir" style="color:#dc2626;">🗑️</button>
      </td>
    </tr>`;
  }).join('') || '<tr class="empty-row"><td colspan="9">Nenhum produto encontrado</td></tr>';
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
          <div class="repor-item-sub">Atual: ${fmtQtd(p.estoque_atual)} ${p.unidade} · Falta: <b>${fmtQtd(falta)} ${p.unidade}</b></div>
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
      const itensTexto = p.itens.map(i => `${i.produto} (${fmtQtd(i.quantidade)} ${i.unidade})`).join(', ');
      return `<div class="pedido-pendente-card">
        <div class="pedido-pendente-info">
          <div class="pedido-pendente-header">
            <span class="pedido-pendente-forn">${p.fornecedor || 'Sem fornecedor'}</span>
            <span class="pedido-pendente-data">${dataPedido}</span>
          </div>
          <div class="pedido-pendente-itens">${itensTexto}</div>
          ${p.total > 0 ? `<div class="pedido-pendente-total">Total: R$ ${parseFloat(p.total).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div>` : ''}
        </div>
        <div class="pedido-pendente-acoes">
          <button class="btn-editar-pedido" onclick="reabrirPedido(${p.id})">✏️ Editar</button>
          <button class="btn-receber" onclick="confirmarRecebimentoPedido(${p.id})">✅ Recebi</button>
          <button class="btn-cancelar-pedido" onclick="cancelarPedido(${p.id})">✕</button>
        </div>
      </div>`;
    }).join('');
  } else {
    secPend.classList.add('hidden');
  }

  // Histórico de compras recebidas
  const recentes = await api('/compras/recentes') || [];
  const tbody = document.getElementById('tabela-compras-recentes');
  tbody.innerHTML = recentes.length
    ? recentes.map(c => `<tr>
        <td class="td-main">${c.produtos}</td>
        <td style="color:var(--slate-600);font-size:13px;">${c.fornecedor || '—'}</td>
        <td class="right" style="font-weight:600;">R$ ${parseFloat(c.total||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</td>
        <td>${c.data ? new Date(c.data).toLocaleDateString('pt-BR') : '—'}</td>
      </tr>`).join('')
    : '<tr class="empty-row"><td colspan="4">Nenhuma compra recebida nos últimos 30 dias</td></tr>';
}

let _produtosCache = [];
let _pedidoItens = [];

function filtrarProdutosCompra() {
  const termo = document.getElementById('compra-prod-texto').value.trim().toLowerCase();
  const lista = document.getElementById('compra-prod-lista');
  if (!termo) { lista.classList.add('hidden'); document.getElementById('compra-produto').value = ''; document.getElementById('novo-prod-inline').classList.add('hidden'); return; }
  const filtrados = _produtosCache.filter(p => p.nome.toLowerCase().includes(termo));
  const itens = filtrados.slice(0, 8).map(p =>
    `<div onclick="selecionarProdutoCompra(${p.id},'${p.nome.replace(/'/g,"\\'")}','${p.unidade}')"
      style="padding:10px 14px;cursor:pointer;font-size:14px;border-bottom:1px solid var(--slate-100);"
      onmouseover="this.style.background='var(--slate-50)'" onmouseout="this.style.background=''">${p.nome} <span style="color:var(--slate-400);font-size:12px;">${p.unidade}</span></div>`
  );
  const jaExiste = _produtosCache.some(p => p.nome.toLowerCase() === termo);
  if (!jaExiste) {
    itens.push(`<div onclick="selecionarNovoProdutoCompra('${document.getElementById('compra-prod-texto').value.trim().replace(/'/g,"\\'")}')"
      style="padding:10px 14px;cursor:pointer;font-size:14px;color:var(--orange);font-weight:600;border-top:1px solid var(--slate-100);"
      onmouseover="this.style.background='#fff7ed'" onmouseout="this.style.background=''">➕ Criar novo: "${document.getElementById('compra-prod-texto').value.trim()}"</div>`);
  }
  lista.innerHTML = itens.join('') || `<div style="padding:10px 14px;color:var(--slate-400);font-size:13px;">Nenhum produto encontrado</div>`;
  lista.classList.remove('hidden');
}

function selecionarProdutoCompra(id, nome, unidade) {
  document.getElementById('compra-prod-texto').value = nome;
  document.getElementById('compra-produto').value = id;
  document.getElementById('compra-prod-lista').classList.add('hidden');
  document.getElementById('novo-prod-inline').classList.add('hidden');
}

function selecionarNovoProdutoCompra(nome) {
  document.getElementById('compra-prod-texto').value = nome;
  document.getElementById('compra-produto').value = '__novo__';
  document.getElementById('compra-prod-lista').classList.add('hidden');
  document.getElementById('novo-prod-inline').classList.remove('hidden');
}

function adicionarItemPedido() {
  let prodId     = document.getElementById('compra-produto').value;
  const nome     = document.getElementById('compra-prod-texto').value.trim();
  const qtd      = parseFloat(document.getElementById('compra-qtd').value);
  const custo    = parseFloat(document.getElementById('compra-custo').value || 0);
  if (!prodId) prodId = '__novo__';
  const isNovo   = prodId === '__novo__';
  const unidade  = isNovo ? (document.getElementById('novo-prod-unidade').value || 'un') : (_produtosCache.find(p=>p.id==prodId)?.unidade || 'un');
  const minimo   = isNovo ? parseFloat(document.getElementById('novo-prod-minimo').value || 0) : 0;

  if (!nome) { mostrarMsgCompra('⚠️ Selecione ou informe um produto.', 'err'); return; }
  if (!qtd || qtd <= 0) { mostrarMsgCompra('⚠️ Informe a quantidade.', 'err'); return; }

  _pedidoItens.push({ prodId, nome, unidade, qtd, custo, isNovo, minimo, id: Date.now() });
  renderizarPedido();

  document.getElementById('compra-prod-texto').value = '';
  document.getElementById('compra-produto').value = '';
  document.getElementById('compra-qtd').value = '';
  document.getElementById('compra-custo').value = '';
  document.getElementById('novo-prod-inline').classList.add('hidden');
  document.getElementById('compra-prod-texto').focus();
}

function removerItemPedido(id) {
  _pedidoItens = _pedidoItens.filter(i => i.id !== id);
  renderizarPedido();
}

function renderizarPedido() {
  const wrap = document.getElementById('pedido-itens-wrap');
  if (!_pedidoItens.length) { wrap.classList.add('hidden'); return; }
  wrap.classList.remove('hidden');
  const total = _pedidoItens.reduce((s, i) => s + i.qtd * i.custo, 0);
  document.getElementById('pedido-total').textContent = `Total: R$ ${total.toLocaleString('pt-BR',{minimumFractionDigits:2})}`;
  document.getElementById('pedido-itens-lista').innerHTML = _pedidoItens.map(i => `
    <div style="display:flex;align-items:center;gap:8px;padding:10px 14px;border-bottom:1px solid var(--slate-100);font-size:14px;">
      <div style="flex:1;">
        <span style="font-weight:600;">${i.nome}</span>
        ${i.isNovo ? '<span style="font-size:11px;background:#fff7ed;color:var(--orange);padding:2px 6px;border-radius:4px;margin-left:4px;">novo</span>' : ''}
        <span style="color:var(--slate-500);margin-left:6px;">${parseFloat(i.qtd).toLocaleString('pt-BR')} ${i.unidade}</span>
        ${i.custo > 0 ? `<span style="color:var(--slate-400);margin-left:6px;">R$ ${i.custo.toFixed(2)}/un · <b>R$ ${(i.qtd*i.custo).toFixed(2)}</b></span>` : ''}
      </div>
      <button onclick="removerItemPedido(${i.id})" class="btn-icon" style="color:#dc2626;flex-shrink:0;">🗑️</button>
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
            style="width:80px;padding:4px 8px;border:1.5px solid var(--slate-200);border-radius:6px;font-size:13px;"
            onchange="_pedidoItens.find(x=>x.id==${i.id}).qtd=parseFloat(this.value)||0;renderizarFinalItens()"/>
          ${i.isNovo
            ? `<select style="padding:4px 8px;border:1.5px solid var(--orange);border-radius:6px;font-size:13px;color:var(--orange);font-weight:600;"
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

  const msgEl = document.getElementById('final-msg');
  msgEl.style.cssText = 'font-size:13px;padding:8px 12px;border-radius:8px;background:#f0fdf4;color:#166534;border:1px solid #bbf7d0;';
  msgEl.textContent = 'Registrando pedido...';
  msgEl.classList.remove('hidden');

  const itensPayload = _pedidoItens.map(i => ({
    produto_id: i.isNovo ? null : i.prodId,
    nome: i.nome,
    unidade: i.unidade,
    quantidade: i.qtd,
    custo: i.custo,
    minimo: i.minimo,
    isNovo: i.isNovo
  }));

  const r = await fetch(`${API}/compras/pedidos`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify({ fornecedor_id: fornecedorId, observacao, data, itens: itensPayload })
  });

  if (!r.ok) {
    const err = await r.json().catch(() => ({}));
    msgEl.style.cssText = 'font-size:13px;padding:8px 12px;border-radius:8px;background:#fef2f2;color:#991b1b;border:1px solid #fecaca;';
    msgEl.textContent = `❌ ${err.erro || 'Erro ao registrar pedido.'}`;
    return;
  }

  if (abrirWhats) {
    const dataFmt = new Date(data + 'T12:00:00').toLocaleDateString('pt-BR');
    let msg = `🛒 *Pedido de compra* — ${dataFmt}\n`;
    if (observacao) msg += `🏭 Fornecedor: *${observacao}*\n`;
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
  const r = await fetch(`${API}/compras/pedidos/${id}/receber`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
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

async function reabrirPedido(id) {
  // Busca os dados do pedido pendente
  const pendentes = await api('/compras/pedidos') || [];
  const pedido = pendentes.find(p => p.id === id);
  if (!pedido) return;

  // Cancela o pedido no backend para poder recriá-lo com as alterações
  await fetch(`${API}/compras/pedidos/${id}/cancelar`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });

  // Restaura os itens no carrinho
  _pedidoItens = pedido.itens.map(i => ({
    id: Date.now() + Math.random(),
    prodId: i.produto_id,
    nome: i.produto,
    unidade: i.unidade,
    qtd: parseFloat(i.quantidade),
    custo: parseFloat(i.custo_unitario || 0),
    isNovo: false,
    minimo: 0
  }));

  // Preenche fornecedor e data no modal
  await carregarCompras();
  renderizarPedido();

  const selF = document.getElementById('compra-fornecedor');
  if (pedido.fornecedor_id) selF.value = pedido.fornecedor_id;

  abrirModalFinalizar();
  mostrarMsgCompra('📝 Pedido reaberto — adicione itens e registre novamente.', 'ok');
}

async function enviarPedidoWhatsApp(tel, nomeForn) {
  const prods = await api('/produtos?alerta=minimo') || [];
  const zerados = await api('/produtos?alerta=zerado') || [];
  const todos = [...zerados, ...prods.filter(p => !zerados.find(z => z.id === p.id))];
  let msg = `📋 *PEDIDO — PanificaPro*\n${new Date().toLocaleDateString('pt-BR')}\n\nOlá, *${nomeForn}*! Segue nossa lista de compras:\n\n`;
  if (todos.length) {
    todos.forEach(p => {
      const falta = Math.max(0, p.estoque_minimo - p.estoque_atual);
      msg += `• ${p.nome}: *${fmtQtd(falta)} ${p.unidade}*\n`;
    });
  } else {
    msg += '_Nenhum item crítico no momento._\n';
  }
  msg += '\nAguardamos confirmação. Obrigado!';
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
  let txt = '📋 LISTA DE COMPRAS — PanificaPro\n';
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

async function salvarFornecedor(e) {
  e.preventDefault();
  const body = {
    nome:     document.getElementById('forn-nome').value,
    contato:  document.getElementById('forn-contato').value,
    telefone: document.getElementById('forn-tel').value,
    email:    document.getElementById('forn-email').value,
  };
  const r = await fetch(`${API}/fornecedores`, {
    method: 'POST',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  if (r.ok) { fecharModal('modal-forn'); carregarFornecedores(); carregarCompras(); }
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
        ? `<button onclick="enviarPedidoWhatsApp('${tel}','${f.nome.replace(/'/g,"\\'")}',${f.id})" class="btn-secondary" style="font-size:12px;padding:6px 10px;white-space:nowrap;">📲 WhatsApp</button>`
        : '';
      return `<div class="repor-item" style="flex-wrap:wrap;gap:8px;">
        <div style="flex:1;min-width:0;">
          <div class="repor-item-name">${f.nome}</div>
          <div class="repor-item-sub">${f.telefone || '<em>Sem telefone</em>'} ${f.email ? '· ' + f.email : ''}</div>
        </div>
        <div style="display:flex;gap:6px;align-items:center;flex-shrink:0;">
          ${waBtn}
          <button onclick="editarFornecedor(${f.id},'${f.nome.replace(/'/g,"\\'")}','${(f.contato||'').replace(/'/g,"\\'")}','${(f.telefone||'').replace(/'/g,"\\'")}','${(f.email||'').replace(/'/g,"\\'")}')" class="btn-icon" title="Editar">✏️</button>
          <button onclick="excluirFornecedor(${f.id})" class="btn-icon" style="color:#dc2626;" title="Excluir">🗑️</button>
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
  const id = document.getElementById('editar-forn-id').value;
  const body = {
    nome:     document.getElementById('editar-forn-nome').value.trim(),
    contato:  document.getElementById('editar-forn-contato').value.trim(),
    telefone: document.getElementById('editar-forn-tel').value.trim(),
    email:    document.getElementById('editar-forn-email').value.trim(),
  };
  if (!body.nome) { mostrarToast('Nome é obrigatório.', 'err'); return; }
  const r = await fetch(`${API}/fornecedores/${id}`, {
    method: 'PUT',
    headers: { 'Authorization': `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
    body: JSON.stringify(body)
  });
  if (r.ok) {
    fecharModal('modal-editar-forn');
    mostrarToast('✅ Fornecedor atualizado!', 'ok');
    carregarFornecedores();
  }
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

async function carregarRelatorios() {
  popularMeses();
  const mes = document.getElementById('rel-mes').value;
  const data = await api(`/relatorios/mes?mes=${mes}`);
  if (!data) return;

  document.getElementById('rel-kpis').innerHTML = `
    <div class="kpi-card"><div class="kpi-label">Total entradas</div><div class="kpi-value" style="color:#16a34a;">R$ ${parseFloat(data.total_entradas||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div></div>
    <div class="kpi-card"><div class="kpi-label">Total saídas (custo)</div><div class="kpi-value" style="color:#dc2626;">R$ ${parseFloat(data.total_saidas||0).toLocaleString('pt-BR',{minimumFractionDigits:2})}</div></div>
    <div class="kpi-card"><div class="kpi-label">Movimentações</div><div class="kpi-value">${data.qtd_movs||0}</div></div>
    <div class="kpi-card"><div class="kpi-label">Produtos movimentados</div><div class="kpi-value">${data.prods_distintos||0}</div></div>
  `;

  const tipos = { entrada:'📥 Entrada', saida:'📤 Saída', ajuste:'⚙️ Ajuste', sync_saurus:'🔄 Saurus' };
  document.getElementById('tabela-rel-movs').innerHTML = data.movs?.length
    ? data.movs.map(m => `<tr>
        <td class="td-main">${m.produto}</td>
        <td>${tipos[m.tipo]||m.tipo}</td>
        <td class="right td-mono">${fmtQtd(m.quantidade)}</td>
        <td class="right">R$ ${parseFloat(m.custo_unit||0).toFixed(2)}</td>
        <td class="right" style="font-weight:600;">R$ ${parseFloat(m.valor_total||0).toFixed(2)}</td>
        <td>${new Date(m.data).toLocaleDateString('pt-BR')}</td>
      </tr>`).join('')
    : '<tr class="empty-row"><td colspan="6">Nenhuma movimentação neste mês</td></tr>';
}

function imprimirRelatorio() { window.print(); }

function statusBadge(p) {
  const hoje = new Date(); hoje.setHours(0,0,0,0);
  const val  = p.validade ? new Date(p.validade) : null;
  if (p.estoque_atual <= 0) return '<span class="badge badge-zero">🔴 Sem estoque</span>';
  if (p.estoque_minimo > 0 && p.estoque_atual < p.estoque_minimo) return '<span class="badge badge-min">⚠️ Abaixo mín.</span>';
  if (val && val <= new Date(hoje.getTime() + 10*86400000)) return '<span class="badge badge-validade">🟡 Vencendo</span>';
  return '<span class="badge badge-ok">✅ OK</span>';
}

async function carregarCategorias() {
  const cats = await api('/categorias');
  const sel  = document.getElementById('prod-categoria');
  if (!cats) return;
  sel.innerHTML = '<option value="">— Sem categoria —</option>' +
    cats.map(c => `<option value="${c.id}">${c.nome}</option>`).join('');
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

function abrirModalProduto() {
  document.getElementById('prod-id').value = '';
  document.getElementById('modal-titulo').textContent = 'Novo produto';
  document.getElementById('form-produto').reset();
  document.getElementById('wrap-saldo').classList.remove('hidden');
  document.getElementById('modal-produto').classList.remove('hidden');
}

async function editarProduto(id) {
  const p = await api(`/produtos/${id}`);
  if (!p) return;
  document.getElementById('prod-id').value      = p.id;
  document.getElementById('prod-nome').value    = p.nome;
  document.getElementById('prod-cod').value     = p.codigo_barras || '';
  document.getElementById('prod-unidade').value = p.unidade;
  document.getElementById('prod-minimo').value  = Math.round(p.estoque_minimo || 0);
  document.getElementById('prod-custo').value   = parseFloat(p.custo_unitario || 0).toFixed(2);
  document.getElementById('prod-venda').value   = parseFloat(p.preco_venda || 0).toFixed(2);
  document.getElementById('prod-validade').value= p.validade ? p.validade.slice(0,10) : '';
  document.getElementById('prod-categoria').value = p.categoria_id || '';
  document.getElementById('wrap-saldo').classList.add('hidden');
  document.getElementById('modal-titulo').textContent = 'Editar produto';
  document.getElementById('modal-produto').classList.remove('hidden');
}

// D) Product edit feedback
async function salvarProduto(e) {
  e.preventDefault();
  const id = document.getElementById('prod-id').value;
  const body = {
    nome:          document.getElementById('prod-nome').value,
    codigo_barras: document.getElementById('prod-cod').value || null,
    unidade:       document.getElementById('prod-unidade').value,
    categoria_id:  document.getElementById('prod-categoria').value || null,
    estoque_minimo:parseFloat(document.getElementById('prod-minimo').value) || 0,
    custo_unitario:parseFloat(document.getElementById('prod-custo').value) || 0,
    preco_venda:   parseFloat(document.getElementById('prod-venda').value) || 0,
    validade:      document.getElementById('prod-validade').value || null,
  };
  if (!id) body.estoque_atual = parseFloat(document.getElementById('prod-saldo').value) || 0;
  const res = await api(id ? `/produtos/${id}` : '/produtos', { method: id ? 'PUT' : 'POST', body });
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
  await api('/movimentacoes', {
    method: 'POST',
    body: {
      produto_id: parseInt(document.getElementById('mov-produto').value),
      tipo:       document.getElementById('mov-tipo').value,
      quantidade: parseFloat(document.getElementById('mov-qtd').value),
      custo_unit: parseFloat(document.getElementById('mov-custo').value) || 0,
      observacao: document.getElementById('mov-obs').value || null,
    }
  });
  fecharModal('modal-mov');
  carregarMovimentacoes();
  carregarDashboard();
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
    el.textContent = `✅ Sync concluído${lojaInfo}! ${d.atualizados} atualizados, ${d.criados} novos, ${d.ignorados} ignorados.`;
  } else {
    el.className = 'result-err';
    el.textContent = `❌ Erro: ${d.erro}`;
  }
}

async function limparTodosDados() {
  if (!confirm('⚠️ Tem certeza? Isso apagará TODOS os produtos e movimentações do seu estoque. Esta ação não pode ser desfeita.')) return;
  if (!confirm('Confirmação final: todos os dados serão removidos permanentemente. Continuar?')) return;
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
      if (d) { document.getElementById('sidebar-nome').textContent = d.nome; entrar(); }
    });
}

// ── Scanner de código de barras ──────────────────────────
let scannerCtx = 'estoque';
let html5Qr = null;

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

async function processarCodigoBarras(codigo, ctx) {
  document.getElementById('scan-status').textContent = `🔍 Buscando ${codigo}...`;
  document.getElementById('scanner-view').innerHTML = '';

  const r = await fetch(`${API}/produtos?busca=${encodeURIComponent(codigo)}`, {
    headers: { 'Authorization': `Bearer ${TOKEN}` }
  });
  const lista = await r.json();
  const prod = lista.find(p => p.codigo_barras === codigo);

  await fecharScanner();

  if (prod) {
    document.getElementById('form-mov').reset();
    const sel = document.getElementById('mov-produto');
    sel.innerHTML = '<option value="">— Selecione —</option>' +
      todosProds.map(p => `<option value="${p.id}">${p.nome}</option>`).join('');
    sel.value = prod.id;
    document.getElementById('mov-custo').value = prod.custo_unitario || 0;
    const info = document.getElementById('mov-produto-info');
    info.innerHTML = `<div style="background:#f0fdf4;border:1px solid #bbf7d0;border-radius:8px;padding:10px 14px;margin-bottom:12px;font-size:13px;">
      ✅ <strong>${prod.nome}</strong><br>
      <span style="color:#64748b;">Estoque atual: <strong>${fmtQtd(prod.estoque_atual)} ${prod.unidade}</strong> · Custo: R$ ${parseFloat(prod.custo_unitario).toFixed(2)}</span>
    </div>`;
    info.classList.remove('hidden');
    document.getElementById('modal-mov').classList.remove('hidden');
    document.getElementById('mov-qtd').focus();
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
