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
          <div class="kpi-valor">{{ dados.kpis?.total_produtos ?? '—' }}</div>
          <div class="kpi-label">Total de produtos</div>
        </div>
        <div class="kpi-card kpi-alerta">
          <div class="kpi-valor">{{ dados.kpis?.zerados ?? '—' }}</div>
          <div class="kpi-label">Sem estoque</div>
        </div>
        <div class="kpi-card kpi-aviso">
          <div class="kpi-valor">{{ dados.kpis?.abaixo_minimo ?? '—' }}</div>
          <div class="kpi-label">Abaixo do mínimo</div>
        </div>
        <div class="kpi-card kpi-destaque">
          <div class="kpi-valor">{{ fmtMoeda(dados.kpis?.valor_total_estoque) }}</div>
          <div class="kpi-label">Valor em estoque</div>
        </div>
      </div>

      <!-- Saídas 30 dias -->
      <div v-if="dados.kpis?.qtd_saidas_30d > 0" class="card saidas-banner">
        <span class="saidas-num">{{ dados.kpis.qtd_saidas_30d }} saídas</span>
        <span class="saidas-label">Saídas — últimos 30 dias</span>
      </div>

      <div class="painel-grid">
        <!-- Precisa repor -->
        <div class="card">
          <h3 class="card-titulo">⚠️ Precisa repor</h3>
          <div v-if="!dados.repor?.length" class="estado-vazio-sm">Estoque OK ✅</div>
          <div v-else class="repor-lista">
            <div v-for="p in dados.repor" :key="p.nome" class="repor-item">
              <div class="repor-nome">{{ p.nome }}</div>
              <div class="repor-falta">Falta: {{ fmtQtd(p.falta) }} {{ p.unidade }}</div>
              <span :class="['badge', p.estoque_atual <= 0 ? 'badge-red' : 'badge-orange']">
                {{ p.estoque_atual <= 0 ? 'Zerado' : 'Baixo' }}
              </span>
            </div>
          </div>
        </div>

        <!-- Vencendo -->
        <div class="card">
          <h3 class="card-titulo">🕐 Vencendo em até 10 dias</h3>
          <div v-if="!dados.vencendo?.length" class="estado-vazio-sm">Nenhum produto vencendo em breve ✅</div>
          <div v-else class="repor-lista">
            <div v-for="p in dados.vencendo" :key="p.nome" class="repor-item">
              <div class="repor-nome">{{ p.nome }}</div>
              <div class="repor-falta">Vence em {{ p.dias_restantes }} dia(s)</div>
              <span class="badge badge-red">{{ fmtData(p.validade) }}</span>
            </div>
          </div>
        </div>

        <!-- Últimas movimentações -->
        <div class="card">
          <h3 class="card-titulo">🔄 Últimas movimentações</h3>
          <div v-if="!dados.movimentacoes_recentes?.length" class="estado-vazio-sm">Sem movimentações.</div>
          <div v-else class="movs-lista">
            <div v-for="m in dados.movimentacoes_recentes" :key="m.data + m.produto" class="mov-item">
              <span class="mov-tipo">{{ tipoLabel(m.tipo) }}</span>
              <span class="mov-nome">{{ m.produto }}</span>
              <span class="mov-qtd">{{ fmtQtd(m.quantidade) }}</span>
            </div>
          </div>
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/api'

const dados      = ref({})
const carregando = ref(true)

onMounted(async () => {
  try { dados.value = await api.get('/dashboard') }
  finally { carregando.value = false }
})

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
function tipoLabel(t) {
  return { entrada: '📥', saida: '📤', ajuste: '🔧', sync_saurus: '🔄' }[t] || t
}
</script>

<style scoped>
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 16px;
  margin-bottom: 16px;
}

.kpi-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 20px;
}
.kpi-card.kpi-alerta   { border-color: #dc2626; }
.kpi-card.kpi-aviso    { border-color: #f97316; }
.kpi-card.kpi-destaque { border-color: var(--orange); }

.kpi-valor {
  font-size: 28px;
  font-weight: 700;
  color: var(--text);
  line-height: 1.1;
  margin-bottom: 4px;
}
.kpi-alerta  .kpi-valor  { color: #dc2626; }
.kpi-aviso   .kpi-valor  { color: #f97316; }
.kpi-destaque .kpi-valor { color: var(--orange); }

.kpi-label { font-size: 13px; color: var(--text-muted); }

.saidas-banner {
  display: flex; align-items: center; gap: 12px;
  margin-bottom: 16px; padding: 14px 20px;
}
.saidas-num   { font-size: 20px; font-weight: 700; color: #dc2626; }
.saidas-label { font-size: 14px; color: var(--text-muted); }

.painel-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 16px;
}

.card-titulo { font-size: 14px; font-weight: 600; margin-bottom: 12px; }

.repor-lista { display: flex; flex-direction: column; gap: 8px; }
.repor-item  { display: flex; align-items: center; gap: 8px; font-size: 13px; }
.repor-nome  { flex: 1; font-weight: 500; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.repor-falta { font-size: 12px; color: var(--text-muted); white-space: nowrap; }

.movs-lista { display: flex; flex-direction: column; gap: 6px; }
.mov-item   { display: flex; align-items: center; gap: 8px; font-size: 13px; }
.mov-tipo   { font-size: 16px; }
.mov-nome   { flex: 1; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.mov-qtd    { font-size: 12px; color: var(--text-muted); white-space: nowrap; }

.badge { display: inline-block; padding: 2px 8px; border-radius: 99px; font-size: 11px; font-weight: 600; white-space: nowrap; }
.badge-red    { background: #fee2e2; color: #991b1b; }
.badge-orange { background: #fff7ed; color: #c2410c; }

.estado-vazio    { color: var(--text-muted); padding: 40px 0; text-align: center; }
.estado-vazio-sm { color: var(--text-muted); padding: 16px 0; text-align: center; font-size: 13px; }
</style>
