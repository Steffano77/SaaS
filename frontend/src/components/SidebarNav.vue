<template>
  <aside class="sidebar">
    <div class="sidebar-logo">
      <span class="logo-text">🥖 PanificaPro</span>
    </div>

    <nav class="sidebar-nav">
      <RouterLink to="/painel" class="sidebar-link">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
        Painel
      </RouterLink>
      <RouterLink to="/fornecedores" class="sidebar-link">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
        Fornecedores
      </RouterLink>
    </nav>

    <div class="sidebar-footer">
      <span class="sidebar-user">{{ auth.padaria?.nome }}</span>
      <button class="btn-sair" @click="auth.sair()">Sair</button>
    </div>
  </aside>
</template>

<script setup>
import { useAuthStore } from '@/stores/auth'
const auth = useAuthStore()
</script>

<style scoped>
.sidebar {
  position: fixed;
  top: 0; left: 0; bottom: 0;
  width: var(--sidebar-w);
  background: var(--navy);
  display: flex;
  flex-direction: column;
  z-index: 50;
}

.sidebar-logo {
  padding: 20px 16px 12px;
  border-bottom: 1px solid rgba(255,255,255,.08);
}

.logo-text {
  font-size: 16px;
  font-weight: 700;
  color: #fff;
}

.sidebar-nav {
  flex: 1;
  padding: 12px 8px;
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.sidebar-link {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 9px 12px;
  border-radius: 8px;
  color: rgba(255,255,255,.65);
  text-decoration: none;
  font-size: 14px;
  font-weight: 500;
  transition: background .15s, color .15s;
}

.sidebar-link:hover,
.sidebar-link.router-link-active {
  background: rgba(249,115,22,.15);
  color: #fff;
}

.sidebar-link.router-link-active {
  color: var(--orange);
}

.sidebar-footer {
  padding: 14px 16px;
  border-top: 1px solid rgba(255,255,255,.08);
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.sidebar-user {
  font-size: 12px;
  color: rgba(255,255,255,.5);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.btn-sair {
  background: rgba(255,255,255,.06);
  color: rgba(255,255,255,.7);
  border: none;
  border-radius: 6px;
  padding: 6px 10px;
  font-size: 13px;
  cursor: pointer;
  text-align: left;
}

.btn-sair:hover {
  background: rgba(255,255,255,.12);
  color: #fff;
}
</style>
