if wscript.arguments.count=0 then quit
const HKEY_LOCAL_MACHINE = &H80000002
strComputer = wscript.arguments(0)
 
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_ 
strComputer & "\root\default:StdRegProv")
 
strKeyPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon"
strValueName = "shell"
oReg.GetStringValue  HKEY_LOCAL_MACHINE,strKeyPath,strValueName,strValue
 
WScript.echo  strValue