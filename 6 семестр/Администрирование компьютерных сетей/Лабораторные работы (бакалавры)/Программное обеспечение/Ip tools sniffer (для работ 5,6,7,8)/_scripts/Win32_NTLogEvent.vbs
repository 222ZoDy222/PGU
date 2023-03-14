Option Explicit

Dim objFso, objFolder, objWMI, objEvent ' Objects
Dim strFile, strComputer, strFolder, strFileName, strPath ' Strings
Dim intEvent, intNumberID, intRecordNum, colLoggedEvents

' --------------------------------------------
' Set your variables
intEvent = 1
intRecordNum = 1

If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)

strFileName = "\" & strcomputer & "_system.txt"
strFolder = "C:\temp"
strPath = strFolder & strFileName

' ----------------------------------------
' Section to create folder to hold file.
Set objFso = CreateObject("Scripting.FileSystemObject")

If objFSO.FolderExists(strFolder) Then
    Set objFolder = objFSO.GetFolder(strFolder)
Else
   Set objFolder = objFSO.CreateFolder(strFolder)
   Wscript.Echo "Folder created " & strFolder
End If
Set strFile = objFso.CreateTextFile(strPath, True)

'--------------------------------------------
' Next section creates the file to store Events
' Then creates WMI connector to the Logs

Set objWMI = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

call ntlogevent("system")

WScript.Quit

sub ntlogevent(logfile)
Set colLoggedEvents = objWMI.ExecQuery ("Select * from Win32_NTLogEvent Where Logfile = '" & logfile & "'" )

'Wscript.Echo " Press OK and Wait 30 seconds (ish)"
' -----------------------------------------
' Next section loops through ID properties
intEvent = 1
For Each objEvent in colLoggedEvents
'strFile.WriteLine ("Record No: ")& intEvent
strFile.WriteLine ("Record Number: " & objEvent.RecordNumber)
strFile.WriteLine ("Category: " & objEvent.Category)
strFile.WriteLine ("Computer Name: " & objEvent.ComputerName)
strFile.WriteLine ("Event Code: " & objEvent.EventCode)
strFile.WriteLine ("Message: " & objEvent.Message)
strFile.WriteLine ("Source Name: " & objEvent.SourceName)
strFile.WriteLine ("Time Written: " & objEvent.TimeWritten)
strFile.WriteLine ("Event Type: " & objEvent.Type)
strFile.WriteLine ("User: " & objEvent.User)
strFile.WriteLine (" ")
intRecordNum = intRecordNum +1
IntEvent = intEvent +1
Next
strfile.close
Wscript.Echo "Check " & strPath & " for " &intRecordNum & " events"
end sub