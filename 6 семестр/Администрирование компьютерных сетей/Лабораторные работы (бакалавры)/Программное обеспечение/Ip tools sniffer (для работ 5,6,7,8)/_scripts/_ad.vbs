On Error Resume Next
adsipath=wscript.arguments(0)
'wscript.Echo "path=" & ADSIPath

 Set obj = GetObject(ADSIPath  )

 If err.number<>0 Then
	wscript.echo err.number & "," & err.description
	wscript.quit
	End If

'wscript.echo "current object name:" & obj.name & " - " & "class:" & obj.class
wscript.echo "emailaddress= " & obj.emailaddress
wscript.echo "terminalserviceshomedirectory= " & obj.terminalserviceshomedirectory
'wscript.echo "terminalservicesprofilepath= " & obj.terminalservicesprofilepath
'wscript.echo "givenname= " & obj.givenname
'wscript.echo "sn= " & obj.sn
'wscript.echo ""

If obj.terminalserviceshomedirectory="" Then
	path="c:\documents and settings\" & replace(obj.name,"CN=","")
'	wscript.echo path
	obj.TerminalServicesHomeDirectory=path
	obj.setinfo
End If