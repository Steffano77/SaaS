# Abre a gaveta de dinheiro mandando o comando ESC/POS direto pra impressora térmica
# (ESC p 0 25 250 — pulso no pino 2), sem imprimir nada. Usa o spooler do Windows em
# modo RAW, então funciona com impressora USB, de rede ou compartilhada (\\PC\nome).
# Teste: powershell -ExecutionPolicy Bypass -File scripts\abrir-gaveta.ps1 -Impressora "POS-80C"
param([Parameter(Mandatory = $true)][string]$Impressora)

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class GavetaRaw {
  [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
  public class DOCINFO { public string pDocName; public string pOutputFile; public string pDataType; }
  [DllImport("winspool.drv", CharSet = CharSet.Unicode, SetLastError = true)] public static extern bool OpenPrinter(string n, out IntPtr h, IntPtr d);
  [DllImport("winspool.drv", SetLastError = true)] public static extern bool ClosePrinter(IntPtr h);
  [DllImport("winspool.drv", CharSet = CharSet.Unicode, SetLastError = true)] public static extern bool StartDocPrinter(IntPtr h, int l, DOCINFO di);
  [DllImport("winspool.drv", SetLastError = true)] public static extern bool EndDocPrinter(IntPtr h);
  [DllImport("winspool.drv", SetLastError = true)] public static extern bool StartPagePrinter(IntPtr h);
  [DllImport("winspool.drv", SetLastError = true)] public static extern bool EndPagePrinter(IntPtr h);
  [DllImport("winspool.drv", SetLastError = true)] public static extern bool WritePrinter(IntPtr h, byte[] b, int c, out int w);
  public static string Enviar(string impressora, byte[] dados) {
    IntPtr h;
    if (!OpenPrinter(impressora, out h, IntPtr.Zero)) return "ERRO: impressora nao encontrada (" + Marshal.GetLastWin32Error() + ")";
    try {
      DOCINFO di = new DOCINFO(); di.pDocName = "Gaveta"; di.pDataType = "RAW";
      if (!StartDocPrinter(h, 1, di)) return "ERRO: StartDoc (" + Marshal.GetLastWin32Error() + ")";
      StartPagePrinter(h);
      int w; bool ok = WritePrinter(h, dados, dados.Length, out w);
      EndPagePrinter(h); EndDocPrinter(h);
      return ok ? "OK" : "ERRO: WritePrinter (" + Marshal.GetLastWin32Error() + ")";
    } finally { ClosePrinter(h); }
  }
}
"@

[byte[]]$pulso = 0x1B, 0x70, 0x00, 0x19, 0xFA
$r = [GavetaRaw]::Enviar($Impressora, $pulso)
Write-Output $r
if ($r -ne "OK") { exit 1 }
