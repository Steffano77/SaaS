<template>
  <div id="shell">
    <SidebarNav v-if="auth.logado" />
    <main :class="auth.logado ? 'com-sidebar' : ''">
      <RouterView />
    </main>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import SidebarNav from '@/components/SidebarNav.vue'

const auth = useAuthStore()
onMounted(() => auth.carregarPerfil())
</script>
