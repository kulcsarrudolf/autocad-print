using System;
using System.Drawing.Printing;

class Program
{
    static void Main()
    {
        // Get a list of all installed printers.
        foreach (string printerName in PrinterSettings.InstalledPrinters)
        {
            Console.WriteLine(printerName);
        }
    }
}