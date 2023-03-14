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
Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
 
For Each objOS in colOperatingSystems
    dtmLastBootUpTime = WMIDateStringToDate(objOS.LastBootUpTime)
    dtmLocalDateTime=WMIDateStringToDate(objOS.LocalDateTime)
    dtmSystemUptime = DateDiff("n", dtmLastBootUpTime, dtmLocalDateTime)
    Wscript.Echo dtmSystemUptime
Next
 
Function WMIDateStringToDate(dtmBootup)
    WMIDateStringToDate =  _
        CDate(Mid(dtmBootup, 5, 2) & "/" & _
        Mid(dtmBootup, 7, 2) & "/" & Left(dtmBootup, 4) _
        & " " & Mid (dtmBootup, 9, 2) & ":" & _
        Mid(dtmBootup, 11, 2) & ":" & Mid(dtmBootup, _
        13, 2))
End Function
