If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next
Set wmiServices = GetObject _
    ("winmgmts:{impersonationLevel=Impersonate}!//" & strComputer)
Set wmiDiskDrives = wmiServices.ExecQuery _
    ("SELECT Caption, DeviceID FROM Win32_DiskDrive")
 
For Each wmiDiskDrive In wmiDiskDrives
    WScript.Echo wmiDiskDrive.Caption & " (" & wmiDiskDrive.DeviceID & ")"
    strEscapedDeviceID = _
        Replace(wmiDiskDrive.DeviceID, "\", "\\", 1, -1, vbTextCompare)
    Set wmiDiskPartitions = wmiServices.ExecQuery _
        ("ASSOCIATORS OF {Win32_DiskDrive.DeviceID=""" & _
            strEscapedDeviceID & """} WHERE " & _
                "AssocClass = Win32_DiskDriveToDiskPartition")
 
    For Each wmiDiskPartition In wmiDiskPartitions
        WScript.Echo vbTab & wmiDiskPartition.DeviceID
        Set wmiLogicalDisks = wmiServices.ExecQuery _
            ("ASSOCIATORS OF {Win32_DiskPartition.DeviceID=""" & _
                wmiDiskPartition.DeviceID & """} WHERE " & _
                    "AssocClass = Win32_LogicalDiskToPartition")
 
        For Each wmiLogicalDisk In wmiLogicalDisks
            WScript.Echo vbTab & vbTab & wmiLogicalDisk.DeviceID
        Next
    Next
Next