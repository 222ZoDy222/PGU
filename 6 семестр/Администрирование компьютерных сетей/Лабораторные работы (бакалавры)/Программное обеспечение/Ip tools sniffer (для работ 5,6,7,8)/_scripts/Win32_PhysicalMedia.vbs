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
   Set colItems = objWMIService.ExecQuery("SELECT * FROM  Win32_PhysicalMedia", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

   For Each objItem In colItems
      WScript.Echo "Caption: " & objItem.Caption
      WScript.Echo "Description: " & objItem.Description
      WScript.Echo "InstallDate: " & WMIDateStringToDate(objItem.InstallDate)
      WScript.Echo "Name: " & objItem.Name      
      WScript.Echo "Status: " & objItem.Status      
      WScript.Echo "CreationClassName: " & objItem.CreationClassName      
      WScript.Echo "Manufacturer: " & objItem.Manufacturer            
      WScript.Echo "Model: " & objItem.Model            
      WScript.Echo "SKU: " & objItem.SKU            
      WScript.Echo "SerialNumber : " & objItem.SerialNumber             
      WScript.Echo "Tag  : " & objItem.Tag              
      WScript.Echo "Version  : " & objItem.Version              
      WScript.Echo "PartNumber  : " & objItem.PartNumber              
      WScript.Echo "OtherIdentifyingInfo  : " & objItem.OtherIdentifyingInfo              
      WScript.Echo "PoweredOn  : " & objItem.PoweredOn              
      WScript.Echo "Removable  : " & objItem.Removable              
      WScript.Echo "Replaceable  : " & objItem.Replaceable              
      WScript.Echo "HotSwappable  : " & objItem.HotSwappable              
      WScript.Echo "Capacity  : " & objItem.Capacity              
      WScript.Echo "MediaType  : " & objItem.MediaType              
      WScript.Echo "MediaDescription  : " & objItem.MediaDescription              
      WScript.Echo "WriteProtectOn  : " & objItem.WriteProtectOn              
      WScript.Echo "CleanerMedia  : " & objItem.CleanerMedia              
      WScript.Echo
   Next


Function WMIDateStringToDate(dtmDate)
WScript.Echo dtm: 
	WMIDateStringToDate = CDate(Mid(dtmDate, 5, 2) & "/" & _
	Mid(dtmDate, 7, 2) & "/" & Left(dtmDate, 4) _
	& " " & Mid (dtmDate, 9, 2) & ":" & Mid(dtmDate, 11, 2) & ":" & Mid(dtmDate,13, 2))
End Function