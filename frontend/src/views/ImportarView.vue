<template>
  <div>
    <div class="page-header">
      <h1>Importar dados</h1>
    </div>

    <!-- Tabs -->
    <div class="tabs">
      <button :class="['tab', aba === 'generico' && 'ativa']" @click="aba = 'generico'">
        📊 Planilha genérica (.xlsx / .csv)
      </button>
      <button :class="['tab', aba === 'saurus' && 'ativa']" @click="aba = 'saurus'">
        🔄 Importar do Saurus
      </button>
      <button :class="['tab', aba === 'perfil' && 'ativa']" @click="aba = 'perfil'">
        ⚙️ Configurações
      </button>
    </div>

    <!-- ── Aba Planilha Genérica ── -->
    <div v-if="aba === 'generico'">

      <!-- Passo 1: selecionar arquivo -->
      <div v-if="passo === 1" class="card">
        <h3>Passo 1 — Selecione a planilha</h3>
        <p class="instrucao">
          Envie um arquivo <strong>.xlsx</strong> ou <strong>.csv</strong> com seus produtos.
          Na próxima etapa você vai associar as colunas da planilha aos campos do sistema.
        </p>
        <div class="upload-area" @dragover.prevent @drop.prevent="onDrop">
          <input ref="inputArquivo" type="file" accept=".xlsx,.csv" @change="onArquivo" hidden />
          <div v-if="!arquivo" class="upload-placeholder" @click="inputArquivo.click()">
            <div class="upload-icon">📂</div>
            <div>Clique aqui ou arraste o arquivo</div>
            <div class="text-muted">.xlsx ou .csv</div>
          </div>
          <div v-else class="upload-selecionado">
            <span>📄 {{ arquivo.name }}</span>
            <button class="btn btn-ghost btn-sm" @click="arquivo = null">Trocar</button>
          </div>
        </div>
        <div class="card-acoes">
          <button class="btn btn-primary" @click="fazerPreview" :disabled="!arquivo || carregando">
            {{ carregando ? 'Lendo…' : 'Avançar →' }}
          </button>
        </div>
        <p v-if="erro" class="msg-erro">{{ erro }}</p>
      </div>

      <!-- Passo 2: mapear colunas -->
      <div v-if="passo === 2" class="card">
        <h3>Passo 2 — Associar colunas</h3>
        <p class="instrucao">
          Associe cada campo do sistema com a coluna correspondente na sua planilha.
          O campo <strong>Nome do produto</strong> é obrigatório.
        </p>

        <div class="mapeamento">
          <div v-for="campo in CAMPOS" :key="campo.key" class="campo-linha">
            <label>
              {{ campo.label }}
              <span v-if="campo.obrigatorio" class="obrigatorio">*</span>
            </label>
            <select v-model="mapeamento[campo.key]">
              <option value="">— Ignorar —</option>
              <option v-for="col in colunas" :key="col" :value="col">{{ col }}</option>
            </select>
          </div>
        </div>

        <div class="card-acoes">
          <button class="btn btn-ghost" @click="passo = 1; resultado = null">← Voltar</button>
          <button class="btn btn-primary" @click="confirmarImportacao" :disabled="carregando || !mapeamento.nome">
            {{ carregando ? 'Importando…' : 'Importar' }}
          </button>
        </div>

        <div v-if="resultado" :class="['resultado', resultado.ok ? 'resultado-ok' : 'resultado-erro']">
          <template v-if="resultado.ok">
            ✅ Importação concluída!
            <strong>{{ resultado.criados }} criados</strong>,
            <strong>{{ resultado.atualizados }} atualizados</strong>,
            {{ resultado.ignorados }} ignorados.
          </template>
          <template v-else>❌ {{ resultado.erro }}</template>
        </div>

        <p v-if="erro" class="msg-erro">{{ erro }}</p>
      </div>
    </div>

    <!-- ── Aba Saurus ── -->
    <div v-if="aba === 'saurus'">
      <div class="card">
        <h3>Importar do sistema Saurus</h3>
        <p class="instrucao">
          Exporte os produtos do Saurus em formato <strong>.xlsx</strong> e faça o upload abaixo.
          Os produtos serão atualizados automaticamente pelo código de barras.
        </p>

        <div class="form-group">
          <label>Arquivo Saurus (.xlsx)</label>
          <input ref="inputSaurus" type="file" accept=".xlsx" @change="onArquivoSaurus" />
        </div>
        <div class="form-group" style="max-width:200px">
          <label>Número da loja (opcional)</label>
          <input v-model="loja" placeholder="Ex: 1" />
        </div>

        <div class="card-acoes">
          <button class="btn btn-primary" @click="sincronizarSaurus" :disabled="!arquivoSaurus || carregandoSaurus">
            {{ carregandoSaurus ? 'Importando…' : '🔄 Sincronizar' }}
          </button>
        </div>

        <div v-if="resultadoSaurus" :class="['resultado', resultadoSaurus.ok ? 'resultado-ok' : 'resultado-erro']">
          <template v-if="resultadoSaurus.ok">
            ✅ Sincronização concluída!
            <strong>{{ resultadoSaurus.criados }} criados</strong>,
            <strong>{{ resultadoSaurus.atualizados }} atualizados</strong>,
            {{ resultadoSaurus.ignorados }} ignorados.
          </template>
          <template v-else>❌ {{ resultadoSaurus.erro }}</template>
        </div>
      </div>
    </div>

    <!-- ── Aba Configurações (Perfil) ── -->
    <div v-if="aba === 'perfil'">
      <div class="card" style="max-width:480px">
        <h3>Nome da padaria</h3>
        <p class="instrucao">Este nome aparece no sidebar e nos pedidos de compra.</p>
        <div class="form-group">
          <label>Nome</label>
          <input v-model="nomePadaria" placeholder="Nome da sua padaria" />
        </div>
        <div class="card-acoes">
          <button class="btn btn-primary" @click="salvarNome" :disabled="salvandoNome || !nomePadaria.trim()">
            {{ salvandoNome ? 'Salvando…' : 'Salvar nome' }}
          </button>
        </div>
        <p v-if="nomeSalvo" class="msg-ok">✅ Nome atualizado!</p>
      </div>
    </div>

    <AppToast ref="toast" />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/api'
import AppToast from '@/components/AppToast.vue'
import { useAuthStore } from '@/stores/auth'

const auth  = useAuthStore()
const toast = ref(null)
const aba   = ref('generico')

// ── Importação genérica ───────────────────────────────────────────────────────
const CAMPOS = [
  { key: 'nome',           label: 'Nome do produto',   obrigatorio: true  },
  { key: 'codigo_barras',  label: 'Código de barras',  obrigatorio: false },
  { key: 'estoque_atual',  label: 'Estoque atual',     obrigatorio: false },
  { key: 'custo_unitario', label: 'Custo unitário',    obrigatorio: false },
  { key: 'preco_venda',    label: 'Preço de venda',    obrigatorio: false },
  { key: 'unidade',        label: 'Unidade (kg, un…)', obrigatorio: false },
  { key: 'categoria',      label: 'Categoria',         obrigatorio: false },
  { key: 'estoque_minimo', label: 'Estoque mínimo',    obrigatorio: false },
]

const passo      = ref(1)
const arquivo    = ref(null)
const colunas    = ref([])
const mapeamento = ref({})
const carregando = ref(false)
const resultado  = ref(null)
const erro       = ref('')
const inputArquivo = ref(null)

function onArquivo(e) { arquivo.value = e.target.files[0] || null }
function onDrop(e)    { arquivo.value = e.dataTransfer.files[0] || null }

async function fazerPreview() {
  if (!arquivo.value) return
  carregando.value = true
  erro.value = ''
  try {
    const token = localStorage.getItem('token')
    const fd = new FormData()
    fd.append('arquivo', arquivo.value)
    const resp = await fetch('/api/sync/preview', {
      method: 'POST',
      headers: { Authorization: `Bearer ${token}` },
      body: fd,
    })
    const data = await resp.json()
    if (!resp.ok) { erro.value = data.erro || 'Erro ao ler arquivo.'; return }
    colunas.value = data.colunas || []
    // Auto-match por similaridade
    mapeamento.value = {}
    for (const campo of CAMPOS) {
      const match = colunas.value.find(c =>
        c.toLowerCase().replace(/[\s_-]/g, '').includes(campo.key.replace(/_/g, ''))
        || campo.key.replace(/_/g, '').includes(c.toLowerCase().replace(/[\s_-]/g, ''))
      )
      mapeamento.value[campo.key] = match || ''
    }
    passo.value = 2
  } finally {
    carregando.value = false
  }
}

async function confirmarImportacao() {
  if (!mapeamento.value.nome) { erro.value = 'O campo Nome do produto é obrigatório.'; return }
  carregando.value = true
  erro.value = ''
  resultado.value = null
  try {
    const token = localStorage.getItem('token')
    const fd = new FormData()
    fd.append('arquivo', arquivo.value)
    fd.append('mapeamento', JSON.stringify(mapeamento.value))
    const resp = await fetch('/api/sync/generico', {
      method: 'POST',
      headers: { Authorization: `Bearer ${token}` },
      body: fd,
    })
    const data = await resp.json()
    if (!resp.ok) { resultado.value = { ok: false, erro: data.erro || 'Erro na importação.' }; return }
    resultado.value = { ok: true, ...data }
  } finally {
    carregando.value = false
  }
}

// ── Importação Saurus ─────────────────────────────────────────────────────────
const arquivoSaurus    = ref(null)
const loja             = ref('')
const carregandoSaurus = ref(false)
const resultadoSaurus  = ref(null)

function onArquivoSaurus(e) { arquivoSaurus.value = e.target.files[0] || null }

async function sincronizarSaurus() {
  if (!arquivoSaurus.value) return
  carregandoSaurus.value = true
  resultadoSaurus.value = null
  try {
    const token = localStorage.getItem('token')
    const fd = new FormData()
    fd.append('arquivo', arquivoSaurus.value)
    if (loja.value) fd.append('loja', loja.value)
    const resp = await fetch('/api/sync/saurus', {
      method: 'POST',
      headers: { Authorization: `Bearer ${token}` },
      body: fd,
    })
    const data = await resp.json()
    resultadoSaurus.value = resp.ok ? { ok: true, ...data } : { ok: false, erro: data.erro || 'Erro.' }
  } finally {
    carregandoSaurus.value = false
  }
}

// ── Perfil ────────────────────────────────────────────────────────────────────
const nomePadaria  = ref('')
const salvandoNome = ref(false)
const nomeSalvo    = ref(false)

async function salvarNome() {
  if (!nomePadaria.value.trim()) return
  salvandoNome.value = true
  nomeSalvo.value    = false
  try {
    await api.put('/auth/padaria', { nome: nomePadaria.value.trim() })
    if (auth.padaria) auth.padaria.nome = nomePadaria.value.trim()
    nomeSalvo.value = true
    setTimeout(() => { nomeSalvo.value = false }, 3000)
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao salvar.', 'erro')
  } finally {
    salvandoNome.value = false
  }
}

onMounted(() => {
  nomePadaria.value = auth.padaria?.nome || ''
})
</script>

<style scoped>
.tabs { display: flex; gap: 4px; margin-bottom: 20px; border-bottom: 2px solid var(--border); flex-wrap: wrap; }
.tab {
  padding: 10px 16px; border: none; background: none;
  cursor: pointer; font-size: 14px; font-weight: 500;
  color: var(--text-muted); border-bottom: 2px solid transparent;
  margin-bottom: -2px; transition: color .15s, border-color .15s;
}
.tab.ativa { color: var(--orange); border-bottom-color: var(--orange); }
.tab:hover { color: var(--text); }

.instrucao { color: var(--text-muted); font-size: 14px; margin-bottom: 20px; line-height: 1.6; }

/* Upload area */
.upload-area {
  border: 2px dashed var(--border);
  border-radius: var(--radius);
  margin-bottom: 16px;
  transition: border-color .15s;
}
.upload-area:hover { border-color: var(--orange); }

.upload-placeholder {
  padding: 40px;
  text-align: center;
  cursor: pointer;
  color: var(--text-muted);
}
.upload-icon { font-size: 32px; margin-bottom: 8px; }

.upload-selecionado {
  padding: 14px 20px;
  display: flex; align-items: center; justify-content: space-between;
  font-size: 14px;
}

/* Mapeamento */
.mapeamento { display: flex; flex-direction: column; gap: 10px; margin-bottom: 20px; }
.campo-linha { display: flex; align-items: center; gap: 16px; }
.campo-linha label {
  width: 180px; flex-shrink: 0;
  font-size: 14px; font-weight: 500;
}
.campo-linha select { flex: 1; }
.obrigatorio { color: #dc2626; margin-left: 2px; }

/* Resultado */
.resultado {
  margin-top: 16px; padding: 14px 16px;
  border-radius: 8px; font-size: 14px;
}
.resultado-ok  { background: #dcfce7; color: #166534; }
.resultado-erro { background: #fee2e2; color: #991b1b; }

.card-acoes { display: flex; gap: 8px; margin-top: 8px; }

.msg-erro { color: #dc2626; font-size: 13px; margin-top: 10px; }
.msg-ok   { color: #16a34a; font-size: 13px; margin-top: 10px; }
.text-muted { color: var(--text-muted); }
</style>
