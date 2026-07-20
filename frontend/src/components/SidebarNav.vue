<template>
  <aside class="sidebar">
    <div class="sidebar-header">
      <div class="sidebar-brand">
        <img src="/img/logo-escuro.svg" alt="PanificaPro" class="sidebar-brand-svg" />
      </div>
      <div class="sidebar-user">
        <div class="sidebar-user-label">Logado como</div>
        <span class="sidebar-user-nome">{{ auth.padaria?.nome }}</span>
      </div>
    </div>

    <nav class="sidebar-nav">
      <RouterLink to="/painel" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><rect x="32" y="32" width="84" height="84" rx="8" opacity="0.25"/><rect x="140" y="32" width="84" height="84" rx="8" opacity="0.25"/><rect x="32" y="140" width="84" height="84" rx="8" opacity="0.25"/><rect x="140" y="140" width="84" height="84" rx="8"/></svg></span>
        <span class="nav-label">Painel</span>
      </RouterLink>
      <RouterLink to="/estoque" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><path d="M128 26.46 29.49 80 128 133.54 226.51 80Z" opacity="0.25"/><path d="M226.51 80 128 133.54v106.92L226.51 187Z" opacity="0.25"/><path d="M29.49 80v107L128 240.46V133.54Z"/></svg></span>
        <span class="nav-label">Estoque</span>
      </RouterLink>
      <RouterLink to="/compras" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><path d="M222.14 58.87A8 8 0 0 0 216 56H54.68L49.79 29.14A16 16 0 0 0 34.05 16H16a8 8 0 0 0 0 16H34.05l32.51 168.86A24 24 0 1 0 98.24 208H169.6a24 24 0 1 0 20.4-11.14L183.42 168H224a8 8 0 0 0 7.86-6.57l16-96a8 8 0 0 0-1.72-6.56Z" opacity="0.25"/><circle cx="88" cy="216" r="16"/><circle cx="184" cy="216" r="16"/><path d="M230 61.57 215.43 152H91.52L63.92 72h152.56A8 8 0 0 1 230 61.57Z"/></svg></span>
        <span class="nav-label">Compras</span>
      </RouterLink>
      <RouterLink to="/fornecedores" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><path d="M176 72v56H32V88a16 16 0 0 1 16-16Z" opacity="0.25"/><path d="M176 72h40l32 56v40h-72Z" opacity="0.25"/><circle cx="68" cy="200" r="20"/><circle cx="188" cy="200" r="20"/></svg></span>
        <span class="nav-label">Fornecedores</span>
      </RouterLink>
      <RouterLink to="/relatorios" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><rect x="32" y="128" width="48" height="88" rx="8" opacity="0.25"/><rect x="104" y="72" width="48" height="144" rx="8" opacity="0.25"/><rect x="176" y="32" width="48" height="184" rx="8"/></svg></span>
        <span class="nav-label">Relatórios</span>
      </RouterLink>
      <RouterLink to="/importar" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><path d="M213.66 82.34L157.66 26.34A8 8 0 0 0 152 24H56a16 16 0 0 0-16 16v176a16 16 0 0 0 16 16h144a16 16 0 0 0 16-16V88a8 8 0 0 0-2.34-5.66Z" opacity="0.25"/><path d="M152 24v72h72" fill="none" stroke="currentColor" stroke-width="16" stroke-linecap="round" stroke-linejoin="round"/><line x1="128" y1="112" x2="128" y2="168" stroke="currentColor" stroke-width="16" stroke-linecap="round"/><polyline points="104,136 128,112 152,136" fill="none" stroke="currentColor" stroke-width="16" stroke-linecap="round" stroke-linejoin="round"/></svg></span>
        <span class="nav-label">Importar Dados</span>
      </RouterLink>
    </nav>

    <div class="sidebar-footer">
      <RouterLink v-if="auth.padaria?.role === 'admin'" to="/admin" class="sidebar-link">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><circle cx="128" cy="128" r="40" opacity="0.25"/><circle cx="128" cy="128" r="40" fill="none" stroke="currentColor" stroke-width="16"/></svg></span>
        <span class="nav-label">Admin</span>
      </RouterLink>
      <button class="sidebar-link" @click="auth.sair()">
        <span class="nav-icon"><svg width="18" height="18" viewBox="0 0 256 256" fill="currentColor"><path d="M104 216H56a16 16 0 0 1-16-16V56a16 16 0 0 1 16-16h48a8 8 0 0 1 0 16H56v160h48a8 8 0 0 1 0 16Z" opacity="0.25"/><path d="M218.83 130.83l-40 40a8 8 0 0 1-11.32-11.32L196.69 136H104a8 8 0 0 1 0-16h92.69l-29.18-29.17a8 8 0 1 1 11.32-11.32l40 40a8 8 0 0 1 0 11.32Z"/></svg></span>
        <span class="nav-label">Sair</span>
      </button>
    </div>
  </aside>
</template>

<script setup>
import { useAuthStore } from '@/stores/auth'
const auth = useAuthStore()
</script>

<style scoped>
.sidebar {
  width: 260px; min-width: 260px;
  background: var(--navy);
  display: flex; flex-direction: column;
  height: 100vh; overflow: hidden;
}
.sidebar-header {
  padding: 20px 16px 16px;
  border-bottom: 1px solid rgba(255,255,255,0.08);
  flex-shrink: 0;
}
.sidebar-brand { margin-bottom: 14px; }
.sidebar-brand-svg { width: 100%; height: auto; display: block; max-height: 48px; object-fit: contain; }
.sidebar-user { background: rgba(255,255,255,0.06); border-radius: 8px; padding: 10px 12px; }
.sidebar-user-label { font-size: 11px; color: var(--slate-400); margin-bottom: 2px; }
.sidebar-user-nome { font-size: 13px; font-weight: 600; color: #fff; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block; }
.sidebar-nav { flex: 1; padding: 12px 10px; overflow-y: auto; display: flex; flex-direction: column; gap: 2px; }
.sidebar-link {
  display: flex; align-items: center; gap: 10px; width: 100%;
  padding: 11px 14px; border-radius: 9px; color: rgba(255,255,255,0.65);
  font-size: 14px; font-weight: 500; font-family: 'Plus Jakarta Sans', sans-serif;
  background: transparent; border: none; text-align: left; cursor: pointer;
  transition: background 0.18s, color 0.18s; text-decoration: none;
}
.sidebar-link:hover { background: rgba(255,255,255,0.08); color: #fff; }
.sidebar-link.router-link-active {
  background: var(--orange); color: #fff; font-weight: 600;
  box-shadow: 0 2px 10px rgba(249,115,22,0.35);
}
.nav-icon { flex-shrink: 0; width: 22px; display: flex; align-items: center; justify-content: center; opacity: 0.85; }
.sidebar-link:hover .nav-icon,
.sidebar-link.router-link-active .nav-icon { opacity: 1; }
.nav-label { flex: 1; }
.sidebar-footer { padding: 10px; border-top: 1px solid rgba(255,255,255,0.08); flex-shrink: 0; }
</style>
