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
Set colItems = objWMIService.ExecQuery("Select * from Win32_BaseBoard",,48)
For Each objItem in colItems
    Wscript.Echo "Caption: " & objItem.Caption
    Wscript.Echo "ConfigOptions: " & objItem.ConfigOptions
    Wscript.Echo "CreationClassName: " & objItem.CreationClassName
    Wscript.Echo "Depth: " & objItem.Depth
    Wscript.Echo "Description: " & objItem.Description
    Wscript.Echo "Height: " & objItem.Height
    Wscript.Echo "HostingBoard: " & objItem.HostingBoard
    Wscript.Echo "HotSwappable: " & objItem.HotSwappable
    Wscript.Echo "InstallDate: " & objItem.InstallDate
    Wscript.Echo "Manufacturer: " & objItem.Manufacturer
    Wscript.Echo "Model: " & objItem.Model
    Wscript.Echo "Name: " & objItem.Name
    Wscript.Echo "OtherIdentifyingInfo: " & objItem.OtherIdentifyingInfo
    Wscript.Echo "PartNumber: " & objItem.PartNumber
    Wscript.Echo "PoweredOn: " & objItem.PoweredOn
    Wscript.Echo "Product: " & objItem.Product
    Wscript.Echo "Removable: " & objItem.Removable
    Wscript.Echo "Replaceable: " & objItem.Replaceable
    Wscript.Echo "RequirementsDescription: " & objItem.RequirementsDescription
    Wscript.Echo "RequiresDaughterBoard: " & objItem.RequiresDaughterBoard
    Wscript.Echo "SerialNumber: " & objItem.SerialNumber
    Wscript.Echo "SKU: " & objItem.SKU
    Wscript.Echo "SlotLayout: " & objItem.SlotLayout
    Wscript.Echo "SpecialRequirements: " & objItem.SpecialRequirements
    Wscript.Echo "Status: " & objItem.Status
    Wscript.Echo "Tag: " & objItem.Tag
    Wscript.Echo "Version: " & objItem.Version
    Wscript.Echo "Weight: " & objItem.Weight
    Wscript.Echo "Width: " & objItem.Width
Next
