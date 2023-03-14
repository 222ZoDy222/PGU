Option Explicit


Dim objFso, objFolder, objWMI, objEvent ' Objects
Dim strFile, ScriptPath, strComputer, strFolder, strFileName, strPath, strSystemFileName, strSecurityFileName, strApplicationFileName ' Strings
Dim intEvent, intNumberID, intRecordNum, colLoggedEvents

' --------------------------------------------
' Set your variables
intEvent = 1
intRecordNum = 1

If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)

strSystemFileName =  strcomputer & "_system.html"
strSecurityFileName =  strcomputer & "_security.html"
strApplicationFileName = strcomputer & "_application.html"
strFolder = "C:\temp"

ScriptPath = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\")) 

' ----------------------------------------
' Section to create folder to hold file.
Set objFso = CreateObject("Scripting.FileSystemObject")

If objFSO.FolderExists(strFolder) Then
    Set objFolder = objFSO.GetFolder(strFolder)
Else
   Set objFolder = objFSO.CreateFolder(strFolder)
   Wscript.Echo "Folder created " & strFolder
End If

If objFso.FileExists(ScriptPath & "style.css") Then objFso.CopyFile ScriptPath & "style.css", strfolder & "\"

'--------------------------------------------
' Next section creates the file to store Events
' Then creates WMI connector to the Logs

Set objWMI = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

call ntlogevent("system",strSystemFileName)
call ntlogevent("security",strSecurityFileName)
call ntlogevent("application",strApplicationFileName)

'
WScript.Quit

sub ntlogevent(logfile,strfilename)
Set colLoggedEvents = objWMI.ExecQuery ("Select * from Win32_NTLogEvent Where Logfile = '" & logfile & "'" )
strPath = strFolder & "\" & strFileName
Set strFile = objFso.CreateTextFile(strPath, True)
strFile.WriteLine ("<html><body><head><link rel=""stylesheet"" type=""text/css"" href=""style.css"" /></head>")
strFile.WriteLine ("<table>")
intEvent = 1
For Each objEvent in colLoggedEvents
	'strFile.WriteLine ("Record No: ")& intEvent
	strFile.WriteLine ("<tr><td class=sub>Record Number</td><td class=sub>" & objEvent.RecordNumber & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Category</td><td class=default>" & objEvent.Category & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Computer Name</td><td class=default>" & objEvent.ComputerName & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Message</td><td class=default>" & objEvent.Message & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Event Code</td><td class=default>" & objEvent.EventCode & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Source Name</td><td class=default>" & objEvent.SourceName & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Time Written</td><td class=default>" & WMIDateStringToDate(objEvent.TimeWritten) & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Event Type</td><td class=default>" & objEvent.Type & "</td></tr>")
	strFile.WriteLine ("<tr><td class=default>User</td><td class=default>" & objEvent.User & "&nbsp</td></tr>")
	strFile.WriteLine ("<tr><td class=default>Computername</td><td class=default>" & objEvent.Computername & "&nbsp</td></tr>")
	'strFile.WriteLine ("<tr><td class=default>&nbsp</td><td>&nbsp</td></tr>")
	intRecordNum = intRecordNum +1
	IntEvent = intEvent +1
Next
strFile.WriteLine ("</table>")
strFile.WriteLine ("<hr><br><b>Report created by IPTools</b><br><a href=""http://erwan.l.free.fr/"">Web Site</a><br><a href=""mailto:erwan.l@free.fr"">Email</a><br></body></html>")
strfile.close
wscript.echo "system log dumped to " & strpath
end sub


Function WMIDateStringToDate(dtmBootup)
    WMIDateStringToDate =  _
        CDate(Mid(dtmBootup, 5, 2) & "/" & _
        Mid(dtmBootup, 7, 2) & "/" & Left(dtmBootup, 4) _
        & " " & Mid (dtmBootup, 9, 2) & ":" & _
        Mid(dtmBootup, 11, 2) & ":" & Mid(dtmBootup, _
        13, 2))
End Function

