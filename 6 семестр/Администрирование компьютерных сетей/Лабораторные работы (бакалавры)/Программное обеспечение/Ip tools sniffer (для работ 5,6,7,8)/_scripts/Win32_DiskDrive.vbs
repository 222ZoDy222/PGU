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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_DiskDrive", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Availability: " & objItem.Availability
      WScript.Echo "BytesPerSector: " & objItem.BytesPerSector
      strCapabilities = Join(objItem.Capabilities, ",")
         WScript.Echo "Capabilities: " & strCapabilities
      strCapabilityDescriptions = Join(objItem.CapabilityDescriptions, ",")
         WScript.Echo "CapabilityDescriptions: " & strCapabilityDescriptions
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "CompressionMethod: " & objItem.CompressionMethod
      WScript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
      WScript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      WScript.Echo "DefaultBlockSize: " & objItem.DefaultBlockSize
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceID: " & objItem.DeviceID
      WScript.Echo "ErrorCleared: " & objItem.ErrorCleared
      WScript.Echo "ErrorDescription: " & objItem.ErrorDescription
      WScript.Echo "ErrorMethodology: " & objItem.ErrorMethodology
      WScript.Echo "Index: " & objItem.Index
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "InterfaceType: " & objItem.InterfaceType
      WScript.Echo "LastErrorCode: " & objItem.LastErrorCode
      WScript.Echo "Manufacturer: " & objItem.Manufacturer
      WScript.Echo "MaxBlockSize: " & objItem.MaxBlockSize
      WScript.Echo "MaxMediaSize: " & objItem.MaxMediaSize
      WScript.Echo "MediaLoaded: " & objItem.MediaLoaded
      WScript.Echo "MediaType: " & objItem.MediaType
      WScript.Echo "MinBlockSize: " & objItem.MinBlockSize
      WScript.Echo "Model: " & objItem.Model
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "NeedsCleaning: " & objItem.NeedsCleaning
      WScript.Echo "NumberOfMediaSupported: " & objItem.NumberOfMediaSupported
      WScript.Echo "Partitions: " & objItem.Partitions
      WScript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
      strPowerManagementCapabilities = Join(objItem.PowerManagementCapabilities, ",")
         WScript.Echo "PowerManagementCapabilities: " & strPowerManagementCapabilities
      WScript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
      WScript.Echo "SCSIBus: " & objItem.SCSIBus
      WScript.Echo "SCSILogicalUnit: " & objItem.SCSILogicalUnit
      WScript.Echo "SCSIPort: " & objItem.SCSIPort
      WScript.Echo "SCSITargetId: " & objItem.SCSITargetId
      WScript.Echo "SectorsPerTrack: " & objItem.SectorsPerTrack
      WScript.Echo "Signature: " & objItem.Signature
      WScript.Echo "Size: " & objItem.Size
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "StatusInfo: " & objItem.StatusInfo
      WScript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
      WScript.Echo "SystemName: " & objItem.SystemName
      WScript.Echo "TotalCylinders: " & objItem.TotalCylinders
      WScript.Echo "TotalHeads: " & objItem.TotalHeads
      WScript.Echo "TotalSectors: " & objItem.TotalSectors
      WScript.Echo "TotalTracks: " & objItem.TotalTracks
      WScript.Echo "TracksPerCylinder: " & objItem.TracksPerCylinder
      WScript.Echo
   Next



Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function