<template>
  <div>
    <div class="page-header">
      <h1>Compras</h1>
    </div>

    <div class="compras-layout">
      <!-- ── Coluna esquerda: formulário + carrinho ── -->
      <div class="coluna-form">

        <!-- Lista de reposição -->
        <div v-if="paraRepor.length" class="card repor-card">
          <p class="repor-titulo">⚠️ Produtos para repor ({{ paraRepor.length }})</p>
          <div class="repor-lista">
            <div v-for="p in paraRepor" :key="p.id" class="repor-item">
              <div>
                <span :class="p.estoque_atual <= 0 ? 'badge badge-red' : 'badge badge-orange'">
                  {{ p.estoque_atual <= 0 ? 'Zerado' : 'Baixo' }}
                </span>
                <span class="repor-nome">{{ p.nome }}</span>
              </div>
              <button class="btn btn-ghost btn-sm" @click="adicionarDaRepor(p)">+ Adicionar</button>
            </div>
          </div>
        </div>

        <!-- Header do pedido -->
        <div class="card">
          <div class="form-row">
            <div class="form-group">
              <label>Fornecedor</label>
              <select v-model="fornecedorId">
                <option value="">— Sem fornecedor —</option>
                <option v-for="f in fornecedores" :key="f.id" :value="f.id" :data-tel="f.telefone">
                  {{ f.nome }}
                </option>
              </select>
            </div>
            <div class="form-group" style="max-width:160px">
              <label>Data</label>
              <input v-model="dataCompra" type="date" />
            </div>
          </div>

          <!-- Adicionar item -->
          <div class="add-item-form">
            <div class="form-group" style="flex:2;position:relative">
              <label>Produto</label>
              <input
                v-model="prodTexto"
                placeholder="Buscar produto…"
                @input="filtrarProdutos"
                @focus="filtrarProdutos"
                @blur="fecharAutoComplete"
                autocomplete="off"
              />
              <div v-if="autoCompleteAberto && sugestoes.length" class="autocomplete">
                <div
                  v-for="s in sugestoes" :key="s.id"
                  class="autocomplete-item"
                  @mousedown.prevent="selecionarProduto(s)"
                >
                  {{ s.nome }}
                  <span class="text-muted" style="font-size:11px">{{ s.unidade }}</span>
                </div>
                <div
                  v-if="prodTexto.length >= 2"
                  class="autocomplete-item autocomplete-novo"
                  @mousedown.prevent="selecionarNovo()"
                >
                  ＋ Criar produto novo "{{ prodTexto }}"
                </div>
              </div>
            </div>

            <div v-if="isNovo" class="form-group">
              <label>Unid. (novo)</label>
              <select v-model="itemUnidade">
                <option v-for="u in unidades" :key="u" :value="u">{{ u }}</option>
              </select>
            </div>

            <div class="form-group" style="max-width:90px">
              <label>Qtd</label>
              <input v-model.number="itemQtd" type="number" min="0.001" step="any" ref="inputQtd" />
            </div>
            <div class="form-group" style="max-width:100px">
              <label>Custo (R$)</label>
              <input v-model.number="itemCusto" type="number" min="0" step="0.01" />
            </div>
            <div v-if="isNovo" class="form-group" style="max-width:80px">
              <label>Mínimo</label>
              <input v-model.number="itemMinimo" type="number" min="0" />
            </div>

            <button class="btn btn-primary" style="align-self:flex-end;margin-bottom:14px" @click="adicionarItem">
              + Item
            </button>
          </div>

          <!-- Carrinho -->
          <div v-if="compras.itens.length" class="carrinho">
            <div class="carrinho-header">
              <span>Itens do pedido</span>
              <span class="carrinho-total">Total: <strong>{{ fmtMoeda(compras.total) }}</strong></span>
            </div>
            <div v-for="item in compras.itens" :key="item._id" class="carrinho-item">
              <div class="ci-nome">
                {{ item.nome }}
                <span v-if="item.isNovo" class="badge badge-orange" style="font-size:10px">novo</span>
              </div>
              <input
                class="ci-qtd"
                type="number"
                :value="item.qtd"
                min="0"
                step="any"
                @change="compras.atualizarQtd(item._id, $event.target.value)"
              />
              <span class="ci-unid">{{ item.unidade }}</span>
              <span class="ci-custo">{{ item.custo > 0 ? fmtMoeda(item.custo) + '/un' : '' }}</span>
              <button class="btn btn-danger btn-sm" @click="compras.removerItem(item._id)">✕</button>
            </div>
          </div>

          <!-- Botões de ação -->
          <div v-if="compras.itens.length" class="acoes-pedido">
            <button class="btn btn-ghost" @click="compras.limpar()">Descartar</button>
            <button class="btn btn-ghost" @click="registrarPedido(false)" :disabled="salvando">
              Registrar
            </button>
            <button
              class="btn btn-primary"
              @click="registrarPedido(true)"
              :disabled="salvando || !fornecedorTel"
              :title="!fornecedorTel ? 'Selecione um fornecedor com telefone' : ''"
            >
              📱 Registrar e enviar WhatsApp
            </button>
          </div>
        </div>
      </div>

      <!-- ── Coluna direita: pedidos pendentes + histórico ── -->
      <div class="coluna-lista">

        <!-- Pedidos pendentes -->
        <div v-if="pendentes.length" class="card" style="margin-bottom:16px">
          <h3 class="secao-titulo">⏳ Aguardando recebimento</h3>
          <div v-for="p in pendentes" :key="p.id" class="pedido-card">
            <div class="pedido-header">
              <div>
                <strong>{{ p.fornecedor || '— Sem fornecedor —' }}</strong>
                <span class="text-muted" style="font-size:12px;margin-left:8px">{{ fmtData(p.criado_em) }}</span>
              </div>
              <span class="pedido-total">{{ fmtMoeda(p.total) }}</span>
            </div>
            <ul class="pedido-itens-lista">
              <li v-for="i in p.itens" :key="i.produto_id + i.produto">
                {{ i.produto }} — <strong>{{ fmtQtd(i.quantidade) }} {{ i.unidade }}</strong>
                <span v-if="i.custo_unitario > 0" class="text-muted"> · {{ fmtMoeda(i.custo_unitario) }}/un</span>
              </li>
            </ul>
            <div class="pedido-acoes">
              <button class="btn btn-ghost btn-sm" @click="editarPedido(p)">✏️ Editar</button>
              <button
                class="btn btn-ghost btn-sm"
                v-if="p.fornecedor_tel"
                @click="enviarWhatsApp(p)"
              >📱 WhatsApp</button>
              <button class="btn btn-primary btn-sm" @click="receberPedido(p)">✅ Recebi</button>
              <button class="btn btn-danger btn-sm" @click="cancelarPedido(p)">✕</button>
            </div>
          </div>
        </div>

        <!-- Histórico últimos 30 dias -->
        <div class="card">
          <h3 class="secao-titulo">📋 Últimos 30 dias</h3>
          <div v-if="!recentes.length" class="estado-vazio">Nenhuma compra registrada.</div>
          <div v-for="r in recentes" :key="r.pedido_id" class="historico-item">
            <div class="historico-header">
              <span><strong>{{ r.fornecedor }}</strong></span>
              <span class="text-muted" style="font-size:12px">{{ fmtData(r.data) }}</span>
              <span class="pedido-total">{{ fmtMoeda(r.total) }}</span>
            </div>
            <div class="text-muted" style="font-size:12px">{{ r.produtos }}</div>
          </div>
        </div>

      </div>
    </div>

    <AppToast ref="toast" />
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/api'
import AppToast from '@/components/AppToast.vue'
import { useComprasStore } from '@/stores/compras'

const compras      = useComprasStore()
const toast        = ref(null)
const inputQtd     = ref(null)
const salvando     = ref(false)

// Dados da tela
const fornecedores  = ref([])
const todosProds    = ref([])
const paraRepor     = ref([])
const pendentes     = ref([])
const recentes      = ref([])

// Header do pedido
const fornecedorId = ref('')
const dataCompra   = ref(new Date().toISOString().slice(0, 10))

// Formulário de item
const prodTexto    = ref('')
const prodId       = ref(null)
const isNovo       = ref(false)
const itemUnidade  = ref('un')
const itemQtd      = ref('')
const itemCusto    = ref(0)
const itemMinimo   = ref(0)
const sugestoes    = ref([])
const autoCompleteAberto = ref(false)

const unidades = ['un', 'kg', 'g', 'cx', 'lt', 'ml', 'pct', 'sc', 'fardo', 'bd']

const fornecedorSelecionado = computed(() =>
  fornecedores.value.find(f => f.id === Number(fornecedorId.value)) || null
)
const fornecedorTel = computed(() => fornecedorSelecionado.value?.telefone || '')

// ── Carregamento ─────────────────────────────────────────────────────────────
async function carregar() {
  const [forns, prods, zerados, abaixo, pend, rec] = await Promise.all([
    api.get('/fornecedores'),
    api.get('/produtos'),
    api.get('/produtos?alerta=zerado'),
    api.get('/produtos?alerta=minimo'),
    api.get('/compras/pedidos'),
    api.get('/compras/recentes'),
  ])
  fornecedores.value = forns
  todosProds.value   = prods
  pendentes.value    = pend
  recentes.value     = rec

  const ids = new Set(zerados.map(p => p.id))
  paraRepor.value = [...zerados, ...abaixo.filter(p => !ids.has(p.id))]
}

// ── Autocomplete ─────────────────────────────────────────────────────────────
function filtrarProdutos() {
  const txt = prodTexto.value.trim().toLowerCase()
  if (!txt) { sugestoes.value = []; autoCompleteAberto.value = false; return }
  sugestoes.value = todosProds.value
    .filter(p => p.nome.toLowerCase().includes(txt))
    .slice(0, 8)
  autoCompleteAberto.value = true
}

function fecharAutoComplete() {
  setTimeout(() => { autoCompleteAberto.value = false }, 150)
}

function selecionarProduto(p) {
  prodTexto.value  = p.nome
  prodId.value     = p.id
  isNovo.value     = false
  itemUnidade.value = p.unidade
  itemCusto.value  = parseFloat(p.custo_unitario || 0)
  autoCompleteAberto.value = false
  inputQtd.value?.focus()
}

function selecionarNovo() {
  prodId.value     = '__novo__'
  isNovo.value     = true
  itemUnidade.value = 'un'
  itemCusto.value  = 0
  autoCompleteAberto.value = false
  inputQtd.value?.focus()
}

// ── Adicionar item ────────────────────────────────────────────────────────────
function adicionarItem() {
  const nome = prodTexto.value.trim()
  if (!nome) { toast.value.mostrar('Selecione ou informe um produto.', 'erro'); return }
  if (!itemQtd.value || itemQtd.value <= 0) { toast.value.mostrar('Informe a quantidade.', 'erro'); return }

  compras.adicionarItem({
    prodId:   isNovo.value ? null : prodId.value,
    nome,
    unidade:  itemUnidade.value,
    qtd:      itemQtd.value,
    custo:    itemCusto.value,
    isNovo:   isNovo.value,
    minimo:   itemMinimo.value,
  })

  // Limpa campos
  prodTexto.value   = ''
  prodId.value      = null
  isNovo.value      = false
  itemQtd.value     = ''
  itemCusto.value   = 0
  itemMinimo.value  = 0
  itemUnidade.value = 'un'
}

function adicionarDaRepor(p) {
  prodTexto.value   = p.nome
  prodId.value      = p.id
  isNovo.value      = false
  itemUnidade.value = p.unidade
  itemCusto.value   = parseFloat(p.custo_unitario || 0)
  itemQtd.value     = ''
  inputQtd.value?.focus()
}

// ── Registrar pedido ──────────────────────────────────────────────────────────
async function registrarPedido(abrirWhats) {
  if (!compras.itens.length) return
  salvando.value = true
  try {
    const itensPayload = compras.itens.map(i => ({
      produto_id: i.isNovo ? null : i.prodId,
      nome:       i.nome,
      unidade:    i.unidade,
      quantidade: i.qtd,
      custo:      i.custo,
      minimo:     i.minimo || 0,
      isNovo:     i.isNovo,
    }))

    // Se editando: apaga o original antes
    if (compras.editandoId) {
      await api.delete(`/compras/pedidos/${compras.editandoId}`)
    }

    await api.post('/compras/pedidos', {
      fornecedor_id: fornecedorId.value || null,
      data:          dataCompra.value,
      observacao:    fornecedorSelecionado.value?.nome || null,
      itens:         itensPayload,
    })

    if (abrirWhats && fornecedorTel.value) {
      const linhas = compras.itens.map(i => `• ${i.nome}: *${fmtQtd(i.qtd)} ${i.unidade}*`)
      const msg = `*Pedido de compra* — ${dataCompra.value}\n`
        + (fornecedorSelecionado.value ? `Fornecedor: *${fornecedorSelecionado.value.nome}*\n\n` : '\n')
        + linhas.join('\n')
      const tel = fornecedorTel.value.replace(/\D/g, '')
      const url = `https://wa.me/55${tel}?text=${encodeURIComponent(msg)}`
      window.open(url, '_blank')
    }

    compras.limpar()
    toast.value.mostrar('Pedido registrado!')
    await carregar()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao registrar.', 'erro')
  } finally {
    salvando.value = false
  }
}

// ── Ações de pedido pendente ──────────────────────────────────────────────────
function editarPedido(p) {
  compras.carregarPedido(p)
  fornecedorId.value = p.fornecedor_id || ''
  window.scrollTo({ top: 0, behavior: 'smooth' })
  toast.value.mostrar('Pedido carregado. Edite e registre novamente.')
}

async function receberPedido(p) {
  if (!confirm('Confirmar recebimento? O estoque será atualizado.')) return
  try {
    await api.post(`/compras/pedidos/${p.id}/receber`)
    toast.value.mostrar('Recebimento confirmado! Estoque atualizado.')
    await carregar()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao confirmar.', 'erro')
  }
}

async function cancelarPedido(p) {
  if (!confirm(`Cancelar pedido de "${p.fornecedor || 'sem fornecedor'}"?`)) return
  try {
    await api.delete(`/compras/pedidos/${p.id}`)
    toast.value.mostrar('Pedido cancelado.')
    await carregar()
  } catch (e) {
    toast.value.mostrar(e?.erro || 'Erro ao cancelar.', 'erro')
  }
}

function enviarWhatsApp(p) {
  const linhas = p.itens.map(i => `• ${i.produto}: *${fmtQtd(i.quantidade)} ${i.unidade}*`)
  const msg = `*Pedido de compra* — ${fmtData(p.criado_em)}\n`
    + (p.fornecedor ? `Fornecedor: *${p.fornecedor}*\n\n` : '\n')
    + linhas.join('\n')
  const tel = (p.fornecedor_tel || '').replace(/\D/g, '')
  window.open(`https://wa.me/55${tel}?text=${encodeURIComponent(msg)}`, '_blank')
}

// ── Formatação ────────────────────────────────────────────────────────────────
function fmtMoeda(v) {
  return parseFloat(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}
function fmtQtd(v) {
  const n = parseFloat(v || 0)
  return n % 1 === 0 ? n.toFixed(0) : n.toFixed(3).replace(/0+$/, '')
}
function fmtData(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('pt-BR')
}

onMounted(carregar)
</script>

<style scoped>
.compras-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  align-items: start;
}

@media (max-width: 900px) {
  .compras-layout { grid-template-columns: 1fr; }
}

/* Reposição */
.repor-card { margin-bottom: 16px; }
.repor-titulo { font-weight: 600; margin-bottom: 10px; font-size: 14px; }
.repor-lista { display: flex; flex-direction: column; gap: 8px; }
.repor-item {
  display: flex; align-items: center; justify-content: space-between;
  gap: 10px; font-size: 13px;
}
.repor-nome { margin-left: 6px; }

/* Formulário */
.form-row { display: flex; gap: 12px; }
.add-item-form {
  display: flex; flex-wrap: wrap; gap: 10px; align-items: flex-start;
  border-top: 1px solid var(--border);
  padding-top: 14px; margin-top: 14px;
}

/* Autocomplete */
.autocomplete {
  position: absolute; top: 100%; left: 0; right: 0;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 8px;
  box-shadow: 0 8px 24px rgba(0,0,0,.12);
  z-index: 50;
  max-height: 240px; overflow-y: auto;
}
.autocomplete-item {
  padding: 9px 12px; cursor: pointer; font-size: 14px;
}
.autocomplete-item:hover { background: var(--slate-100); }
.autocomplete-novo { color: var(--orange); font-weight: 500; border-top: 1px solid var(--border); }

/* Carrinho */
.carrinho { margin-top: 16px; border-top: 1px solid var(--border); padding-top: 14px; }
.carrinho-header {
  display: flex; justify-content: space-between; align-items: center;
  font-weight: 600; margin-bottom: 10px; font-size: 14px;
}
.carrinho-total { color: var(--orange); }

.carrinho-item {
  display: flex; align-items: center; gap: 8px;
  padding: 6px 0; border-bottom: 1px solid var(--border);
  font-size: 14px;
}
.ci-nome { flex: 1; display: flex; align-items: center; gap: 6px; }
.ci-qtd  { width: 70px; padding: 4px 8px; text-align: right; }
.ci-unid { min-width: 30px; color: var(--text-muted); font-size: 12px; }
.ci-custo { min-width: 80px; text-align: right; color: var(--text-muted); font-size: 12px; }

.acoes-pedido {
  display: flex; gap: 8px; justify-content: flex-end;
  margin-top: 14px; flex-wrap: wrap;
}

/* Pedidos pendentes */
.secao-titulo { font-size: 14px; font-weight: 600; margin-bottom: 12px; }
.pedido-card { border: 1px solid var(--border); border-radius: 8px; padding: 14px; margin-bottom: 10px; }
.pedido-header {
  display: flex; align-items: center; justify-content: space-between;
  margin-bottom: 8px;
}
.pedido-total { font-weight: 700; color: var(--navy); }
.pedido-itens-lista { list-style: none; font-size: 13px; margin-bottom: 10px; }
.pedido-itens-lista li { padding: 2px 0; }
.pedido-acoes { display: flex; gap: 6px; flex-wrap: wrap; }

/* Histórico */
.historico-item { padding: 10px 0; border-bottom: 1px solid var(--border); }
.historico-item:last-child { border-bottom: none; }
.historico-header { display: flex; gap: 12px; align-items: center; margin-bottom: 2px; }

.estado-vazio { padding: 32px; text-align: center; color: var(--text-muted); }
.text-muted { color: var(--text-muted); }
</style>
