<template>
  <div>
    <div class="page-header">
      <h1>Painel</h1>
    </div>

    <div v-if="carregando" class="estado-vazio">Carregando…</div>

    <div v-else class="kpi-grid">
      <div class="kpi-card">
        <div class="kpi-valor">{{ dados.total_produtos ?? '—' }}</div>
        <div class="kpi-label">Produtos ativos</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-valor">{{ dados.abaixo_minimo ?? '—' }}</div>
        <div class="kpi-label">Abaixo do mínimo</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-valor">{{ formatVal(dados.valor_estoque) }}</div>
        <div class="kpi-label">Valor em estoque</div>
      </div>
      <div class="kpi-card">
        <div class="kpi-valor">{{ dados.pedidos_pendentes ?? '—' }}</div>
        <div class="kpi-label">Pedidos pendentes</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import api from '@/api'

const dados     = ref({})
const carregando = ref(true)

onMounted(async () => {
  try { dados.value = await api.get('/dashboard') }
  finally { carregando.value = false }
})

function formatVal(v) {
  if (v == null) return '—'
  return new Intl.NumberFormat('pt-BR', { style: 'currency', currency: 'BRL' }).format(v)
}
</script>

<style scoped>
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 16px;
}

.kpi-card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  padding: 20px;
}

.kpi-valor {
  font-size: 28px;
  font-weight: 700;
  color: var(--navy);
  line-height: 1.1;
  margin-bottom: 4px;
}

.kpi-label {
  font-size: 13px;
  color: var(--text-muted);
}

.estado-vazio { color: var(--text-muted); padding: 40px 0; text-align: center; }
</style>
