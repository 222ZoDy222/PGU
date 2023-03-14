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
Set colQuickFixes = objWMIService.ExecQuery _
    ("Select * from Win32_QuickFixEngineering")

For Each objQuickFix in colQuickFixes
    Wscript.Echo "Computer: " & objQuickFix.CSName
    Wscript.Echo "Description: " & objQuickFix.Description
    Wscript.Echo "Hot Fix ID: " & objQuickFix.HotFixID
    Wscript.Echo "Installation Date: " & objQuickFix.InstallDate
    Wscript.Echo "Installed By: " & objQuickFix.InstalledBy
Next

