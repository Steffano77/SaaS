<template>
  <div>
    <div class="page-header">
      <h1>Fornecedores</h1>
      <button class="btn btn-primary" @click="abrirModal()">+ Novo fornecedor</button>
    </div>

    <div class="card">
      <div v-if="carregando" class="estado-vazio">Carregando…</div>
      <div v-else-if="!fornecedores.length" class="estado-vazio">
        Nenhum fornecedor cadastrado ainda.
      </div>
      <table v-else>
        <thead>
          <tr>
            <th>Nome</th>
            <th>Contato</th>
            <th>Telefone</th>
            <th>E-mail</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="f in fornecedores" :key="f.id">
            <td><strong>{{ f.nome }}</strong></td>
            <td>{{ f.contato || '—' }}</td>
            <td>{{ f.telefone || '—' }}</td>
            <td>{{ f.email || '—' }}</td>
            <td class="acoes">
              <button class="btn btn-ghost btn-sm" @click="abrirModal(f)">Editar</button>
              <button class="btn btn-danger btn-sm" @click="remover(f)">Excluir</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal novo/editar -->
    <div v-if="modal" class="modal-backdrop" @click.self="fecharModal">
      <div class="modal">
        <h2>{{ form.id ? 'Editar fornecedor' : 'Novo fornecedor' }}</h2>

        <div class="form-group">
          <label>Nome *</label>
          <input v-model="form.nome" placeholder="Nome do fornecedor" required />
        </div>
        <div class="form-group">
          <label>Contato</label>
          <input v-model="form.contato" placeholder="Nome da pessoa de contato" />
        </div>
        <div class="form-group">
          <label>Telefone / WhatsApp</label>
          <input v-model="form.telefone" placeholder="(00) 00000-0000" />
        </div>
        <div class="form-group">
          <label>E-mail</label>
          <input v-model="form.email" type="email" placeholder="fornecedor@email.com" />
        </div>

        <div class="modal-actions">
          <button class="btn btn-ghost" @click="fecharModal">Cancelar</button>
          <button class="btn btn-primary" @click="salvar" :disabled="salvando">
            {{ salvando ? 'Salvando…' : 'Salvar' }}
          </button>
        </div>
      </div>
    </div>

    <AppToast ref="toast" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/api'
import AppToast from '@/components/AppToast.vue'

const fornecedores = ref([])
const carregando   = ref(true)
const modal        = ref(false)
const salvando     = ref(false)
const toast        = ref(null)

const form = ref(formVazio())

function formVazio() {
  return { id: null, nome: '', contato: '', telefone: '', email: '' }
}

async function carregar() {
  carregando.value = true
  try { fornecedores.value = await api.get('/fornecedores') }
  finally { carregando.value = false }
}

function abrirModal(f = null) {
  form.value = f ? { ...f } : formVazio()
  modal.value = true
}

function fecharModal() {
  modal.value = false
}

async function salvar() {
  if (!form.value.nome.trim()) return
  salvando.value = true
  try {
    if (form.value.id) {
      await api.put(`/fornecedores/${form.value.id}`, form.value)
      toast.value.mostrar('Fornecedor atualizado!')
    } else {
      await api.post('/fornecedores', form.value)
      toast.value.mostrar('Fornecedor cadastrado!')
    }
    fecharModal()
    await carregar()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao salvar.', 'erro')
  } finally {
    salvando.value = false
  }
}

async function remover(f) {
  if (!confirm(`Excluir "${f.nome}"?`)) return
  try {
    await api.delete(`/fornecedores/${f.id}`)
    toast.value.mostrar('Fornecedor removido.')
    await carregar()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao excluir.', 'erro')
  }
}

onMounted(carregar)
</script>

<style scoped>
.acoes { display: flex; gap: 6px; }
.estado-vazio { color: var(--text-muted); padding: 40px; text-align: center; }
</style>
