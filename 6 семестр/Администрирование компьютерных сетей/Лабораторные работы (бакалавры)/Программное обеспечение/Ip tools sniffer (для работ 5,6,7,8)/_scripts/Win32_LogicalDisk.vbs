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
Set colItems = objWMIService.ExecQuery("Select * from Win32_LogicalDisk",,48)
For Each objItem in colItems
    Wscript.Echo "Access: " & objItem.Access
    Wscript.Echo "Availability: " & objItem.Availability
    Wscript.Echo "BlockSize: " & objItem.BlockSize
    Wscript.Echo "Caption: " & objItem.Caption
    Wscript.Echo "Compressed: " & objItem.Compressed
    Wscript.Echo "ConfigManagerErrorCode: " & objItem.ConfigManagerErrorCode
    Wscript.Echo "ConfigManagerUserConfig: " & objItem.ConfigManagerUserConfig
    Wscript.Echo "CreationClassName: " & objItem.CreationClassName
    Wscript.Echo "Description: " & objItem.Description
    Wscript.Echo "DeviceID: " & objItem.DeviceID
    Wscript.Echo "DriveType: " & objItem.DriveType
    Wscript.Echo "ErrorCleared: " & objItem.ErrorCleared
    Wscript.Echo "ErrorDescription: " & objItem.ErrorDescription
    Wscript.Echo "ErrorMethodology: " & objItem.ErrorMethodology
    Wscript.Echo "FileSystem: " & objItem.FileSystem
    Wscript.Echo "FreeSpace: " & objItem.FreeSpace
    Wscript.Echo "InstallDate: " & objItem.InstallDate
    Wscript.Echo "LastErrorCode: " & objItem.LastErrorCode
    Wscript.Echo "MaximumComponentLength: " & objItem.MaximumComponentLength
    Wscript.Echo "MediaType: " & objItem.MediaType
    Wscript.Echo "Name: " & objItem.Name
    Wscript.Echo "NumberOfBlocks: " & objItem.NumberOfBlocks
    Wscript.Echo "PNPDeviceID: " & objItem.PNPDeviceID
    Wscript.Echo "PowerManagementCapabilities: " & objItem.PowerManagementCapabilities
    Wscript.Echo "PowerManagementSupported: " & objItem.PowerManagementSupported
    Wscript.Echo "ProviderName: " & objItem.ProviderName
    Wscript.Echo "Purpose: " & objItem.Purpose
    Wscript.Echo "Size: " & objItem.Size
    Wscript.Echo "Status: " & objItem.Status
    Wscript.Echo "StatusInfo: " & objItem.StatusInfo
    Wscript.Echo "SupportsFileBasedCompression: " & objItem.SupportsFileBasedCompression
    Wscript.Echo "SystemCreationClassName: " & objItem.SystemCreationClassName
    Wscript.Echo "SystemName: " & objItem.SystemName
    Wscript.Echo "VolumeName: " & objItem.VolumeName
    Wscript.Echo "VolumeSerialNumber: " & objItem.VolumeSerialNumber
Next
