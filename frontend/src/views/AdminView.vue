<template>
  <div>
    <div class="page-header">
      <h1>Administração</h1>
    </div>

    <!-- Tabs -->
    <div class="tabs-admin">
      <button :class="['tab-btn-adm', aba === 'padarias' && 'ativa']" @click="aba = 'padarias'">
        🏪 Padarias ({{ padarias.length }})
      </button>
      <button :class="['tab-btn-adm', aba === 'codigos' && 'ativa']" @click="aba = 'codigos'; carregarCodigos()">
        🔑 Códigos de ativação
      </button>
    </div>

    <!-- ── Aba Padarias ── -->
    <div v-if="aba === 'padarias'">
      <div v-if="carregando" class="estado-vazio">Carregando…</div>
      <div v-else class="padarias-lista">
        <div v-for="p in padarias" :key="p.id" class="padaria-card">
          <div class="padaria-info">
            <div class="padaria-nome">{{ p.nome }}</div>
            <div class="padaria-email">{{ p.email }}</div>
            <div class="padaria-meta">
              <span>{{ p.total_produtos }} produto(s)</span>
              <span class="sep">·</span>
              <span>Plano: <strong>{{ planoLabel(p.plano) }}</strong></span>
              <span class="sep">·</span>
              <span v-html="statusPlano(p)"></span>
            </div>
            <div class="padaria-data">Cadastro: {{ fmtData(p.criado_em) }}</div>
          </div>
          <div class="padaria-acoes" v-if="p.role !== 'admin'">
            <button class="btn-ghost btn-sm" @click="abrirRenovar(p)">🔄 Renovar</button>
            <button class="btn-ghost btn-sm" @click="toggleAtivo(p)">
              {{ p.ativo ? '🔒 Desativar' : '✅ Reativar' }}
            </button>
            <button class="btn-danger btn-sm" @click="apagarPadaria(p)">🗑 Apagar</button>
          </div>
          <div v-else class="admin-badge">— Admin —</div>
        </div>
      </div>
    </div>

    <!-- ── Aba Códigos ── -->
    <div v-if="aba === 'codigos'">
      <!-- Gerar novo código -->
      <div class="card" style="margin-bottom:16px;">
        <div class="card-body">
          <h3 class="card-title">Gerar novo código</h3>
          <div class="gerar-form">
            <select v-model="novoPlano" style="max-width:180px;">
              <option value="essencial">Essencial</option>
              <option value="pro">Pro</option>
              <option value="premium">Premium</option>
            </select>
            <button class="btn-primary" @click="gerarCodigo" :disabled="gerando">
              {{ gerando ? 'Gerando…' : '+ Gerar código' }}
            </button>
          </div>
          <div v-if="ultimoCodigo" class="ultimo-codigo">
            Código gerado: <strong>{{ ultimoCodigo }}</strong>
            <button class="btn-copiar" @click="copiar(ultimoCodigo)" title="Copiar">📋</button>
          </div>
        </div>
      </div>

      <!-- Lista de códigos -->
      <div v-if="carregandoCodigos" class="estado-vazio">Carregando…</div>
      <div v-else-if="!codigos.length" class="estado-vazio">Nenhum código gerado ainda.</div>
      <div v-else class="codigos-lista">
        <div v-for="c in codigos" :key="c.id" class="codigo-card">
          <div class="codigo-info">
            <div class="codigo-valor">
              <span class="codigo-texto">{{ c.codigo }}</span>
              <span :class="['badge', planoCor(c.plano)]">{{ planoLabel(c.plano) }}</span>
              <span :class="['badge', c.usado ? 'badge-ok' : 'badge-validade']">
                {{ c.usado ? '✅ Usado' : 'Disponível' }}
              </span>
            </div>
            <div v-if="c.usado" class="codigo-uso text-muted">
              Usado por <strong>{{ c.padaria_nome || '—' }}</strong>
              {{ c.padaria_email ? `(${c.padaria_email})` : '' }}
              {{ c.usado_em ? '· ' + fmtData(c.usado_em) : '' }}
            </div>
            <div class="codigo-data text-muted">Criado em {{ fmtData(c.criado_em) }}</div>
          </div>
          <div class="codigo-acoes">
            <button v-if="!c.usado" class="btn-ghost btn-sm" @click="copiar(c.codigo)">📋 Copiar</button>
            <button class="btn-danger btn-sm" @click="apagarCodigo(c)">🗑</button>
          </div>
        </div>
      </div>
    </div>

    <!-- ── Modal Renovar Plano ── -->
    <div v-if="modalRenovar" class="modal-backdrop" @click.self="modalRenovar = false">
      <div class="modal">
        <h2>Renovar plano — {{ renovarPadaria?.nome }}</h2>

        <div class="modal-body">
          <div class="form-group">
            <label>Plano</label>
            <select v-model="renovarForm.plano">
              <option value="">Manter atual ({{ planoLabel(renovarPadaria?.plano) }})</option>
              <option value="essencial">Essencial</option>
              <option value="pro">Pro</option>
              <option value="premium">Premium</option>
            </select>
          </div>
          <div class="form-group">
            <label>Quantos meses?</label>
            <input v-model.number="renovarForm.meses" type="number" min="1" max="24" />
          </div>

          <div class="modal-actions">
            <button class="btn-ghost" @click="modalRenovar = false">Cancelar</button>
            <button class="btn-primary" @click="confirmarRenovar" :disabled="salvando">
              {{ salvando ? 'Salvando…' : 'Renovar' }}
            </button>
          </div>
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

const toast   = ref(null)
const aba     = ref('padarias')
const salvando = ref(false)
const gerando  = ref(false)

// Padarias
const padarias  = ref([])
const carregando = ref(true)

// Códigos
const codigos         = ref([])
const carregandoCodigos = ref(false)
const novoPlano       = ref('essencial')
const ultimoCodigo    = ref('')

// Modal renovar
const modalRenovar   = ref(false)
const renovarPadaria = ref(null)
const renovarForm    = ref({ meses: 1, plano: '' })

// ── Padarias ─────────────────────────────────────────────────────────────────
async function carregarPadarias() {
  carregando.value = true
  try { padarias.value = await api.get('/admin/padarias') }
  finally { carregando.value = false }
}

async function toggleAtivo(p) {
  const acao = p.ativo ? 'desativar' : 'reativar'
  if (!confirm(`Deseja ${acao} a padaria "${p.nome}"?`)) return
  try {
    await api.patch(`/admin/padarias/${p.id}/ativo`, { ativo: p.ativo ? 0 : 1 })
    toast.value.mostrar(`Padaria ${p.ativo ? 'desativada' : 'reativada'}.`)
    await carregarPadarias()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro.', 'erro')
  }
}

async function apagarPadaria(p) {
  if (!confirm(`⚠️ Apagar "${p.nome}" permanentemente? Todos os dados serão perdidos!`)) return
  if (!confirm(`Confirma a exclusão definitiva de "${p.nome}"?`)) return
  try {
    await api.delete(`/admin/padarias/${p.id}`)
    toast.value.mostrar('Padaria apagada.')
    await carregarPadarias()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao apagar.', 'erro')
  }
}

function abrirRenovar(p) {
  renovarPadaria.value = p
  renovarForm.value    = { meses: 1, plano: '' }
  modalRenovar.value   = true
}

async function confirmarRenovar() {
  if (!renovarForm.value.meses || renovarForm.value.meses < 1) return
  salvando.value = true
  try {
    const body = { meses: renovarForm.value.meses }
    if (renovarForm.value.plano) body.plano = renovarForm.value.plano
    const r = await api.post(`/admin/padarias/${renovarPadaria.value.id}/renovar`, body)
    const data = new Date(r.plano_expira_em).toLocaleDateString('pt-BR')
    toast.value.mostrar(`Plano renovado até ${data}!`)
    modalRenovar.value = false
    await carregarPadarias()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao renovar.', 'erro')
  } finally {
    salvando.value = false
  }
}

// ── Códigos ───────────────────────────────────────────────────────────────────
async function carregarCodigos() {
  carregandoCodigos.value = true
  try { codigos.value = await api.get('/admin/codigos') }
  finally { carregandoCodigos.value = false }
}

async function gerarCodigo() {
  gerando.value = true
  try {
    const r = await api.post('/admin/codigos', { plano: novoPlano.value })
    ultimoCodigo.value = r.codigo
    toast.value.mostrar(`Código ${r.codigo} gerado!`)
    await carregarCodigos()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao gerar.', 'erro')
  } finally {
    gerando.value = false
  }
}

async function apagarCodigo(c) {
  if (!confirm(`Apagar o código "${c.codigo}"?`)) return
  try {
    await api.delete(`/admin/codigos/${c.id}`)
    toast.value.mostrar('Código apagado.')
    await carregarCodigos()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro.', 'erro')
  }
}

function copiar(texto) {
  navigator.clipboard.writeText(texto).then(() => toast.value.mostrar('Copiado!'))
}

// ── Helpers ───────────────────────────────────────────────────────────────────
function planoLabel(p) {
  return { essencial: 'Essencial', pro: 'Pro', premium: 'Premium' }[p] || p || '—'
}

function planoCor(p) {
  return { essencial: 'badge-blue', pro: 'badge-validade', premium: 'badge-purple' }[p] || ''
}

function statusPlano(p) {
  if (p.role === 'admin') return '<span style="color:var(--slate-400)">— Admin —</span>'
  const expira = p.plano_expira_em ? new Date(p.plano_expira_em).toLocaleDateString('pt-BR') : '—'
  const expirado = p.plano_expira_em && new Date(p.plano_expira_em) < new Date()
  if (p.plano_bloqueado || expirado)
    return `<span style="color:#dc2626;font-weight:600">🔴 Expirado (${expira})</span>`
  if (p.plano_expira_em)
    return `<span style="color:#16a34a">✅ Ativo até ${expira}</span>`
  return `<span style="color:var(--slate-400)">Sem validade</span>`
}

function fmtData(d) {
  return d ? new Date(d).toLocaleDateString('pt-BR') : '—'
}

onMounted(carregarPadarias)
</script>

<style scoped>
/* Tabs */
.tabs-admin {
  display: flex;
  gap: 4px;
  margin-bottom: 20px;
  border-bottom: 2px solid var(--slate-200);
  flex-wrap: wrap;
}
.tab-btn-adm {
  padding: 10px 18px;
  border: none;
  background: none;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: var(--text-muted);
  border-bottom: 2px solid transparent;
  margin-bottom: -2px;
  transition: color .15s, border-color .15s;
}
.tab-btn-adm.ativa { color: var(--orange); border-bottom-color: var(--orange); }
.tab-btn-adm:hover { color: var(--slate-800); }

/* Lista de padarias */
.padarias-lista { display: flex; flex-direction: column; gap: 12px; }

.padaria-card {
  background: var(--white);
  border: 1px solid var(--slate-100);
  border-radius: 16px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.07), 0 1px 2px rgba(0,0,0,0.04);
  padding: 16px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
  transition: box-shadow 0.2s;
}
.padaria-card:hover {
  box-shadow: 0 6px 20px rgba(0,0,0,0.09), 0 2px 6px rgba(0,0,0,0.05);
}
.padaria-info { flex: 1; min-width: 0; }
.padaria-nome  { font-weight: 700; font-size: 15px; color: var(--slate-800); }
.padaria-email { font-size: 13px; color: var(--text-muted); }
.padaria-meta  {
  font-size: 12px; color: var(--slate-500); margin-top: 4px;
  display: flex; flex-wrap: wrap; gap: 4px; align-items: center;
}
.padaria-data  { font-size: 11px; margin-top: 2px; color: var(--slate-400); }
.sep { color: var(--slate-400); }
.padaria-acoes { display: flex; gap: 6px; flex-wrap: wrap; }
.admin-badge { font-size: 13px; color: var(--slate-400); font-style: italic; }

/* Gerar código */
.gerar-form { display: flex; gap: 10px; align-items: center; margin-bottom: 0; }
.ultimo-codigo {
  margin-top: 12px; padding: 10px 14px;
  background: var(--slate-100); border-radius: 8px;
  font-size: 14px; display: flex; align-items: center; gap: 10px;
}
.btn-copiar { background: none; border: none; cursor: pointer; font-size: 16px; }

/* Lista de códigos */
.codigos-lista { display: flex; flex-direction: column; gap: 10px; }
.codigo-card {
  background: var(--white);
  border: 1px solid var(--slate-100);
  border-radius: 16px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.07), 0 1px 2px rgba(0,0,0,0.04);
  padding: 14px 18px;
  display: flex;
  align-items: center;
  gap: 16px;
  flex-wrap: wrap;
  transition: box-shadow 0.2s;
}
.codigo-card:hover {
  box-shadow: 0 6px 20px rgba(0,0,0,0.09), 0 2px 6px rgba(0,0,0,0.05);
}
.codigo-info { flex: 1; min-width: 0; }
.codigo-valor { display: flex; align-items: center; gap: 8px; flex-wrap: wrap; margin-bottom: 4px; }
.codigo-texto { font-family: ui-monospace, 'Cascadia Code', 'Courier New', monospace; font-size: 16px; font-weight: 700; letter-spacing: .05em; }
.codigo-uso  { font-size: 12px; margin-bottom: 2px; }
.codigo-data { font-size: 11px; }
.codigo-acoes { display: flex; gap: 6px; flex-shrink: 0; }

/* Badge purple (não global) */
.badge-purple { background: #f3e8ff; color: #7c3aed; }
.badge-blue   { background: #dbeafe; color: #1d4ed8; }

.estado-vazio { padding: 48px; text-align: center; color: var(--text-muted); font-size: 14px; }
.text-muted { color: var(--text-muted); }
</style>
