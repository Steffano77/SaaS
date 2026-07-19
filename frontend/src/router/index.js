import { createRouter, createWebHashHistory } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const routes = [
  { path: '/',           component: () => import('@/views/LoginView.vue'), meta: { publico: true } },
  { path: '/painel',     component: () => import('@/views/PainelView.vue') },
  { path: '/estoque',        component: () => import('@/views/EstoqueView.vue') },
  { path: '/compras',        component: () => import('@/views/ComprasView.vue') },
  { path: '/relatorios',     component: () => import('@/views/RelatoriosView.vue') },
  { path: '/fornecedores', component: () => import('@/views/FornecedoresView.vue') },
]

const router = createRouter({
  history: createWebHashHistory(),
  routes,
})

router.beforeEach(async (to) => {
  const auth = useAuthStore()
  if (!to.meta.publico && !auth.logado) return '/'
  if (to.path === '/' && auth.logado) return '/painel'
})

export default router
