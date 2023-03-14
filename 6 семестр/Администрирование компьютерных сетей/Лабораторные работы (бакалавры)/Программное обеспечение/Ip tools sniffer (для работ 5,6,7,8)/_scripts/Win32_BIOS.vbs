If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" _
    & strComputer & "\root\cimv2")
If err<>0 Then
	wscript.echo err.number & "," &  err.description	
	wscript.quit (1)
End If    
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_BIOS",,48)
For Each objItem in colItems
    Wscript.Echo "BiosCharacteristics: " & objItem.BiosCharacteristics
    Wscript.Echo "BuildNumber: " & objItem.BuildNumber
    Wscript.Echo "Caption: " & objItem.Caption
    Wscript.Echo "CodeSet: " & objItem.CodeSet
    Wscript.Echo "CurrentLanguage: " & objItem.CurrentLanguage
    Wscript.Echo "Description: " & objItem.Description
    Wscript.Echo "IdentificationCode: " & objItem.IdentificationCode
    Wscript.Echo "InstallableLanguages: " & objItem.InstallableLanguages
    Wscript.Echo "InstallDate: " & objItem.InstallDate
    Wscript.Echo "LanguageEdition: " & objItem.LanguageEdition
    Wscript.Echo "ListOfLanguages: " & objItem.ListOfLanguages
    Wscript.Echo "Manufacturer: " & objItem.Manufacturer
    Wscript.Echo "Name: " & objItem.Name
    Wscript.Echo "OtherTargetOS: " & objItem.OtherTargetOS
    Wscript.Echo "PrimaryBIOS: " & objItem.PrimaryBIOS
    Wscript.Echo "ReleaseDate: " & objItem.ReleaseDate
    Wscript.Echo "SerialNumber: " & objItem.SerialNumber
    Wscript.Echo "SMBIOSBIOSVersion: " & objItem.SMBIOSBIOSVersion
    Wscript.Echo "SMBIOSMajorVersion: " & objItem.SMBIOSMajorVersion
    Wscript.Echo "SMBIOSMinorVersion: " & objItem.SMBIOSMinorVersion
    Wscript.Echo "SMBIOSPresent: " & objItem.SMBIOSPresent
    Wscript.Echo "SoftwareElementID: " & objItem.SoftwareElementID
    Wscript.Echo "SoftwareElementState: " & objItem.SoftwareElementState
    Wscript.Echo "Status: " & objItem.Status
    Wscript.Echo "TargetOperatingSystem: " & objItem.TargetOperatingSystem
    Wscript.Echo "Version: " & objItem.Version
Next
