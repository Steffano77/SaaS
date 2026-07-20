<template>
  <div v-if="auth.logado" class="app-layout">
    <SidebarNav />
    <main class="main-content">
      <RouterView />
    </main>
  </div>
  <div v-else>
    <RouterView />
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'
import SidebarNav from '@/components/SidebarNav.vue'

const auth = useAuthStore()
onMounted(() => auth.carregarPerfil())
</script>
