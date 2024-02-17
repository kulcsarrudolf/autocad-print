Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class PrinterConfig {
    [DllImport("winspool.drv", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern bool AddForm(IntPtr hPrinter, uint Level, ref FORM_INFO_1 pForm);

    [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
    public struct FORM_INFO_1 {
        public uint Flags;
        public string pName;
        public SIZEL Size;
        public RECTL ImageableArea;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct SIZEL {
        public int cx;
        public int cy;
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct RECTL {
        public int left;
        public int top;
        public int right;
        public int bottom;
    }
}
"@ -Namespace WinApi -UsingNamespace System.Runtime.InteropServices

$printerName = "PDFCreator" # Specify the printer name
$formName = "CustomSize" # Specify the custom form name

$form = New-Object WinApi.PrinterConfig+FORM_INFO_1
$form.Flags = 0
$form.pName = $formName
$form.Size = New-Object WinApi.PrinterConfig+SIZEL
$form.Size.cx = 20000 # width in micrometers
$form.Size.cy = 10000 # height in micrometers
$form.ImageableArea = New-Object WinApi.PrinterConfig+RECTL
$form.ImageableArea.left = 0
$form.ImageableArea.top = 0
$form.ImageableArea.right = 20000 # width in micrometers
$form.ImageableArea.bottom = 10000 # height in micrometers

# Add the custom paper size to the specified printer
[WinApi.PrinterConfig]::AddForm($null, 1, [ref]$form)