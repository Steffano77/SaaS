import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '@/api'

export const useAuthStore = defineStore('auth', () => {
  const token = ref(localStorage.getItem('token') || '')
  const padaria = ref(null)

  const logado = computed(() => !!token.value)

  async function login(email, senha) {
    const data = await api.post('/auth/login', { email, senha })
    token.value = data.token
    localStorage.setItem('token', data.token)
    padaria.value = data.padaria
  }

  async function carregarPerfil() {
    if (!token.value) return
    const data = await api.get('/auth/perfil')
    padaria.value = data.padaria
  }

  function sair() {
    token.value = ''
    padaria.value = null
    localStorage.removeItem('token')
  }

  return { token, padaria, logado, login, carregarPerfil, sair }
})
