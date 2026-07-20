<template>
  <div>
    <div class="page-header">
      <h1>Relatórios</h1>
      <div style="display:flex;gap:8px;align-items:center;flex-wrap:wrap;">
        <select v-model="mes" @change="carregarMes" style="width:auto;">
          <option v-for="m in mesesDisponiveis" :key="m.valor" :value="m.valor">{{ m.label }}</option>
        </select>
        <button class="btn-ghost btn-sm" @click="exportar('produtos')">⬇ Exportar produtos</button>
        <button class="btn-ghost btn-sm" @click="exportar('movimentacoes')">⬇ Exportar movs.</button>
      </div>
    </div>

    <!-- KPIs do mês -->
    <div class="rel-kpis">
      <div class="kpi-card">
        <div class="kpi-label">Total entradas</div>
        <div class="kpi-value entrada">{{ fmtMoeda(kpis.total_entradas) }}</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-label">Total saídas</div>
        <div class="kpi-value saida">{{ fmtMoeda(kpis.total_saidas) }}</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-label">Movimentações</div>
        <div class="kpi-value">{{ kpis.qtd_movs ?? '—' }}</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-label">Produtos distintos</div>
        <div class="kpi-value">{{ kpis.prods_distintos ?? '—' }}</div>
      </div>
    </div>

    <!-- Gráficos -->
    <div class="graficos-grid">

      <!-- Movimentações da semana -->
      <div class="card">
        <div class="card-body">
          <h3 class="card-title">Movimentações — últimos 7 dias</h3>
          <div v-if="!semana.length" class="estado-vazio">Sem dados.</div>
          <div v-else class="barras-wrap">
            <div v-for="d in semana" :key="d.dia" class="barra-grupo">
              <div class="barras">
                <div
                  class="barra barra-entrada"
                  :style="{ height: pct(d.entradas, maxSemana) + '%' }"
                  :title="`Entradas: ${fmtQtd(d.entradas)}`"
                ></div>
                <div
                  class="barra barra-saida"
                  :style="{ height: pct(d.saidas, maxSemana) + '%' }"
                  :title="`Saídas: ${fmtQtd(d.saidas)}`"
                ></div>
              </div>
              <div class="barra-label">{{ d.dia }}</div>
            </div>
          </div>
          <div class="legenda">
            <span class="leg-dot entrada"></span> Entradas
            <span class="leg-dot saida"></span> Saídas
          </div>
        </div>
      </div>

      <!-- Top 5 produtos por valor -->
      <div class="card">
        <div class="card-body">
          <h3 class="card-title">Top 5 — valor em estoque</h3>
          <div v-if="!topProdutos.length" class="estado-vazio">Sem dados.</div>
          <div v-else class="top-lista">
            <div v-for="(p, i) in topProdutos" :key="p.nome" class="top-item">
              <div class="top-rank">{{ i + 1 }}</div>
              <div class="top-nome">{{ p.nome }}</div>
              <div class="top-barra-wrap">
                <div
                  class="top-barra"
                  :style="{ width: pct(p.valor, topProdutos[0].valor) + '%' }"
                ></div>
              </div>
              <div class="top-valor">{{ fmtMoeda(p.valor) }}</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Valor por categoria -->
      <div class="card">
        <div class="card-body">
          <h3 class="card-title">Valor por categoria</h3>
          <div v-if="!categorias.length" class="estado-vazio">Sem dados.</div>
          <div v-else class="cat-lista">
            <div v-for="(c, i) in categorias" :key="c.categoria" class="cat-item">
              <div class="cat-cor" :style="{ background: cores[i % cores.length] }"></div>
              <div class="cat-nome">{{ c.categoria }}</div>
              <div class="cat-barra-wrap">
                <div
                  class="cat-barra"
                  :style="{ width: pct(c.valor, totalCategorias) + '%', background: cores[i % cores.length] }"
                ></div>
              </div>
              <div class="cat-valor">{{ fmtMoeda(c.valor) }}</div>
            </div>
          </div>
        </div>
      </div>

    </div>

    <!-- Histórico de movimentações do mês -->
    <div class="card" style="margin-top:20px">
      <div class="card-body">
        <h3 class="card-title">Movimentações de {{ labelMes }}</h3>
        <div v-if="!movs.length" class="estado-vazio">Nenhuma movimentação no período.</div>
        <div v-else class="table-wrap">
          <table>
            <thead>
              <tr>
                <th class="left">Data</th>
                <th class="left">Produto</th>
                <th class="center">Tipo</th>
                <th class="right">Qtd</th>
                <th class="right">Custo unit.</th>
                <th class="right">Total</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="m in movs" :key="m.data + m.produto + m.tipo">
                <td class="text-muted" style="white-space:nowrap">{{ fmtData(m.data) }}</td>
                <td><strong>{{ m.produto }}</strong></td>
                <td class="center">
                  <span :class="['badge', tipoBadge(m.tipo)]">{{ tipoLabel(m.tipo) }}</span>
                </td>
                <td class="right mono">{{ fmtQtd(m.quantidade) }}</td>
                <td class="right mono text-muted">{{ fmtMoeda(m.custo_unit) }}</td>
                <td class="right mono bold">{{ fmtMoeda(m.valor_total) }}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import api from '@/api'

// ── Estado ──────────────────────────────────────────────────────────────────
const mes          = ref(new Date().toISOString().slice(0, 7))
const kpis         = ref({})
const movs         = ref([])
const semana       = ref([])
const topProdutos  = ref([])
const categorias   = ref([])

const cores = ['#f97316','#3b82f6','#22c55e','#a855f7','#ef4444','#eab308','#14b8a6','#ec4899']

// ── Computed ─────────────────────────────────────────────────────────────────
const maxSemana = computed(() =>
  Math.max(...semana.value.map(d => Math.max(Number(d.entradas), Number(d.saidas))), 1)
)

const totalCategorias = computed(() =>
  categorias.value.reduce((s, c) => s + Number(c.valor || 0), 0) || 1
)

const labelMes = computed(() => {
  const [ano, m] = mes.value.split('-')
  return new Date(ano, m - 1, 1).toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' })
})

const mesesDisponiveis = computed(() => {
  const result = []
  const hoje = new Date()
  for (let i = 0; i < 12; i++) {
    const d = new Date(hoje.getFullYear(), hoje.getMonth() - i, 1)
    const valor = d.toISOString().slice(0, 7)
    const label = d.toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' })
    result.push({ valor, label: label.charAt(0).toUpperCase() + label.slice(1) })
  }
  return result
})

// ── Carregamento ─────────────────────────────────────────────────────────────
async function carregarMes() {
  const data = await api.get(`/relatorios/mes?mes=${mes.value}`)
  kpis.value = data
  movs.value = data.movs || []
}

async function carregar() {
  await Promise.all([
    carregarMes(),
    api.get('/relatorios/movs-semana').then(d => { semana.value = d }),
    api.get('/relatorios/top-produtos').then(d => { topProdutos.value = d }),
    api.get('/relatorios/valor-categorias').then(d => { categorias.value = d }),
  ])
}

// ── Exportar ──────────────────────────────────────────────────────────────────
async function exportar(tipo) {
  const token = localStorage.getItem('token')
  const url = tipo === 'produtos'
    ? `/api/exportar/produtos`
    : `/api/exportar/movimentacoes?mes=${mes.value}`
  const a = document.createElement('a')
  a.href = url
  const resp = await fetch(url, { headers: { Authorization: `Bearer ${token}` } })
  const blob = await resp.blob()
  a.href = URL.createObjectURL(blob)
  a.download = tipo === 'produtos' ? 'produtos.xlsx' : `movimentacoes-${mes.value}.xlsx`
  a.click()
  URL.revokeObjectURL(a.href)
}

// ── Helpers ───────────────────────────────────────────────────────────────────
function pct(v, max) { return Math.round((Number(v || 0) / Number(max || 1)) * 100) }

function fmtMoeda(v) {
  return parseFloat(v || 0).toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })
}
function fmtQtd(v) {
  const n = parseFloat(v || 0)
  return n % 1 === 0 ? n.toFixed(0) : n.toFixed(2)
}
function fmtData(d) {
  return d ? new Date(d).toLocaleDateString('pt-BR') : '—'
}
function tipoLabel(t) {
  return { entrada: '📥 Entrada', saida: '📤 Saída', ajuste: '🔧 Ajuste', sync_saurus: '🔄 Sync' }[t] || t
}
function tipoBadge(t) {
  return { entrada: 'badge-green', saida: 'badge-red', ajuste: 'badge-orange', sync_saurus: 'badge-blue' }[t] || ''
}

onMounted(carregar)
</script>

<style scoped>
/* KPIs */
.rel-kpis {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 20px;
}
@media (max-width: 700px) { .rel-kpis { grid-template-columns: 1fr 1fr; } }

.kpi-card {
  background: var(--white);
  border-radius: 16px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.07), 0 1px 2px rgba(0,0,0,0.04);
  border: 1px solid var(--slate-100);
  transition: transform 0.2s, box-shadow 0.2s;
}
.kpi-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 8px 24px rgba(0,0,0,0.10), 0 2px 6px rgba(0,0,0,0.06);
}
.kpi-label { font-size: 12px; color: var(--text-muted); text-transform: uppercase; letter-spacing: .04em; margin-bottom: 6px; font-weight: 500; }
.kpi-value { font-size: 24px; font-weight: 800; font-variant-numeric: tabular-nums; letter-spacing: -0.5px; }
.kpi-value.entrada { color: #16a34a; }
.kpi-value.saida   { color: #dc2626; }

/* Gráficos grid */
.graficos-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 20px;
}
@media (max-width: 900px) { .graficos-grid { grid-template-columns: 1fr; } }

/* Barras de semana */
.barras-wrap {
  display: flex;
  align-items: flex-end;
  gap: 6px;
  height: 120px;
}
.barra-grupo { display: flex; flex-direction: column; align-items: center; flex: 1; gap: 4px; }
.barras { display: flex; gap: 3px; align-items: flex-end; height: 100px; }
.barra {
  width: 14px;
  border-radius: 3px 3px 0 0;
  min-height: 4px;
  transition: height .3s ease;
}
.barra-entrada { background: #22c55e; }
.barra-saida   { background: #ef4444; }
.barra-label { font-size: 11px; color: var(--text-muted); }

.legenda {
  display: flex; gap: 14px; align-items: center;
  margin-top: 10px; font-size: 12px; color: var(--text-muted);
}
.leg-dot { display: inline-block; width: 10px; height: 10px; border-radius: 50%; margin-right: 4px; }
.leg-dot.entrada { background: #22c55e; }
.leg-dot.saida   { background: #ef4444; }

/* Top produtos */
.top-lista { display: flex; flex-direction: column; gap: 10px; }
.top-item { display: flex; align-items: center; gap: 8px; font-size: 13px; }
.top-rank { width: 18px; font-weight: 700; color: var(--orange); text-align: center; }
.top-nome { flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.top-barra-wrap { width: 60px; background: var(--slate-100); border-radius: 4px; height: 6px; overflow: hidden; }
.top-barra { height: 100%; background: var(--orange); border-radius: 4px; transition: width .3s; }
.top-valor { font-variant-numeric: tabular-nums; font-weight: 600; font-size: 12px; white-space: nowrap; }

/* Categorias */
.cat-lista { display: flex; flex-direction: column; gap: 8px; }
.cat-item { display: flex; align-items: center; gap: 8px; font-size: 13px; }
.cat-cor { width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }
.cat-nome { flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.cat-barra-wrap { width: 60px; background: var(--slate-100); border-radius: 4px; height: 6px; overflow: hidden; }
.cat-barra { height: 100%; border-radius: 4px; transition: width .3s; }
.cat-valor { font-variant-numeric: tabular-nums; font-weight: 600; font-size: 12px; white-space: nowrap; }

/* Tabela */
.right   { text-align: right; }
.center  { text-align: center; }
.left    { text-align: left; }
.mono    { font-variant-numeric: tabular-nums; }
.bold    { font-weight: 600; }
.text-muted { color: var(--text-muted); }
.estado-vazio { padding: 32px; text-align: center; color: var(--text-muted); font-size: 14px; }
</style>
