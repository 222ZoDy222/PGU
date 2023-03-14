strComputer = wscript.arguments(0)
const HKEY_CURRENT_USER = &H80000001
const HKEY_LOCAL_MACHINE = &H80000002
Set oReg=GetObject( "winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\default:StdRegProv")
strKeyPath = "SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
strValueName = "DefaultDomainName"
oReg.GetstringValue  HKEY_LOCAL_MACHINE ,strKeyPath,strValueName,Value
WScript.Echo Value