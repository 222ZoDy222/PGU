On Error Resume Next

Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20

If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)

   WScript.Echo
   WScript.Echo "=========================================="
   WScript.Echo "Computer: " & strComputer
   WScript.Echo "=========================================="

   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_StartupCommand", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "Command: " & objItem.Command
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "Location: " & objItem.Location
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "SettingID: " & objItem.SettingID
      WScript.Echo "User: " & objItem.User
      WScript.Echo
   Next



