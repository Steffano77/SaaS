' Roda um comando sem abrir janela de cmd (usado pelas tarefas agendadas do servidor).
' Bug real (Jota 2, 30/10): a tarefa do pm2 resurrect deixava um cmd aberto na tela do
' caixa, e fechar essa janela pode derrubar o PanificaPro junto.
' Uso: wscript.exe rodar-escondido.vbs "C:\caminho\programa.cmd" arg1 arg2 ...
Set sh = CreateObject("WScript.Shell")
linha = ""
For Each a In WScript.Arguments
  linha = linha & " """ & a & """"
Next
sh.Run "cmd /c """ & Trim(linha) & """", 0, False
