<template>
  <div>
    <!-- Header -->
    <div class="page-header">
      <h1>Estoque</h1>
      <div class="header-acoes">
        <button class="btn btn-ghost btn-sm" @click="modalMov = true; movForm = movFormVazio()">
          ↕ Movimentação
        </button>
        <button class="btn btn-primary" @click="abrirModalProduto()">+ Novo produto</button>
      </div>
    </div>

    <!-- Filtros -->
    <div class="filtros">
      <input v-model="busca" placeholder="🔍 Buscar produto…" @input="carregarProdutos" />
      <select v-model="filtroCat" @change="carregarProdutos">
        <option value="">Todas as categorias</option>
        <option v-for="c in categorias" :key="c.id" :value="c.id">{{ c.nome }}</option>
      </select>
      <select v-model="filtroForn" @change="filtrarPorFornecedor">
        <option value="">Todos fornecedores</option>
        <option v-for="f in fornecedores" :key="f.id" :value="f.id">{{ f.nome }}</option>
      </select>
      <select v-model="filtroAlerta" @change="carregarProdutos">
        <option value="">Todos os status</option>
        <option value="zerado">Sem estoque</option>
        <option value="abaixo">Abaixo do mínimo</option>
      </select>
    </div>

    <!-- Tabela -->
    <div class="card table-wrap">
      <div v-if="carregando" class="estado-vazio">Carregando…</div>
      <div v-else-if="!produtosFiltrados.length" class="estado-vazio">Nenhum produto encontrado.</div>
      <table v-else>
        <thead>
          <tr>
            <th>Produto</th>
            <th>Categoria</th>
            <th class="right">Estoque</th>
            <th class="right">Mínimo</th>
            <th class="right">Custo unit.</th>
            <th class="right">Valor total</th>
            <th class="center">Validade</th>
            <th class="center">Status</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="p in produtosFiltrados" :key="p.id">
            <td>
              <div class="td-main">{{ p.nome }}</div>
              <div v-if="p.codigo_barras" class="td-sub">{{ p.codigo_barras }}</div>
              <div class="td-sub" :style="{ color: corUltimaCompra(p) }">
                últ. compra: {{ fmtData(p.ultima_compra) }}
              </div>
            </td>
            <td class="text-muted">{{ p.categoria || '—' }}</td>
            <td class="right mono">{{ fmtQtd(p.estoque_atual) }} {{ p.unidade }}</td>
            <td class="right mono text-muted">{{ fmtQtd(p.estoque_minimo) }}</td>
            <td class="right mono">{{ fmtMoeda(p.custo_unitario) }}</td>
            <td class="right mono bold">{{ fmtMoeda(p.estoque_atual * p.custo_unitario) }}</td>
            <td class="center" :style="{ color: p.validade ? 'var(--orange)' : 'var(--slate-400)' }">
              {{ p.validade ? fmtData(p.validade) : '—' }}
            </td>
            <td class="center">
              <StatusBadge :produto="p" />
            </td>
            <td class="acoes">
              <button class="btn btn-ghost btn-sm" title="Entrada" @click="movRapido(p, 'entrada')">📥</button>
              <button class="btn btn-ghost btn-sm" title="Saída"   @click="movRapido(p, 'saida')">📤</button>
              <button class="btn btn-ghost btn-sm"                  @click="editarProduto(p)">✏️</button>
              <button class="btn btn-danger btn-sm"                 @click="excluirProduto(p)">🗑</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- ── Modal produto ── -->
    <div v-if="modalProduto" class="modal-backdrop" @click.self="modalProduto = false">
      <div class="modal modal-lg">
        <h2>{{ prodForm.id ? 'Editar produto' : 'Novo produto' }}</h2>

        <div class="form-grid">
          <div class="form-group span-2">
            <label>Nome *</label>
            <input v-model="prodForm.nome" placeholder="Nome do produto" required />
          </div>
          <div class="form-group">
            <label>Código de barras</label>
            <input v-model="prodForm.codigo_barras" placeholder="EAN / interno" />
          </div>
          <div class="form-group">
            <label>Unidade</label>
            <select v-model="prodForm.unidade">
              <option value="un">un</option>
              <option value="kg">kg</option>
              <option value="g">g</option>
              <option value="cx">cx</option>
              <option value="lt">lt</option>
              <option value="ml">ml</option>
              <option value="pct">pct</option>
              <option value="sc">sc</option>
              <option value="fardo">fardo</option>
              <option value="bd">bd</option>
            </select>
          </div>
          <div class="form-group">
            <label>Categoria</label>
            <div style="display:flex;gap:6px">
              <select v-model="prodForm.categoria_id" style="flex:1">
                <option value="">— Sem categoria —</option>
                <option v-for="c in categorias" :key="c.id" :value="c.id">{{ c.nome }}</option>
              </select>
              <button type="button" class="btn btn-ghost btn-sm" @click="criarCategoria">+</button>
            </div>
          </div>
          <div class="form-group">
            <label>Fornecedor</label>
            <select v-model="prodForm.fornecedor_id">
              <option value="">— Sem fornecedor —</option>
              <option v-for="f in fornecedores" :key="f.id" :value="f.id">{{ f.nome }}</option>
            </select>
          </div>
          <div class="form-group">
            <label>Estoque mínimo</label>
            <input v-model.number="prodForm.estoque_minimo" type="number" min="0" />
          </div>
          <div class="form-group">
            <label>Custo unitário (R$)</label>
            <input v-model.number="prodForm.custo_unitario" type="number" min="0" step="0.01" />
          </div>
          <div class="form-group">
            <label>Preço de venda (R$)</label>
            <input v-model.number="prodForm.preco_venda" type="number" min="0" step="0.01" />
          </div>
          <div class="form-group">
            <label>Saldo inicial</label>
            <input v-model.number="prodForm.estoque_atual" type="number" min="0" :disabled="!!prodForm.id" />
          </div>
          <div class="form-group">
            <label>Validade</label>
            <input v-model="prodForm.validade" type="date" />
          </div>
          <div class="form-group">
            <label>Última compra</label>
            <input v-model="prodForm.ultima_compra" type="date" />
          </div>
        </div>

        <div class="modal-actions">
          <button class="btn btn-ghost" @click="modalProduto = false">Cancelar</button>
          <button class="btn btn-primary" @click="salvarProduto" :disabled="salvando">
            {{ salvando ? 'Salvando…' : 'Salvar' }}
          </button>
        </div>
      </div>
    </div>

    <!-- ── Modal movimentação ── -->
    <div v-if="modalMov" class="modal-backdrop" @click.self="modalMov = false">
      <div class="modal">
        <h2>Registrar movimentação</h2>

        <div class="form-group">
          <label>Produto *</label>
          <select v-model="movForm.produto_id" @change="preencherCustoMov">
            <option value="">— Selecione —</option>
            <option v-for="p in produtos" :key="p.id" :value="p.id">{{ p.nome }}</option>
          </select>
        </div>

        <div v-if="movForm.produto_id" class="mov-info-produto">
          <span>
            Estoque atual:
            <strong>{{ fmtQtd(produtoSelecionado?.estoque_atual) }} {{ produtoSelecionado?.unidade }}</strong>
          </span>
          <span :class="movForm.tipo === 'entrada' ? 'badge-green' : 'badge-red'" class="badge">
            {{ movForm.tipo === 'entrada' ? '📥 Entrada' : movForm.tipo === 'saida' ? '📤 Saída' : '🔧 Ajuste' }}
          </span>
        </div>

        <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px">
          <div class="form-group">
            <label>Tipo</label>
            <select v-model="movForm.tipo">
              <option value="entrada">Entrada</option>
              <option value="saida">Saída</option>
              <option value="ajuste">Ajuste</option>
            </select>
          </div>
          <div class="form-group">
            <label>Quantidade *</label>
            <input v-model.number="movForm.quantidade" type="number" min="0.001" step="0.001" ref="inputQtd" />
          </div>
          <div class="form-group">
            <label>Custo unit. (R$)</label>
            <input v-model.number="movForm.custo_unit" type="number" min="0" step="0.01" />
          </div>
          <div class="form-group">
            <label>Observação</label>
            <input v-model="movForm.observacao" placeholder="Opcional" />
          </div>
        </div>

        <div class="modal-actions">
          <button class="btn btn-ghost" @click="modalMov = false">Cancelar</button>
          <button class="btn btn-primary" @click="salvarMovimentacao" :disabled="salvando">
            {{ salvando ? 'Salvando…' : 'Registrar' }}
          </button>
        </div>
      </div>
    </div>

    <AppToast ref="toast" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted, nextTick } from 'vue'
import api from '@/api'
import AppToast from '@/components/AppToast.vue'
import StatusBadge from '@/components/StatusBadge.vue'

// ── Estado ──────────────────────────────────────────────────────────────────
const produtos      = ref([])
const categorias    = ref([])
const fornecedores  = ref([])
const carregando    = ref(true)
const salvando      = ref(false)
const toast         = ref(null)
const inputQtd      = ref(null)

const busca        = ref('')
const filtroCat    = ref('')
const filtroForn   = ref('')
const filtroAlerta = ref('')
const idsFornAtivo = ref(null) // null = todos

const modalProduto = ref(false)
const modalMov     = ref(false)

// ── Forms ────────────────────────────────────────────────────────────────────
function prodFormVazio() {
  return {
    id: null, nome: '', codigo_barras: '', unidade: 'un',
    categoria_id: '', fornecedor_id: '',
    estoque_minimo: 0, custo_unitario: 0, preco_venda: 0,
    estoque_atual: 0, validade: '', ultima_compra: '',
  }
}

function movFormVazio() {
  return { produto_id: '', tipo: 'entrada', quantidade: '', custo_unit: 0, observacao: '' }
}

const prodForm = ref(prodFormVazio())
const movForm  = ref(movFormVazio())

// ── Computed ─────────────────────────────────────────────────────────────────
const produtosFiltrados = computed(() => {
  if (idsFornAtivo.value === null) return produtos.value
  return produtos.value.filter(p => idsFornAtivo.value.has(p.id))
})

const produtoSelecionado = computed(() =>
  produtos.value.find(p => p.id === movForm.value.produto_id) || null
)

// ── Carregamento ─────────────────────────────────────────────────────────────
async function carregar() {
  const [cats, forns] = await Promise.all([
    api.get('/categorias'),
    api.get('/fornecedores'),
  ])
  categorias.value   = cats
  fornecedores.value = forns
}

async function carregarProdutos() {
  carregando.value = true
  idsFornAtivo.value = null
  const params = new URLSearchParams()
  if (busca.value)        params.set('busca', busca.value)
  if (filtroCat.value)    params.set('categoria_id', filtroCat.value)
  if (filtroAlerta.value) params.set('alerta', filtroAlerta.value)
  try {
    produtos.value = await api.get('/produtos?' + params)
  } finally {
    carregando.value = false
  }
}

async function filtrarPorFornecedor() {
  if (!filtroForn.value) {
    idsFornAtivo.value = null
    return
  }
  const prods = await api.get(`/fornecedores/${filtroForn.value}/produtos`)
  idsFornAtivo.value = new Set(prods.map(p => p.id))
}

// ── Produto modal ─────────────────────────────────────────────────────────────
function abrirModalProduto() {
  prodForm.value   = prodFormVazio()
  modalProduto.value = true
}

function editarProduto(p) {
  prodForm.value = {
    id:            p.id,
    nome:          p.nome,
    codigo_barras: p.codigo_barras || '',
    unidade:       p.unidade,
    categoria_id:  p.categoria_id || '',
    fornecedor_id: p.fornecedor_id || '',
    estoque_minimo: parseFloat(p.estoque_minimo || 0),
    custo_unitario: parseFloat(p.custo_unitario || 0),
    preco_venda:    parseFloat(p.preco_venda || 0),
    estoque_atual:  parseFloat(p.estoque_atual || 0),
    validade:       p.validade ? p.validade.slice(0, 10) : '',
    ultima_compra:  p.ultima_compra ? new Date(p.ultima_compra).toISOString().slice(0, 10) : '',
  }
  modalProduto.value = true
}

async function salvarProduto() {
  if (!prodForm.value.nome.trim()) {
    toast.value.mostrar('Informe o nome do produto.', 'erro')
    return
  }
  salvando.value = true
  const body = {
    nome:           prodForm.value.nome,
    codigo_barras:  prodForm.value.codigo_barras || null,
    unidade:        prodForm.value.unidade,
    categoria_id:   prodForm.value.categoria_id || null,
    fornecedor_id:  prodForm.value.fornecedor_id || null,
    estoque_minimo: prodForm.value.estoque_minimo,
    custo_unitario: prodForm.value.custo_unitario,
    preco_venda:    prodForm.value.preco_venda,
    estoque_atual:  prodForm.value.estoque_atual,
    validade:       prodForm.value.validade || null,
    ultima_compra:  prodForm.value.ultima_compra || null,
  }
  try {
    if (prodForm.value.id) {
      await api.put(`/produtos/${prodForm.value.id}`, body)
      toast.value.mostrar('Produto atualizado!')
    } else {
      await api.post('/produtos', body)
      toast.value.mostrar('Produto cadastrado!')
    }
    modalProduto.value = false
    await carregarProdutos()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao salvar.', 'erro')
  } finally {
    salvando.value = false
  }
}

async function excluirProduto(p) {
  if (!confirm(`Excluir "${p.nome}"? Esta ação não pode ser desfeita.`)) return
  try {
    await api.delete(`/produtos/${p.id}`)
    toast.value.mostrar('Produto removido.')
    await carregarProdutos()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao excluir.', 'erro')
  }
}

async function criarCategoria() {
  const nome = prompt('Nome da nova categoria:')
  if (!nome?.trim()) return
  try {
    const nova = await api.post('/categorias', { nome: nome.trim() })
    await carregar()
    prodForm.value.categoria_id = nova.id
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao criar categoria.', 'erro')
  }
}

// ── Movimentação ──────────────────────────────────────────────────────────────
function movRapido(p, tipo) {
  movForm.value = { produto_id: p.id, tipo, quantidade: '', custo_unit: p.custo_unitario || 0, observacao: '' }
  modalMov.value = true
  nextTick(() => inputQtd.value?.focus())
}

function preencherCustoMov() {
  const p = produtoSelecionado.value
  if (p) movForm.value.custo_unit = p.custo_unitario || 0
}

async function salvarMovimentacao() {
  if (!movForm.value.produto_id || !movForm.value.quantidade) {
    toast.value.mostrar('Preencha produto e quantidade.', 'erro')
    return
  }
  salvando.value = true
  try {
    await api.post('/movimentacoes', {
      produto_id: movForm.value.produto_id,
      tipo:       movForm.value.tipo,
      quantidade: movForm.value.quantidade,
      custo_unit: movForm.value.custo_unit || 0,
      observacao: movForm.value.observacao || null,
    })
    toast.value.mostrar('Movimentação registrada!')
    modalMov.value = false
    await carregarProdutos()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao registrar.', 'erro')
  } finally {
    salvando.value = false
  }
}

// ── Formatação ────────────────────────────────────────────────────────────────
function fmtQtd(v) {
  const n = parseFloat(v || 0)
  return n % 1 === 0 ? n.toFixed(0) : n.toFixed(3).replace(/0+$/, '')
}

function fmtMoeda(v) {
  return parseFloat(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}

function fmtData(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('pt-BR')
}

function corUltimaCompra(p) {
  if (!p.ultima_compra) return 'var(--slate-400)'
  const dias = Math.floor((Date.now() - new Date(p.ultima_compra)) / 86400000)
  if (dias > 30) return '#dc2626'
  if (dias > 15) return '#d97706'
  return 'var(--slate-400)'
}

// ── Init ──────────────────────────────────────────────────────────────────────
onMounted(async () => {
  await Promise.all([carregar(), carregarProdutos()])
})
</script>

<style scoped>
.header-acoes { display: flex; gap: 8px; }

.filtros {
  display: flex;
  gap: 10px;
  margin-bottom: 16px;
  flex-wrap: wrap;
}
.filtros input, .filtros select { flex: 1; min-width: 160px; }

.table-wrap { overflow-x: auto; }

.acoes { display: flex; gap: 4px; white-space: nowrap; }
.right  { text-align: right; }
.center { text-align: center; }
.mono   { font-variant-numeric: tabular-nums; }
.bold   { font-weight: 600; }
.text-muted { color: var(--text-muted); }
.td-main { font-weight: 500; }
.td-sub  { font-size: 11px; color: var(--text-muted); }

.estado-vazio { padding: 48px; text-align: center; color: var(--text-muted); }

.modal-lg { width: 640px; }
.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 0 16px;
}
.span-2 { grid-column: span 2; }

.mov-info-produto {
  display: flex;
  align-items: center;
  justify-content: space-between;
  background: var(--slate-100);
  border-radius: 8px;
  padding: 10px 14px;
  margin-bottom: 14px;
  font-size: 14px;
}
</style>
