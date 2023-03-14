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
Set colInstalledPrinters =  objWMIService.ExecQuery  ("Select * from Win32_Printer") ' Where Default = True")
For Each objPrinter in colInstalledPrinters
    Wscript.Echo objPrinter.Name
Next

