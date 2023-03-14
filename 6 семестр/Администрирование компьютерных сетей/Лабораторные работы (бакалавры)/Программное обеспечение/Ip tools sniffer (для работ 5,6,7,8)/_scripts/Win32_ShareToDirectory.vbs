On Error Resume Next

Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20
If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments.item(0)

   WScript.Echo 
   WScript.Echo "=========================================="
   WScript.Echo "Computer: " & strComputer
   WScript.Echo "=========================================="

   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ShareToDirectory", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Share: " & objItem.Share
      WScript.Echo "SharedElement: " & objItem.SharedElement
      WScript.Echo 
   Next
