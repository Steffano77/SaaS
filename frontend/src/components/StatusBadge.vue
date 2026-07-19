<template>
  <span :class="['badge', classe]">{{ texto }}</span>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({ produto: Object })

const hoje = new Date()
hoje.setHours(0, 0, 0, 0)

const { classe, texto } = computed(() => {
  const p = props.produto
  const val = p.validade ? new Date(p.validade) : null
  const vencendo = val && val <= new Date(hoje.getTime() + 10 * 86400000)

  if (p.estoque_atual <= 0)
    return { classe: 'badge-red',    texto: '🔴 Sem estoque' }
  if (p.estoque_minimo > 0 && p.estoque_atual <= p.estoque_minimo)
    return { classe: 'badge-orange', texto: '⚠️ Abaixo mín.' }
  if (vencendo)
    return { classe: 'badge-orange', texto: '🟡 Vencendo' }
  return { classe: 'badge-green',  texto: '✅ OK' }
}).value
</script>

<style scoped>
.badge { display: inline-block; padding: 3px 8px; border-radius: 99px; font-size: 11px; font-weight: 600; white-space: nowrap; }
.badge-green  { background: #dcfce7; color: #16a34a; }
.badge-red    { background: #fee2e2; color: #dc2626; }
.badge-orange { background: #fff7ed; color: #c2410c; }
</style>
