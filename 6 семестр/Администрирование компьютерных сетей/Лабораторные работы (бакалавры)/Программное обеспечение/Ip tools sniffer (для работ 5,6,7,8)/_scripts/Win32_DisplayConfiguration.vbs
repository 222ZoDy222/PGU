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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DisplayConfiguration", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "BitsPerPel: " & objItem.BitsPerPel
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceName: " & objItem.DeviceName
      WScript.Echo "DisplayFlags: " & objItem.DisplayFlags
      WScript.Echo "DisplayFrequency: " & objItem.DisplayFrequency
      WScript.Echo "DitherType: " & objItem.DitherType
      WScript.Echo "DriverVersion: " & objItem.DriverVersion
      WScript.Echo "ICMIntent: " & objItem.ICMIntent
      WScript.Echo "ICMMethod: " & objItem.ICMMethod
      WScript.Echo "LogPixels: " & objItem.LogPixels
      WScript.Echo "PelsHeight: " & objItem.PelsHeight
      WScript.Echo "PelsWidth: " & objItem.PelsWidth
      WScript.Echo "SettingID: " & objItem.SettingID
      WScript.Echo "SpecificationVersion: " & objItem.SpecificationVersion
      WScript.Echo
   Next



