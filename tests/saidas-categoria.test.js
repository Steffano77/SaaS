const { appPronto, request } = require('./helpers/testApp');
const { criarPadariaPremium, opCaixa } = require('./helpers/fixtures');

// Tela Saídas do estoque: cada saída vem com a categoria do produto, pro filtro
// "Categorias" (pedido do estoque: imprimir só as categorias que precisa).
describe('Saídas do mês com categoria', () => {
  test('saída traz a categoria do produto e não inclui venda do caixa nem produção', async () => {
    const app = await appPronto();
    const { token } = await criarPadariaPremium(app, request);
    const auth = r => r.set('Authorization', `Bearer ${token}`);
    const cat = await auth(request(app).post('/api/categorias')).send({ nome: 'Embalagens' });
    expect(cat.status).toBe(201);
    const p1 = await auth(request(app).post('/api/produtos')).send({ nome: 'Caixa pizza', unidade: 'un', categoria_id: cat.body.id, estoque_atual: 10, custo_medio: 2 });
    const p2 = await auth(request(app).post('/api/produtos')).send({ nome: 'Farinha', unidade: 'kg', estoque_atual: 10, custo_medio: 3 });
    expect(p1.status).toBeLessThan(300);
    expect(p2.status).toBeLessThan(300);
    const hoje = new Date().toISOString().slice(0, 10);
    for (const p of [p1, p2]) {
      const m = await auth(request(app).post('/api/movimentacoes')).send({ produto_id: p.body.id, tipo: 'saida', quantidade: 1, observacao: 'Saída para loja 2', data: hoje });
      expect(m.status).toBeLessThan(300);
    }
    // Venda no caixa também baixa o estoque ("Comanda <nº>"), mas não é saída do estoque.
    const caixa = await auth(request(app).post('/api/caixa/abrir')).send({ ...opCaixa(token), valor_abertura: 0, nome: 'Caixa Saídas Cat' });
    const c = await auth(request(app).post('/api/comandas')).send({ identificador: '501' });
    await auth(request(app).post(`/api/comandas/${c.body.id}/itens`)).send({ produto_id: p1.body.id, quantidade: 1, preco_unitario: 5 });
    const f = await auth(request(app).post(`/api/comandas/${c.body.id}/fechar`)).send({ caixa_id: caixa.body.id, pagamentos: [{ forma_pagamento: 'Pix', valor: 5 }] });
    expect(f.status).toBe(200);

    // Ingrediente gasto em produção também não é saída do estoque pra ela.
    await auth(request(app).post('/api/movimentacoes')).send({ produto_id: p2.body.id, tipo: 'saida', quantidade: 1, observacao: 'Produção #7 — Farinha', data: hoje });

    const r = await auth(request(app).get(`/api/saidas/recentes?mes=${hoje.slice(0, 7)}`));
    expect(r.body).toHaveLength(2);
    expect(r.body.some(x => /^(Comanda |Produção #)/.test(x.observacao || ''))).toBe(false);
    expect(r.status).toBe(200);
    const porProduto = Object.fromEntries(r.body.map(x => [x.produto, x.categoria]));
    expect(porProduto['Caixa pizza']).toBe('Embalagens');
    expect(porProduto['Farinha']).toBe('Sem categoria');
  });
});
