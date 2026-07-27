<template>
  <div class="login-page">
    <div class="login-card">
      <div class="login-logo">🥖</div>
      <h1>PanificaPro</h1>
      <p class="login-sub">Entre na sua conta</p>

      <form @submit.prevent="entrar" class="login-form">
        <div class="form-group">
          <label>E-mail</label>
          <input v-model="email" type="email" placeholder="seu@email.com" required autofocus />
        </div>
        <div class="form-group">
          <label>Senha</label>
          <input v-model="senha" type="password" placeholder="••••••••" required />
        </div>
        <p v-if="erro" class="erro-msg">{{ erro }}</p>
        <button type="submit" class="btn btn-primary btn-block" :disabled="carregando">
          {{ carregando ? 'Entrando…' : 'Entrar' }}
        </button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

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
.login-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--bg);
}

.login-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 16px;
  padding: 40px 36px;
  width: 380px;
  max-width: 95vw;
  text-align: center;
}

.login-logo { font-size: 40px; margin-bottom: 8px; }

h1 { font-size: 22px; font-weight: 700; color: var(--navy); margin-bottom: 4px; }

.login-sub { color: var(--text-muted); margin-bottom: 28px; font-size: 14px; }

.login-form { text-align: left; }

.btn-block { width: 100%; justify-content: center; margin-top: 6px; }

.erro-msg { color: #dc2626; font-size: 13px; margin-bottom: 10px; }
</style>
