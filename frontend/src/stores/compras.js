import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import api from '@/api'

export const useComprasStore = defineStore('compras', () => {
  const itens          = ref([])   // carrinho do pedido em andamento
  const editandoId     = ref(null) // ID do pedido sendo re-editado

  const total = computed(() =>
    itens.value.reduce((s, i) => s + (i.qtd * (i.custo || 0)), 0)
  )

  function adicionarItem(item) {
    itens.value.push({ ...item, _id: Date.now() + Math.random() })
  }

  function removerItem(_id) {
    itens.value = itens.value.filter(i => i._id !== _id)
  }

  function atualizarQtd(_id, qtd) {
    const item = itens.value.find(i => i._id === _id)
    if (item) item.qtd = parseFloat(qtd) || 0
  }

  function limpar() {
    itens.value   = []
    editandoId.value = null
  }

  function carregarPedido(pedido) {
    editandoId.value = pedido.id
    itens.value = pedido.itens.map(i => ({
      _id:     Date.now() + Math.random(),
      prodId:  i.produto_id,
      nome:    i.produto,
      unidade: i.unidade,
      qtd:     parseFloat(i.quantidade),
      custo:   parseFloat(i.custo_unitario || 0),
      isNovo:  !!i.is_novo,
      minimo:  0,
    }))
  }

  return { itens, editandoId, total, adicionarItem, removerItem, atualizarQtd, limpar, carregarPedido }
})
