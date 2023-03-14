On Error Resume Next
Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20
strcomputer=wscript.arguments(0)
   WScript.Echo
   WScript.Echo "=========================================="
   WScript.Echo "Computer: " & strComputer
   WScript.Echo "=========================================="
   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_ComputerSystem", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)
   For Each objItem In colItems
     WScript.Echo "ComputerName: " & objItem.Name
      'WScript.Echo "Domain: " & objItem.Domain
      WScript.Echo "UserName: " & objItem.UserName
   Next
