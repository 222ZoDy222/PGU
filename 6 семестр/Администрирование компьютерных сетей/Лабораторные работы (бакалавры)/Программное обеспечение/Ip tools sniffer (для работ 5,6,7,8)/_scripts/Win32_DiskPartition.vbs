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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DiskPartition", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Access: " & objItem.Access
      WScript.Echo "Availability: " & objItem.Availability
      WScript.Echo "BlockSize: " & objItem.BlockSize
      WScript.Echo "Bootable: " & objItem.Bootable
      WScript.Echo "BootPartition: " & objItem.BootPartition
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
      WScript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceID: " & objItem.DeviceID
      WScript.Echo "DiskIndex: " & objItem.DiskIndex
      WScript.Echo "ErrorCleared: " & objItem.ErrorCleared
      WScript.Echo "ErrorDescription: " & objItem.ErrorDescription
      WScript.Echo "ErrorMethodology: " & objItem.ErrorMethodology
      WScript.Echo "HiddenSectors: " & objItem.HiddenSectors
      WScript.Echo "Index: " & objItem.Index
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "LastErrorCode: " & objItem.LastErrorCode
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "NumberOfBlocks: " & objItem.NumberOfBlocks
      WScript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
      strPowerManagementCapabilities = Join(objItem.PowerManagementCapabilities, ",")
         WScript.Echo "PowerManagementCapabilities: " & strPowerManagementCapabilities
      WScript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
      WScript.Echo "PrimaryPartition: " & objItem.PrimaryPartition
      WScript.Echo "Purpose: " & objItem.Purpose
      WScript.Echo "RewritePartition: " & objItem.RewritePartition
      WScript.Echo "Size: " & objItem.Size
      WScript.Echo "StartingOffset: " & objItem.StartingOffset
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "StatusInfo: " & objItem.StatusInfo
      WScript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
      WScript.Echo "SystemName: " & objItem.SystemName
      WScript.Echo "Type: " & objItem.Type
      WScript.Echo
   Next



Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function