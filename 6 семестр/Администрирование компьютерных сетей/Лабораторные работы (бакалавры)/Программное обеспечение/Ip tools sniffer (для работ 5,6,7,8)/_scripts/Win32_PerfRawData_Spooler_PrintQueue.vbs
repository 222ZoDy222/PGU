If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next

Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20


   WScript.Echo
   WScript.Echo "=========================================="
   WScript.Echo "Computer: " & strComputer
   WScript.Echo "=========================================="

   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PerfRawData_Spooler_PrintQueue", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "AddNetworkPrinterCalls: " & objItem.AddNetworkPrinterCalls
      WScript.Echo "BytesPrintedPersec: " & objItem.BytesPrintedPersec
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "EnumerateNetworkPrinterCalls: " & objItem.EnumerateNetworkPrinterCalls
      WScript.Echo "Frequency_Object: " & objItem.Frequency_Object
      WScript.Echo "Frequency_PerfTime: " & objItem.Frequency_PerfTime
      WScript.Echo "Frequency_Sys100NS: " & objItem.Frequency_Sys100NS
      WScript.Echo "JobErrors: " & objItem.JobErrors
      WScript.Echo "Jobs: " & objItem.Jobs
      WScript.Echo "JobsSpooling: " & objItem.JobsSpooling
      WScript.Echo "MaxJobsSpooling: " & objItem.MaxJobsSpooling
      WScript.Echo "MaxReferences: " & objItem.MaxReferences
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "NotReadyErrors: " & objItem.NotReadyErrors
      WScript.Echo "OutofPaperErrors: " & objItem.OutofPaperErrors
      WScript.Echo "References: " & objItem.References
      WScript.Echo "Timestamp_Object: " & objItem.Timestamp_Object
      WScript.Echo "Timestamp_PerfTime: " & objItem.Timestamp_PerfTime
      WScript.Echo "Timestamp_Sys100NS: " & objItem.Timestamp_Sys100NS
      WScript.Echo "TotalJobsPrinted: " & objItem.TotalJobsPrinted
      WScript.Echo "TotalPagesPrinted: " & objItem.TotalPagesPrinted
      WScript.Echo
   Next



