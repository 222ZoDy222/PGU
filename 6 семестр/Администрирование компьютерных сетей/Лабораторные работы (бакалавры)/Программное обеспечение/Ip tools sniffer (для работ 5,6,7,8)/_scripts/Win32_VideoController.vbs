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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_VideoController", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      strAcceleratorCapabilities = Join(objItem.AcceleratorCapabilities, ",")
         WScript.Echo "AcceleratorCapabilities: " & strAcceleratorCapabilities
      WScript.Echo "AdapterCompatibility: " & objItem.AdapterCompatibility
      WScript.Echo "AdapterDACType: " & objItem.AdapterDACType
      WScript.Echo "AdapterRAM: " & objItem.AdapterRAM
      WScript.Echo "Availability: " & objItem.Availability
      strCapabilityDescriptions = Join(objItem.CapabilityDescriptions, ",")
         WScript.Echo "CapabilityDescriptions: " & strCapabilityDescriptions
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "ColorTableEntries: " & objItem.ColorTableEntries
      WScript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
      WScript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      WScript.Echo "CurrentBitsPerPixel: " & objItem.CurrentBitsPerPixel
      WScript.Echo "CurrentHorizontalResolution: " & objItem.CurrentHorizontalResolution
      WScript.Echo "CurrentNumberOfColors: " & objItem.CurrentNumberOfColors
      WScript.Echo "CurrentNumberOfColumns: " & objItem.CurrentNumberOfColumns
      WScript.Echo "CurrentNumberOfRows: " & objItem.CurrentNumberOfRows
      WScript.Echo "CurrentRefreshRate: " & objItem.CurrentRefreshRate
      WScript.Echo "CurrentScanMode: " & objItem.CurrentScanMode
      WScript.Echo "CurrentVerticalResolution: " & objItem.CurrentVerticalResolution
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceID: " & objItem.DeviceID
      WScript.Echo "DeviceSpecificPens: " & objItem.DeviceSpecificPens
      WScript.Echo "DitherType: " & objItem.DitherType
      WScript.Echo "DriverDate: " & WMIDateStringToDate(objItem.DriverDate)
      WScript.Echo "DriverVersion: " & objItem.DriverVersion
      WScript.Echo "ErrorCleared: " & objItem.ErrorCleared
      WScript.Echo "ErrorDescription: " & objItem.ErrorDescription
      WScript.Echo "ICMIntent: " & objItem.ICMIntent
      WScript.Echo "ICMMethod: " & objItem.ICMMethod
      WScript.Echo "InfFilename: " & objItem.InfFilename
      WScript.Echo "InfSection: " & objItem.InfSection
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "InstalledDisplayDrivers: " & objItem.InstalledDisplayDrivers
      WScript.Echo "LastErrorCode: " & objItem.LastErrorCode
      WScript.Echo "MaxMemorySupported: " & objItem.MaxMemorySupported
      WScript.Echo "MaxNumberControlled: " & objItem.MaxNumberControlled
      WScript.Echo "MaxRefreshRate: " & objItem.MaxRefreshRate
      WScript.Echo "MinRefreshRate: " & objItem.MinRefreshRate
      WScript.Echo "Monochrome: " & objItem.Monochrome
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "NumberOfColorPlanes: " & objItem.NumberOfColorPlanes
      WScript.Echo "NumberOfVideoPages: " & objItem.NumberOfVideoPages
      WScript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
      strPowerManagementCapabilities = Join(objItem.PowerManagementCapabilities, ",")
         WScript.Echo "PowerManagementCapabilities: " & strPowerManagementCapabilities
      WScript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
      WScript.Echo "ProtocolSupported: " & objItem.ProtocolSupported
      WScript.Echo "ReservedSystemPaletteEntries: " & objItem.ReservedSystemPaletteEntries
      WScript.Echo "SpecificationVersion: " & objItem.SpecificationVersion
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "StatusInfo: " & objItem.StatusInfo
      WScript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
      WScript.Echo "SystemName: " & objItem.SystemName
      WScript.Echo "SystemPaletteEntries: " & objItem.SystemPaletteEntries
      WScript.Echo "TimeOfLastReset: " & WMIDateStringToDate(objItem.TimeOfLastReset)
      WScript.Echo "VideoArchitecture: " & objItem.VideoArchitecture
      WScript.Echo "VideoMemoryType: " & objItem.VideoMemoryType
      WScript.Echo "VideoMode: " & objItem.VideoMode
      WScript.Echo "VideoModeDescription: " & objItem.VideoModeDescription
      WScript.Echo "VideoProcessor: " & objItem.VideoProcessor
      WScript.Echo
   Next



Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function