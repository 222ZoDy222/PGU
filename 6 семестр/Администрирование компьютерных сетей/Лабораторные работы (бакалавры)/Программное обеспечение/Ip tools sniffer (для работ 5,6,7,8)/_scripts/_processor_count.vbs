if wscript.arguments.count=0 then quit
const HKEY_LOCAL_MACHINE = &H80000002
strComputer = wscript.arguments(0)
 
Set oReg=GetObject("winmgmts:{impersonationLevel=impersonate}!\\" &_ 
strComputer & "\root\default:StdRegProv")
 
strKeyPath = "HARDWARE\DESCRIPTION\System\CentralProcessor"
oReg.EnumKey HKEY_LOCAL_MACHINE, strKeyPath, arrSubKeys
i=0 
For Each subkey In arrSubKeys
    'wscript.echo subkey
   i=i+1
Next
wscript.echo i