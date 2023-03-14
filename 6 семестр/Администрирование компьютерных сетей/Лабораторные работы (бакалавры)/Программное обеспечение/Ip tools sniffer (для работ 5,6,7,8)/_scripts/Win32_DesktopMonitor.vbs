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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DesktopMonitor", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Availability: " & objItem.Availability
      WScript.Echo "Bandwidth: " & objItem.Bandwidth
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
      WScript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceID: " & objItem.DeviceID
      WScript.Echo "DisplayType: " & objItem.DisplayType
      WScript.Echo "ErrorCleared: " & objItem.ErrorCleared
      WScript.Echo "ErrorDescription: " & objItem.ErrorDescription
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "IsLocked: " & objItem.IsLocked
      WScript.Echo "LastErrorCode: " & objItem.LastErrorCode
      WScript.Echo "MonitorManufacturer: " & objItem.MonitorManufacturer
      WScript.Echo "MonitorType: " & objItem.MonitorType
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "PixelsPerXLogicalInch: " & objItem.PixelsPerXLogicalInch
      WScript.Echo "PixelsPerYLogicalInch: " & objItem.PixelsPerYLogicalInch
      WScript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
      strPowerManagementCapabilities = Join(objItem.PowerManagementCapabilities, ",")
         WScript.Echo "PowerManagementCapabilities: " & strPowerManagementCapabilities
      WScript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
      WScript.Echo "ScreenHeight: " & objItem.ScreenHeight
      WScript.Echo "ScreenWidth: " & objItem.ScreenWidth
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "StatusInfo: " & objItem.StatusInfo
      WScript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
      WScript.Echo "SystemName: " & objItem.SystemName
      WScript.Echo
   Next



Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function