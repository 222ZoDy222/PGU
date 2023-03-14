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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Printer", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Attributes: " & objItem.Attributes
      WScript.Echo "Availability: " & objItem.Availability
      strAvailableJobSheets = Join(objItem.AvailableJobSheets, ",")
         WScript.Echo "AvailableJobSheets: " & strAvailableJobSheets
      WScript.Echo "AveragePagesPerMinute: " & objItem.AveragePagesPerMinute
      strCapabilities = Join(objItem.Capabilities, ",")
         WScript.Echo "Capabilities: " & strCapabilities
      strCapabilityDescriptions = Join(objItem.CapabilityDescriptions, ",")
         WScript.Echo "CapabilityDescriptions: " & strCapabilityDescriptions
      WScript.Echo "Caption: " & objItem.Caption
      strCharSetsSupported = Join(objItem.CharSetsSupported, ",")
         WScript.Echo "CharSetsSupported: " & strCharSetsSupported
      WScript.Echo "Comment: " & objItem.Comment
      WScript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
      WScript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      strCurrentCapabilities = Join(objItem.CurrentCapabilities, ",")
         WScript.Echo "CurrentCapabilities: " & strCurrentCapabilities
      WScript.Echo "CurrentCharSet: " & objItem.CurrentCharSet
      WScript.Echo "CurrentLanguage: " & objItem.CurrentLanguage
      WScript.Echo "CurrentMimeType: " & objItem.CurrentMimeType
      WScript.Echo "CurrentNaturalLanguage: " & objItem.CurrentNaturalLanguage
      WScript.Echo "CurrentPaperType: " & objItem.CurrentPaperType
      WScript.Echo "Default: " & objItem.Default
      strDefaultCapabilities = Join(objItem.DefaultCapabilities, ",")
         WScript.Echo "DefaultCapabilities: " & strDefaultCapabilities
      WScript.Echo "DefaultCopies: " & objItem.DefaultCopies
      WScript.Echo "DefaultLanguage: " & objItem.DefaultLanguage
      WScript.Echo "DefaultMimeType: " & objItem.DefaultMimeType
      WScript.Echo "DefaultNumberUp: " & objItem.DefaultNumberUp
      WScript.Echo "DefaultPaperType: " & objItem.DefaultPaperType
      WScript.Echo "DefaultPriority: " & objItem.DefaultPriority
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DetectedErrorState: " & objItem.DetectedErrorState
      WScript.Echo "DeviceID: " & objItem.DeviceID
      WScript.Echo "Direct: " & objItem.Direct
      WScript.Echo "DoCompleteFirst: " & objItem.DoCompleteFirst
      WScript.Echo "DriverName: " & objItem.DriverName
      WScript.Echo "EnableBIDI: " & objItem.EnableBIDI
      WScript.Echo "EnableDevQueryPrint: " & objItem.EnableDevQueryPrint
      WScript.Echo "ErrorCleared: " & objItem.ErrorCleared
      WScript.Echo "ErrorDescription: " & objItem.ErrorDescription
      strErrorInformation = Join(objItem.ErrorInformation, ",")
         WScript.Echo "ErrorInformation: " & strErrorInformation
      WScript.Echo "ExtendedDetectedErrorState: " & objItem.ExtendedDetectedErrorState
      WScript.Echo "ExtendedPrinterStatus: " & objItem.ExtendedPrinterStatus
      WScript.Echo "Hidden: " & objItem.Hidden
      WScript.Echo "HorizontalResolution: " & objItem.HorizontalResolution
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "JobCountSinceLastReset: " & objItem.JobCountSinceLastReset
      WScript.Echo "KeepPrintedJobs: " & objItem.KeepPrintedJobs
      strLanguagesSupported = Join(objItem.LanguagesSupported, ",")
         WScript.Echo "LanguagesSupported: " & strLanguagesSupported
      WScript.Echo "LastErrorCode: " & objItem.LastErrorCode
      WScript.Echo "Local: " & objItem.Local
      WScript.Echo "Location: " & objItem.Location
      WScript.Echo "MarkingTechnology: " & objItem.MarkingTechnology
      WScript.Echo "MaxCopies: " & objItem.MaxCopies
      WScript.Echo "MaxNumberUp: " & objItem.MaxNumberUp
      WScript.Echo "MaxSizeSupported: " & objItem.MaxSizeSupported
      strMimeTypesSupported = Join(objItem.MimeTypesSupported, ",")
         WScript.Echo "MimeTypesSupported: " & strMimeTypesSupported
      WScript.Echo "Name: " & objItem.Name
      strNaturalLanguagesSupported = Join(objItem.NaturalLanguagesSupported, ",")
         WScript.Echo "NaturalLanguagesSupported: " & strNaturalLanguagesSupported
      WScript.Echo "Network: " & objItem.Network
      strPaperSizesSupported = Join(objItem.PaperSizesSupported, ",")
         WScript.Echo "PaperSizesSupported: " & strPaperSizesSupported
      strPaperTypesAvailable = Join(objItem.PaperTypesAvailable, ",")
         WScript.Echo "PaperTypesAvailable: " & strPaperTypesAvailable
      WScript.Echo "Parameters: " & objItem.Parameters
      WScript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
      WScript.Echo "PortName: " & objItem.PortName
      strPowerManagementCapabilities = Join(objItem.PowerManagementCapabilities, ",")
         WScript.Echo "PowerManagementCapabilities: " & strPowerManagementCapabilities
      WScript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
      strPrinterPaperNames = Join(objItem.PrinterPaperNames, ",")
         WScript.Echo "PrinterPaperNames: " & strPrinterPaperNames
      WScript.Echo "PrinterState: " & objItem.PrinterState
      WScript.Echo "PrinterStatus: " & objItem.PrinterStatus
      WScript.Echo "PrintJobDataType: " & objItem.PrintJobDataType
      WScript.Echo "PrintProcessor: " & objItem.PrintProcessor
      WScript.Echo "Priority: " & objItem.Priority
      WScript.Echo "Published: " & objItem.Published
      WScript.Echo "Queued: " & objItem.Queued
      WScript.Echo "RawOnly: " & objItem.RawOnly
      WScript.Echo "SeparatorFile: " & objItem.SeparatorFile
      WScript.Echo "ServerName: " & objItem.ServerName
      WScript.Echo "Shared: " & objItem.Shared
      WScript.Echo "ShareName: " & objItem.ShareName
      WScript.Echo "SpoolEnabled: " & objItem.SpoolEnabled
      WScript.Echo "StartTime: " & WMIDateStringToDate(objItem.StartTime)
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "StatusInfo: " & objItem.StatusInfo
      WScript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
      WScript.Echo "SystemName: " & objItem.SystemName
      WScript.Echo "TimeOfLastReset: " & WMIDateStringToDate(objItem.TimeOfLastReset)
      WScript.Echo "UntilTime: " & WMIDateStringToDate(objItem.UntilTime)
      WScript.Echo "VerticalResolution: " & objItem.VerticalResolution
      WScript.Echo "WorkOffline: " & objItem.WorkOffline
      WScript.Echo
   Next



Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function