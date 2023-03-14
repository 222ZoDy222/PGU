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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM  Win32_MappedLogicalDisk", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Caption: " & objItem.Caption
        wscript.echo " Access: " & objitem.Access
  wscript.echo " Availability: " & objitem.Availability
  wscript.echo " BlockSize: " & objitem.BlockSize
  wscript.echo " Caption: " & objitem.Caption
  wscript.echo " Compressed: " & objitem.Compressed
  wscript.echo " ConfigManagerErrorCode: " & objitem.ConfigManagerErrorCode
  wscript.echo " ConfigManagerUserConfig: " & objitem.ConfigManagerUserConfig
  wscript.echo " CreationClassName: " & objitem.CreationClassName
  wscript.echo " Description: " & objitem.Description
  wscript.echo " DeviceID: " & objitem.DeviceID
  wscript.echo " ErrorCleared: " & objitem.ErrorCleared
  wscript.echo " ErrorDescription: " & objitem.ErrorDescription
  wscript.echo " ErrorMethodology: " & objitem.ErrorMethodology
  wscript.echo " FileSystem: " & objitem.FileSystem
  wscript.echo " FreeSpace: " & objitem.FreeSpace
  wscript.echo " InstallDate: " & WMIDateStringToDate(objitem.InstallDate)
  wscript.echo " LastErrorCode: " & objitem.LastErrorCode
  wscript.echo " MaximumComponentLength: " & objitem.MaximumComponentLength
  wscript.echo " Name: " & objitem.Name
  wscript.echo " NumberOfBlocks: " & objitem.NumberOfBlocks
  wscript.echo " PNPDeviceID: " & objitem.PNPDeviceID
  'wscript.echo " PowerManagementCapabilities[]: " & objitem.
  wscript.echo " PowerManagementSupported: " & objitem.PowerManagementSupported
  wscript.echo " ProviderName: " & objitem.ProviderName
  wscript.echo " Purpose: " & objitem.Purpose
  wscript.echo " QuotasDisabled: " & objitem.QuotasDisabled
  wscript.echo " QuotasIncomplete: " & objitem.QuotasIncomplete
  wscript.echo " QuotasRebuilding: " & objitem.QuotasRebuilding
  wscript.echo " SessionID: " & objitem.SessionID
  wscript.echo " Size: " & objitem.Size
  wscript.echo " Status: " & objitem.Status
  wscript.echo " StatusInfo: " & objitem.StatusInfo
  wscript.echo " SupportsDiskQuotas: " & objitem.SupportsDiskQuotas
  wscript.echo " SupportsFileBasedCompression: " & objitem.SupportsFileBasedCompression
  wscript.echo " SystemCreationClassName: " & objitem.SystemCreationClassName
  wscript.echo " SystemName: " & objitem.SystemName:
  wscript.echo " VolumeName: " & objitem.VolumeName
  wscript.echo " VolumeSerialNumber: " & objitem.VolumeSerialNumber  
      WScript.Echo
   Next


Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function