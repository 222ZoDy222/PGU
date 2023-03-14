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
'Set colItems = objWMIService.ExecQuery("Select * from Win32_LogicalDisk where DEVICEID='C:'",,48)
Set colItems = objWMIService.ExecQuery("Select * from Win32_LogicalDisk",,48)
For Each objItem in colItems
    Wscript.Echo "DeviceID: " & objItem.DeviceID
    Wscript.Echo "FreeSpace (MB): " & round(objItem.FreeSpace / 1024 / 1024,0)
    Wscript.Echo "Size (MB): " & round(objItem.Size / 1024 / 1024,0)
Next
