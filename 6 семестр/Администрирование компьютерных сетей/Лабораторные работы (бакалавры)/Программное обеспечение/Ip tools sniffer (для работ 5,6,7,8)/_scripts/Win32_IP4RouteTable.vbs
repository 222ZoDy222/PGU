
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
Set colRoutes = objWMIService.ExecQuery ("Select * from Win32_IP4RouteTable",,48)
wscript.Echo "Destination"+chr(9)+"Mask"+chr(9)+"NextHop"+chr(9)+"Interface"+chr(9)+"Metric"
For Each objRoute In colRoutes
    '
    if objRoute.InterfaceIndex=1 then strtemp="127.0.0.1"
    if objRoute.InterfaceIndex>1 then 
    Set colAdapters = objWMIService.ExecQuery ("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = True",,48)
    For Each objAdapter In colAdapters
    	if Not IsNull(objAdapter.IpAddress) Then strtemp=objAdapter.IpAddress(0) else strtemp=cstr(objRoute.InterfaceIndex)
    next
    end if
    '	
    Wscript.Echo objRoute.Destination  + chr(9) + objRoute.Mask + chr(9)+ objRoute.NextHop +  chr(9) + strtemp +  chr(9) + cstr(objRoute.Metric1)
    'Wscript.Echo ""
Next

