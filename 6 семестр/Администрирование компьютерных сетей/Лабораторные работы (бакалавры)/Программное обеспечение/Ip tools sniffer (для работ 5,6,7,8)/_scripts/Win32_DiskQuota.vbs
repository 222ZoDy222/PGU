On Error Resume Next
strComputer = wscript.arguments(0)
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colDiskQuotas = objWMIService.ExecQuery("Select * from Win32_DiskQuota")
For each objQuota in colDiskQuotas
    Wscript.Echo "Disk Space Used: " & vbTab &  objQuota.DiskSpaceUsed
    Wscript.Echo "Limit: " & vbTab &  objQuota.Limit   
    Wscript.Echo "Quota Volume: " & vbTab &  objQuota.QuotaVolume     
    Wscript.Echo "Status: " & vbTab &  objQuota.Status 
    Wscript.Echo "User: " & vbTab &  objQuota.User     
    Wscript.Echo "Warning Limit: " & vbTab &  objQuota.WarningLimit
Next