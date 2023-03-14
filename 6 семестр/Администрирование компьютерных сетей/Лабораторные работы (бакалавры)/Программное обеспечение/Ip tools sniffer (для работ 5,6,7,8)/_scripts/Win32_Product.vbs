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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Product", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "IdentifyingNumber: " & objItem.IdentifyingNumber
      WScript.Echo "InstallDate: " & objItem.InstallDate
      WScript.Echo "InstallDate2: " & WMIDateStringToDate(objItem.InstallDate2)
      WScript.Echo "InstallLocation: " & objItem.InstallLocation
      WScript.Echo "InstallState: " & objItem.InstallState
      WScript.Echo "Name: " & objItem.Name
      WScript.Echo "PackageCache: " & objItem.PackageCache
      WScript.Echo "SKUNumber: " & objItem.SKUNumber
      WScript.Echo "Vendor: " & objItem.Vendor
      WScript.Echo "Version: " & objItem.Version
      WScript.Echo
   Next


Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function