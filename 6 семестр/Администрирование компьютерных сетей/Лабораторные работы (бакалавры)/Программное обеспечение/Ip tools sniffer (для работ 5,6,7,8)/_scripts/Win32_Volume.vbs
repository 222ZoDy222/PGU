If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery("Select * from Win32_Volume")
For Each objItem In colItems
    WScript.Echo "Automount: " & objItem.Automount
    WScript.Echo "Block Size: " & objItem.BlockSize
    WScript.Echo "Capacity: " & objItem.Capacity
    WScript.Echo "Caption: " & objItem.Caption
    WScript.Echo "Compressed: " & objItem.Compressed
    WScript.Echo "Device ID: " & objItem.DeviceID
    WScript.Echo "Dirty Bit Set: " & objItem.DirtyBitSet
    WScript.Echo "Drive Letter: " & objItem.DriveLetter
    WScript.Echo "Drive Type: " & objItem.DriveType
    WScript.Echo "File System: " & objItem.FileSystem
    WScript.Echo "Free Space: " & objItem.FreeSpace
    WScript.Echo "Indexing Enabled: " & objItem.IndexingEnabled
    WScript.Echo "Label: " & objItem.Label
    WScript.Echo "Maximum File Name Length: " & objItem.MaximumFileNameLength
    WScript.Echo "Name: " & objItem.Name
    WScript.Echo "Quotas Enabled: " & objItem.QuotasEnabled
    WScript.Echo "Quotas Incomplete: " & objItem.QuotasIncomplete
    WScript.Echo "Quotas Rebuilding: " & objItem.QuotasRebuilding
    WScript.Echo "Serial Number: " & objItem.SerialNumber
    WScript.Echo "Supports Disk Quotas: " & objItem.SupportsDiskQuotas
    WScript.Echo "Supports File-Based Compression: " & objItem.SupportsFileBasedCompression
    WScript.Echo
Next