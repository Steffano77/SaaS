<template>
  <Teleport to="body">
    <div v-if="msg" :class="['toast', tipo]">{{ msg }}</div>
  </Teleport>
</template>

<script setup>
import { ref } from 'vue'

const msg  = ref('')
const tipo = ref('')
let timer  = null

function mostrar(texto, t = '') {
  msg.value  = texto
  tipo.value = t
  clearTimeout(timer)
  timer = setTimeout(() => { msg.value = '' }, 3000)
}

defineExpose({ mostrar })
</script>
