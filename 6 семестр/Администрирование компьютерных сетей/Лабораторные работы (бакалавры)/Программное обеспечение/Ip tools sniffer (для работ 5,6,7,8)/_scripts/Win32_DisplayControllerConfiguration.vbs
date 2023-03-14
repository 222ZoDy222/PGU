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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DisplayControllerConfiguration", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "BitsPerPixel: " & objItem.BitsPerPixel
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "ColorPlanes: " & objItem.ColorPlanes
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceEntriesInAColorTable: " & objItem.DeviceEntriesInAColorTable
      WScript.Echo "DeviceSpecificPens: " & objItem.DeviceSpecificPens
      WScript.Echo "HorizontalResolution: " & objItem.HorizontalResolution
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "RefreshRate: " & objItem.RefreshRate
      WScript.Echo "ReservedSystemPaletteEntries: " & objItem.ReservedSystemPaletteEntries
      WScript.Echo "SettingID: " & objItem.SettingID
      WScript.Echo "SystemPaletteEntries: " & objItem.SystemPaletteEntries
      WScript.Echo "VerticalResolution: " & objItem.VerticalResolution
      WScript.Echo "VideoMode: " & objItem.VideoMode
      WScript.Echo
   Next



