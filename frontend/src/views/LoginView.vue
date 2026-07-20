<template>
  <div class="tela-auth">
    <div class="auth-card">
      <!-- Logo -->
      <div class="auth-logo">
        <div class="auth-logo-clip">
          <img :src="logoClaro" alt="PanificaPro" class="auth-logo-full logo-light" />
          <img :src="logoEscuro" alt="PanificaPro" class="auth-logo-full logo-dark" />
        </div>
      </div>

      <!-- Formulário de Login -->
      <form @submit.prevent="entrar" autocomplete="off">
        <div class="form-group">
          <label>Email</label>
          <input v-model="email" type="email" placeholder="sua@padaria.com.br" required class="form-control" />
        </div>
        <div class="form-group">
          <label>Senha</label>
          <input v-model="senha" type="password" placeholder="••••••••" required class="form-control" />
        </div>
        <div v-if="erro" class="error-msg">{{ erro }}</div>
        <button type="submit" class="btn-primary full" :disabled="carregando">
          {{ carregando ? 'Entrando…' : 'Entrar' }}
        </button>
        <div style="text-align:center;margin-top:14px;font-size:13px;">
          <a href="https://www.panificapro.com.br/#planos" target="_blank" style="color:#f97316;text-decoration:none;font-weight:500;">Ver planos e preços no site</a>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const logoClaro  = '/img/logo-claro.svg'
const logoEscuro = '/img/logo-escuro.svg'
const auth      = useAuthStore()
const router    = useRouter()
const email     = ref('')
const senha     = ref('')
const erro      = ref('')
const carregando = ref(false)

async function entrar() {
  erro.value      = ''
  carregando.value = true
  try {
    await auth.login(email.value, senha.value)
    router.push('/painel')
  } catch (e) {
    erro.value = e?.erro || 'Credenciais inválidas.'
  } finally {
    carregando.value = false
  }
}
</script>

<style scoped>
.tela-auth {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, var(--navy-dark) 0%, var(--navy) 60%, var(--navy-light) 100%);
  padding: 24px;
}

.auth-card {
  background: var(--white);
  border-radius: 20px;
  box-shadow: 0 25px 60px rgba(0,0,0,0.25);
  padding: 40px;
  width: 100%;
  max-width: 440px;
  position: relative;
}

.auth-logo {
  text-align: center;
  margin-bottom: 28px;
}

.auth-logo-clip {
  width: 100%;
  max-width: 360px;
  margin: 0 auto;
}

.auth-logo-full {
  width: 100%;
  height: auto;
  display: block;
}

.logo-dark { display: none; }
:global([data-theme="dark"]) .logo-light { display: none; }
:global([data-theme="dark"]) .logo-dark  { display: block; }

.form-group {
  margin-bottom: 18px;
}

.form-group label {
  display: block;
  font-size: 13px;
  font-weight: 600;
  color: var(--slate-700);
  margin-bottom: 6px;
}

.form-control {
  width: 100%;
  border: 1.5px solid var(--slate-200);
  border-radius: 10px;
  padding: 11px 14px;
  font-size: 14px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: var(--slate-800);
  background: var(--white);
  transition: border-color 0.2s, box-shadow 0.2s;
  outline: none;
}

.form-control:focus {
  border-color: var(--orange);
  box-shadow: 0 0 0 3px rgba(249,115,22,0.12);
}

.error-msg {
  font-size: 13px;
  color: var(--red-500);
  margin-bottom: 12px;
}

@media (max-width: 600px) {
  .tela-auth {
    align-items: stretch;
    padding: 0;
  }
  .auth-card {
    padding: 40px 24px;
    border-radius: 0;
    box-shadow: none;
    min-height: 100vh;
    max-width: 100%;
  }
}
</style>
