const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const ExcelJS = require('exceljs');
const db = require('../database/connection');

const PAPEIS_VALIDOS = ['atendente', 'caixa', 'gerente'];

// Dono de verdade (login com e-mail/senha) nunca tem "atendente_nome" no token — só
// quem entrou por PIN/login-caixa tem essa marca. Gestor é um atributo separado do
// role (atendente/caixa/gerente): controla quem pode mexer na tela de Equipe por
// completo (cadastrar, editar dado sensível), independente do papel que a pessoa
// tem no caixa no dia a dia.
function souDonoOuGestor(req) {
  if (!req.padaria.atendente_nome) return true; // login de dono de verdade
  return !!req.padaria.atendente_gestor;
}

exports.listar = async (req, res) => {
  const [rows] = await db.query(
    `SELECT id, nome, role, gestor, ativo, criado_em, (pin_hash IS NOT NULL) AS tem_pin
     FROM atendentes WHERE padaria_id = ? AND ativo = 1 ORDER BY nome`,
    [req.padaria.id]
  );
  res.json(rows);
};

exports.criar = async (req, res) => {
  const nome = String(req.body.nome || '').trim();
  const pin = String(req.body.pin || '').trim();
  const role = PAPEIS_VALIDOS.includes(req.body.role) ? req.body.role : 'atendente';
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  if (!/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'O PIN precisa ter exatamente 4 números.' });

  const pin_hash = await bcrypt.hash(pin, 10);
  const [r] = await db.query(
    `INSERT INTO atendentes (padaria_id, nome, pin_hash, role) VALUES (?, ?, ?, ?)`,
    [req.padaria.id, nome, pin_hash, role]
  );
  res.status(201).json({ id: r.insertId, nome, role });
};

// Troca o papel de um atendente já cadastrado
exports.trocarPapel = async (req, res) => {
  const role = req.body.role;
  if (!PAPEIS_VALIDOS.includes(role)) return res.status(400).json({ erro: 'Papel inválido.' });
  await db.query(`UPDATE atendentes SET role = ? WHERE id = ? AND padaria_id = ?`, [role, req.params.id, req.padaria.id]);
  res.json({ ok: true });
};

// Liga/desliga o atributo "gestor" — só o dono de verdade mexe nisso, pra evitar que
// um gestor fique criando outros gestores sem o dono saber.
exports.trocarGestor = async (req, res) => {
  if (req.padaria.atendente_nome) return res.status(403).json({ erro: 'Só o dono pode definir quem é gestor.' });
  const gestor = req.body.gestor ? 1 : 0;
  await db.query(`UPDATE atendentes SET gestor = ? WHERE id = ? AND padaria_id = ?`, [gestor, req.params.id, req.padaria.id]);
  res.json({ ok: true });
};

// Dados completos (básico + sensível) de um funcionário — só dono ou gestor.
exports.buscarDados = async (req, res) => {
  if (!souDonoOuGestor(req)) return res.status(403).json({ erro: 'Só o dono ou um gestor podem ver esses dados.' });
  const [[a]] = await db.query(
    `SELECT id, nome, role, gestor, ativo, telefone, email, cargo, data_admissao,
       cpf, rg, data_nascimento, endereco, pix_chave, dados_bancarios, salario, contato_emergencia
     FROM atendentes WHERE id = ? AND padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  if (!a) return res.status(404).json({ erro: 'Não encontrado.' });
  res.json(a);
};

// Atualiza os dados de RH (básico + sensível) — só dono ou gestor.
exports.atualizarDados = async (req, res) => {
  if (!souDonoOuGestor(req)) return res.status(403).json({ erro: 'Só o dono ou um gestor podem editar esses dados.' });
  const campos = ['telefone', 'email', 'cargo', 'data_admissao', 'cpf', 'rg', 'data_nascimento',
    'endereco', 'pix_chave', 'dados_bancarios', 'salario', 'contato_emergencia'];
  const sets = []; const vals = [];
  for (const c of campos) {
    if (req.body[c] !== undefined) { sets.push(`${c} = ?`); vals.push(req.body[c] || null); }
  }
  if (!sets.length) return res.status(400).json({ erro: 'Nenhum campo pra atualizar.' });
  vals.push(req.params.id, req.padaria.id);
  await db.query(`UPDATE atendentes SET ${sets.join(', ')} WHERE id = ? AND padaria_id = ?`, vals);
  res.json({ ok: true });
};

// Exporta os dados de UM funcionário (básico + sensível) pra Excel — pro contador/RH,
// ou pra levar pra outra ferramenta de folha de pagamento. Só dono ou gestor.
exports.exportarExcel = async (req, res) => {
  if (!souDonoOuGestor(req)) return res.status(403).json({ erro: 'Só o dono ou um gestor podem exportar dados de funcionário.' });

  const [lista] = await db.query(
    `SELECT nome, role, gestor, ativo, telefone, email, cargo, data_admissao,
       cpf, rg, data_nascimento, endereco, pix_chave, dados_bancarios, salario, contato_emergencia
     FROM atendentes WHERE id = ? AND padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  if (!lista.length) return res.status(404).json({ erro: 'Funcionário não encontrado.' });

  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Funcionário');
  ws.columns = [
    { header: 'Nome', key: 'nome', width: 28 },
    { header: 'Papel', key: 'role', width: 14 },
    { header: 'Gestor', key: 'gestor', width: 10 },
    { header: 'Ativo', key: 'ativo', width: 10 },
    { header: 'Telefone', key: 'telefone', width: 18 },
    { header: 'E-mail', key: 'email', width: 26 },
    { header: 'Cargo', key: 'cargo', width: 22 },
    { header: 'Data de admissão', key: 'data_admissao', width: 18 },
    { header: 'CPF', key: 'cpf', width: 16 },
    { header: 'RG', key: 'rg', width: 16 },
    { header: 'Data de nascimento', key: 'data_nascimento', width: 18 },
    { header: 'Endereço', key: 'endereco', width: 32 },
    { header: 'Chave PIX', key: 'pix_chave', width: 22 },
    { header: 'Dados bancários', key: 'dados_bancarios', width: 30 },
    { header: 'Salário', key: 'salario', width: 14 },
    { header: 'Contato de emergência', key: 'contato_emergencia', width: 26 },
  ];
  ws.getRow(1).font = { bold: true };
  const fmtData = d => d ? new Date(d).toLocaleDateString('pt-BR') : '';
  lista.forEach(a => {
    ws.addRow({
      nome: a.nome,
      role: { atendente: 'Atendente', caixa: 'Caixa', gerente: 'Gerente' }[a.role] || a.role,
      gestor: a.gestor ? 'Sim' : 'Não',
      ativo: a.ativo ? 'Sim' : 'Não',
      telefone: a.telefone || '',
      email: a.email || '',
      cargo: a.cargo || '',
      data_admissao: fmtData(a.data_admissao),
      cpf: a.cpf || '',
      rg: a.rg || '',
      data_nascimento: fmtData(a.data_nascimento),
      endereco: a.endereco || '',
      pix_chave: a.pix_chave || '',
      dados_bancarios: a.dados_bancarios || '',
      salario: a.salario != null ? parseFloat(a.salario) : '',
      contato_emergencia: a.contato_emergencia || '',
    });
  });

  const nomeSanitizado = lista[0].nome.normalize('NFD').replace(/[̀-ͯ]/g, '').replace(/[^a-zA-Z0-9]+/g, '-');
  const nomeArquivo = `${nomeSanitizado}-${new Date().toISOString().slice(0, 10)}.xlsx`;
  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.setHeader('Content-Disposition', `attachment; filename="${nomeArquivo}"`);
  await wb.xlsx.write(res);
  res.end();
};

// Login por PIN — identifica QUEM está usando o tablet agora e devolve um token
// próprio (separado do token da padaria) usado pra liberar ações restritas por papel
// (excluir item, cancelar comanda, abrir caixa).
exports.loginPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const pin = String(req.body.pin || '').trim();
  if (!/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'PIN inválido.' });

  const [atendentes] = await db.query(
    `SELECT id, nome, role, pin_hash FROM atendentes WHERE padaria_id = ? AND ativo = 1 AND pin_hash IS NOT NULL`,
    [padaria_id]
  );
  let encontrado = null;
  for (const a of atendentes) {
    if (await bcrypt.compare(pin, a.pin_hash)) { encontrado = a; break; }
  }
  if (!encontrado) return res.status(401).json({ erro: 'PIN incorreto.' });

  const secret = process.env.JWT_SECRET;
  const token = jwt.sign(
    { tipo: 'atendente', id: encontrado.id, padaria_id, nome: encontrado.nome, role: encontrado.role },
    secret,
    { expiresIn: '12h' }
  );
  res.json({ ok: true, token, nome: encontrado.nome, role: encontrado.role });
};

// Confere o PIN de um atendente (usado antes de abrir caixa em nome dele)
exports.verificarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const pin = String(req.body.pin || '').trim();
  const [[atendente]] = await db.query(
    `SELECT id, pin_hash FROM atendentes WHERE id = ? AND padaria_id = ? AND ativo = 1`,
    [req.params.id, padaria_id]
  );
  if (!atendente || !atendente.pin_hash) return res.status(404).json({ erro: 'Atendente não encontrado.' });

  const ok = await bcrypt.compare(pin, atendente.pin_hash);
  if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
  res.json({ ok: true });
};

exports.remover = async (req, res) => {
  await db.query(
    `UPDATE atendentes SET ativo = 0 WHERE id = ? AND padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
};
