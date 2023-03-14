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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PhysicalMemory", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "BankLabel: " & objItem.BankLabel
      WScript.Echo "Capacity: " & objItem.Capacity
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "CreationClassName: " & objItem.CreationClassName
      WScript.Echo "DataWidth: " & objItem.DataWidth
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "DeviceLocator: " & objItem.DeviceLocator
      WScript.Echo "FormFactor: " & objItem.FormFactor
      WScript.Echo "HotSwappable: " & objItem.HotSwappable
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "InterleaveDataDepth: " & objItem.InterleaveDataDepth
      WScript.Echo "InterleavePosition: " & objItem.InterleavePosition
      WScript.Echo "Manufacturer: " & objItem.Manufacturer
      WScript.Echo "MemoryType: " & objItem.MemoryType
      WScript.Echo "Model: " & objItem.Model
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "OtherIdentifyingInfo: " & objItem.OtherIdentifyingInfo
      WScript.Echo "PartNumber: " & objItem.PartNumber
      WScript.Echo "PositionInRow: " & objItem.PositionInRow
      WScript.Echo "PoweredOn: " & objItem.PoweredOn
      WScript.Echo "Removable: " & objItem.Removable
      WScript.Echo "Replaceable: " & objItem.Replaceable
      WScript.Echo "SerialNumber: " & objItem.SerialNumber
      WScript.Echo "SKU: " & objItem.SKU
      WScript.Echo "Speed: " & objItem.Speed
      WScript.Echo "Status: " & objItem.Status
      WScript.Echo "Tag: " & objItem.Tag
      WScript.Echo "TotalWidth: " & objItem.TotalWidth
      WScript.Echo "TypeDetail: " & objItem.TypeDetail
      WScript.Echo "Version: " & objItem.Version
      WScript.Echo
   Next


Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function