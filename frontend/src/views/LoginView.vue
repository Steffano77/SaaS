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

      <!-- Tabs -->
      <div class="tabs-auth">
        <button :class="['tab-btn', aba === 'login' && 'active']" @click="aba = 'login'">Entrar</button>
        <button :class="['tab-btn', aba === 'registro' && 'active']" @click="aba = 'registro'">Criar conta</button>
      </div>

      <!-- Formulário de Login -->
      <form v-if="aba === 'login'" @submit.prevent="entrar" autocomplete="off">
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

      <!-- Formulário de Registro -->
      <form v-if="aba === 'registro'" @submit.prevent="registrar" autocomplete="off">
        <div class="form-group">
          <label>Nome da padaria</label>
          <input v-model="regNome" type="text" placeholder="Padaria do João" required class="form-control" />
        </div>
        <div class="form-group">
          <label>Email</label>
          <input v-model="regEmail" type="email" placeholder="contato@padaria.com.br" required class="form-control" />
        </div>
        <div class="form-group">
          <label>Senha</label>
          <input v-model="regSenha" type="password" placeholder="Mínimo 6 caracteres" required class="form-control" />
        </div>
        <div class="form-group">
          <label>Código de ativação</label>
          <input v-model="regCodigo" type="text" placeholder="PP-XXXX-XXXX" required class="form-control"
            style="text-transform:uppercase;letter-spacing:0.1em;font-weight:600;" />
        </div>
        <div v-if="erroReg" class="error-msg">{{ erroReg }}</div>
        <button type="submit" class="btn-primary full" :disabled="carregandoReg">
          {{ carregandoReg ? 'Criando conta…' : 'Criar conta' }}
        </button>
        <p style="text-align:center;margin-top:16px;font-size:13px;color:var(--slate-500);">
          Não tem código?
          <a href="https://www.panificapro.com.br/#planos" target="_blank" style="color:var(--orange);font-weight:600;text-decoration:none;">Ver planos no site</a>
        </p>
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
const aba       = ref('login')

// Login
const email     = ref('')
const senha     = ref('')
const erro      = ref('')
const carregando = ref(false)

// Registro
const regNome    = ref('')
const regEmail   = ref('')
const regSenha   = ref('')
const regCodigo  = ref('')
const erroReg    = ref('')
const carregandoReg = ref(false)

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

async function registrar() {
  erroReg.value = ''
  carregandoReg.value = true
  try {
    await auth.registrar({
      nome:   regNome.value,
      email:  regEmail.value,
      senha:  regSenha.value,
      codigo: regCodigo.value.trim().toUpperCase(),
    })
    router.push('/painel')
  } catch (e) {
    erroReg.value = e?.erro || 'Erro ao criar conta.'
  } finally {
    carregandoReg.value = false
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

.tabs-auth {
  display: flex;
  background: var(--slate-100);
  border-radius: 10px;
  padding: 4px;
  margin-bottom: 28px;
  gap: 4px;
}

.tab-btn {
  flex: 1;
  padding: 9px 12px;
  border: none;
  border-radius: 7px;
  font-size: 14px;
  font-weight: 500;
  font-family: 'Plus Jakarta Sans', sans-serif;
  cursor: pointer;
  transition: all 0.2s;
  background: transparent;
  color: var(--slate-500);
}

.tab-btn.active {
  background: var(--white);
  color: var(--navy);
  box-shadow: 0 1px 4px rgba(0,0,0,0.12);
  font-weight: 600;
}

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
