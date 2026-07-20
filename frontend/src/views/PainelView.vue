<template>
  <div>
    <div class="page-header">
      <h1>Painel</h1>
    </div>

    <div v-if="carregando" class="estado-vazio">Carregando…</div>

    <template v-else>
      <!-- KPIs -->
      <div class="kpi-grid">
        <div class="kpi-card">
          <div class="kpi-value" style="color:var(--navy)">{{ dados.kpis?.total_produtos ?? '—' }}</div>
          <div class="kpi-label">Total de produtos</div>
        </div>

        <div class="kpi-card kpi-clickable" @click="irEstoque('zerado')">
          <div class="kpi-value" style="color:var(--red-500)">{{ dados.kpis?.zerados ?? '—' }}</div>
          <div class="kpi-label">Sem estoque</div>
          <div class="kpi-hint">Ver produtos →</div>
        </div>

        <div class="kpi-card kpi-clickable" @click="irEstoque('minimo')">
          <div class="kpi-value" style="color:var(--yellow-500)">{{ dados.kpis?.abaixo_minimo ?? '—' }}</div>
          <div class="kpi-label">Abaixo do mínimo</div>
          <div class="kpi-hint">Ver produtos →</div>
        </div>

        <div class="kpi-card" style="position:relative">
          <button class="btn-olho" @click="valorVisivel = !valorVisivel" :title="valorVisivel ? 'Ocultar valor' : 'Mostrar valor'">
            <svg v-if="valorVisivel" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
            <svg v-else width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/><path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
          </button>
          <div class="kpi-value" style="color:var(--orange);font-size:26px;letter-spacing:-0.5px">
            {{ valorVisivel ? fmtMoeda(dados.kpis?.valor_total_estoque) : '••••••' }}
          </div>
          <div class="kpi-label">Valor em estoque</div>
        </div>

        <div v-if="dados.kpis?.qtd_saidas_30d > 0" class="kpi-card kpi-clickable kpi-saidas" @click="irSaidas">
          <div style="display:flex;align-items:center;justify-content:space-between">
            <div>
              <div class="kpi-value" style="color:var(--red-500);font-size:26px;letter-spacing:-0.5px">
                {{ dados.kpis.qtd_saidas_30d }} saídas
              </div>
              <div class="kpi-label">Saídas — últimos 30 dias</div>
            </div>
            <div class="kpi-hint" style="font-size:13px">Ver detalhes →</div>
          </div>
        </div>
      </div>

      <div class="painel-grid">
        <!-- Precisa repor -->
        <div class="card">
          <div class="card-body">
            <h3 class="card-titulo">⚠️ Precisa repor</h3>
            <div v-if="!dados.repor?.length" class="estado-vazio-sm">Nenhum produto para repor ✅</div>
            <div v-else class="repor-lista">
              <div v-for="p in dados.repor" :key="p.nome" class="repor-item">
                <div>
                  <div class="repor-item-name">{{ p.nome }}</div>
                  <div class="repor-item-sub">Falta: <b>{{ fmtQtd(p.falta) }} {{ p.unidade }}</b></div>
                </div>
                <span :class="['badge', p.estoque_atual <= 0 ? 'badge-zero' : 'badge-min']">
                  {{ p.estoque_atual <= 0 ? '🔴 Zerado' : '⚠️ Baixo' }}
                </span>
              </div>
            </div>
          </div>
        </div>

        <!-- Vencendo -->
        <div class="card">
          <div class="card-body">
            <h3 class="card-titulo">🕐 Vencendo em até 10 dias</h3>
            <div v-if="!dados.vencendo?.length" class="estado-vazio-sm">Nenhum produto vencendo em breve ✅</div>
            <div v-else class="repor-lista">
              <div v-for="p in dados.vencendo" :key="p.nome" class="repor-item">
                <div>
                  <div class="repor-item-name">{{ p.nome }}</div>
                  <div class="repor-item-sub">Vence: <b>{{ fmtData(p.validade) }}</b></div>
                </div>
                <span class="badge badge-validade">{{ p.dias_restantes }}d</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Últimas movimentações -->
        <div class="card">
          <div class="card-body" style="padding-bottom:0">
            <h3 class="card-titulo">🔄 Últimas movimentações</h3>
          </div>
          <div v-if="!movimentacoes.length" class="estado-vazio-sm" style="padding:24px;text-align:center">Sem movimentações.</div>
          <div v-else>
            <div v-for="m in movimentacoes" :key="m.id || (m.data + m.produto)" class="mov-row">
              <span class="mov-icon">{{ tipoIcon(m.tipo) }}</span>
              <div class="mov-info">
                <div class="mov-nome">{{ m.produto || m.produto_nome || '—' }}</div>
                <div class="mov-sub">{{ fmtDataHora(m.data) }} · {{ m.observacao || m.tipo }}</div>
              </div>
              <div class="mov-qtd" :style="{ color: corTipo(m.tipo) }">
                {{ prefixoTipo(m.tipo) }}{{ fmtQtd(m.quantidade) }} {{ m.unidade || '' }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import api from '@/api'

const router     = useRouter()
const dados      = ref({})
const movimentacoes = ref([])
const carregando = ref(true)
const valorVisivel = ref(true)

onMounted(async () => {
  try {
    dados.value = await api.get('/dashboard')
    try {
      const movs = await api.get('/movimentacoes?limit=10')
      movimentacoes.value = movs || []
    } catch {}
  } finally {
    carregando.value = false
  }
})

function irEstoque(filtro) {
  router.push({ path: '/estoque', query: { alerta: filtro } })
}
function irSaidas() {
  router.push('/estoque')
}

function fmtMoeda(v) {
  if (v == null) return '—'
  return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(v)
}
function fmtQtd(v) {
  const n = parseFloat(v || 0)
  return n % 1 === 0 ? n.toFixed(0) : n.toFixed(2)
}
function fmtData(d) {
  return d ? new Date(d).toLocaleDateString('pt-BR') : '—'
}
function fmtDataHora(d) {
  if (!d) return '—'
  return new Date(d).toLocaleDateString('pt-BR', { day: '2-digit', month: '2-digit' })
}
function tipoIcon(t) {
  return { entrada: '📥', saida: '📤', ajuste: '⚙️', sync_saurus: '🔄' }[t] || '📋'
}
function corTipo(t) {
  return t === 'entrada' ? '#16a34a' : t === 'ajuste' ? '#2563eb' : '#dc2626'
}
function prefixoTipo(t) {
  return t === 'entrada' ? '+' : t === 'ajuste' ? '~' : '−'
}
</script>

<style scoped>
/* KPI Grid */
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 16px;
  margin-bottom: 20px;
}

.kpi-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 20px;
  transition: box-shadow 0.2s;
}
.kpi-card.kpi-clickable {
  cursor: pointer;
}
.kpi-card.kpi-clickable:hover {
  box-shadow: 0 4px 16px rgba(0,0,0,0.1);
}
.kpi-card.kpi-saidas {
  grid-column: span 2;
}

.kpi-value {
  font-size: 28px;
  font-weight: 700;
  line-height: 1.1;
  margin-bottom: 4px;
}
.kpi-label { font-size: 13px; color: var(--text-muted); }
.kpi-hint  { font-size: 12px; color: var(--orange); margin-top: 6px; font-weight: 500; }

.btn-olho {
  position: absolute; top: 10px; right: 10px;
  background: rgba(0,0,0,0.06); border: none; cursor: pointer;
  color: var(--slate-500); padding: 6px; border-radius: 8px;
  line-height: 1; display: flex; align-items: center; justify-content: center;
}
.btn-olho:hover { background: rgba(0,0,0,0.1); }

/* Painel grid */
.painel-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.card-titulo {
  font-size: 14px; font-weight: 600; margin-bottom: 12px;
}

/* Repor / Vencendo */
.repor-lista { display: flex; flex-direction: column; }
.repor-item {
  display: flex; align-items: center; justify-content: space-between;
  gap: 10px; padding: 8px 0;
  border-bottom: 1px solid var(--slate-100);
}
.repor-item:last-child { border-bottom: none; }
.repor-item-name { font-size: 14px; font-weight: 600; color: var(--slate-800); }
.repor-item-sub  { font-size: 12px; color: var(--slate-400); margin-top: 2px; }

/* Movimentações */
.mov-row {
  display: flex; align-items: center; gap: 12px;
  padding: 10px 16px; border-bottom: 1px solid var(--slate-100);
}
.mov-row:last-child { border-bottom: none; }
.mov-icon { font-size: 18px; flex-shrink: 0; }
.mov-info { flex: 1; min-width: 0; }
.mov-nome { font-size: 13px; font-weight: 600; color: var(--slate-800); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.mov-sub  { font-size: 12px; color: var(--slate-500); }
.mov-qtd  { font-size: 13px; font-weight: 700; white-space: nowrap; }

.estado-vazio    { color: var(--text-muted); padding: 40px 0; text-align: center; }
.estado-vazio-sm { color: var(--text-muted); font-size: 14px; }

/* Badges */
.badge { display: inline-block; padding: 3px 9px; border-radius: 20px; font-size: 11px; font-weight: 600; white-space: nowrap; }
.badge-zero     { background: #fee2e2; color: #991b1b; }
.badge-min      { background: #fef9c3; color: #854d0e; }
.badge-validade { background: #ffedd5; color: #9a3412; }

@media (max-width: 768px) {
  .kpi-card.kpi-saidas { grid-column: span 1; }
}
</style>
