Dim sHost		'name of Windows XP computer from which the PING command will be initiated
Dim sTarget		'name or IP address of remote computer to which connectivity will be tested
Dim cPingResults	'collection of instances of Win32_PingStatus class
Dim oPingResult		'single instance of Win32_PingStatus class

sHost		= "."
sTarget		= wscript.arguments(0)

Set cPingResults = GetObject("winmgmts:{impersonationLevel=impersonate}//" & _
		sHost & "/root/cimv2"). ExecQuery("SELECT * FROM Win32_PingStatus " & _
		"WHERE Address = '" + sTarget + "'")

For Each oPingResult In cPingResults
	If oPingResult.StatusCode = 0 Then
		If LCase(sTarget) = oPingResult.ProtocolAddress Then
			'WScript.Echo sTarget & " is responding"
		Else
			'WScript.Echo sTarget & "(" & oPingResult.ProtocolAddress & ") is responding"
		End If
		'Wscript.Echo "Bytes = " & vbTab & oPingResult.BufferSize
		'Wscript.Echo "Time (ms) = " & vbTab & oPingResult.ResponseTime
		'Wscript.Echo "TTL (s) = " & vbTab & oPingResult.ResponseTimeToLive
		wscript.echo "OK @ " & now
	Else
		'WScript.Echo sTarget & " is not responding"
		'WScript.Echo "Status code is " & oPingResult.StatusCode
		wscript.echo "Not OK @ " & now
	End If
Next

'A value of the StatusCode equal to 0 indicates the PING command was successful; a non-zero value indicates a failure.
'The reason for the failure can be determined by analyzing returned value, which can be one of the following:

    ' 11001 Buffer Too Small
    ' 11002 Destination Net Unreachable
    ' 11003 Destination Host Unreachable
    ' 11004 Destination Protocol Unreachable
    ' 11005 Destination Port Unreachable
    ' 11006 No Resources
    ' 11007 Bad Option
    ' 11008 Hardware Error
    ' 11009 Packet Too Big
    ' 11010 Request Timed Out
    ' 11011 Bad Request
    ' 11012 Bad Route
    ' 11013 TimeToLive Expired Transit
    ' 11014 TimeToLive Expired Reassembly
    ' 11015 Parameter Problem
    ' 11016 Source Quench
    ' 11017 Option Too Big
    ' 11018 Bad Destination
    ' 11032 Negotiating IPSEC
    ' 11050 General Failure 