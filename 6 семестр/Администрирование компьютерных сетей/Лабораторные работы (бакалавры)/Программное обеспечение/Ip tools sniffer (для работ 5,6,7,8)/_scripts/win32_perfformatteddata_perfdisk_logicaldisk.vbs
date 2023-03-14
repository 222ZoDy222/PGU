If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
set objRefresher = CreateObject("WbemScripting.SWbemRefresher")
Set colDisks = objRefresher.AddEnum _
    (objWMIService, "win32_perfformatteddata_perfdisk_logicaldisk"). _
        objectSet
objRefresher.Refresh
For i = 1 to 10
    For Each objDisk in colDisks
        Wscript.Echo "Average Disk Bytes Per Read: " & vbTab &  _
            objDisk.AvgDiskBytesPerRead
        Wscript.Echo "Average Disk Bytes Per Transfer: " & vbTab &  _
            objDisk.AvgDiskBytesPerTransfer
        Wscript.Echo "Average Disk Bytes Per Write: " & vbTab &  _
            objDisk.AvgDiskBytesPerWrite
        Wscript.Echo "Average Disk Queue Length: " & vbTab &  _
            objDisk.AvgDiskQueueLength
        Wscript.Echo "Average Disk Read Queue Length: " & vbTab &  _
            objDisk.AvgDiskReadQueueLength
        Wscript.Echo "Average Disk Seconds Per Read: " & vbTab &  _
            objDisk.AvgDiskSecPerRead
        Wscript.Echo "Average Disk Seconds Per Transfer: " & vbTab &  _
            objDisk.AvgDiskSecPerTransfer
        Wscript.Echo "Average Disk Seconds Per Write: " & vbTab &  _
            objDisk.AvgDiskSecPerWrite
        Wscript.Echo "Average Disk Write Queue Length: " & vbTab &  _
            objDisk.AvgDiskWriteQueueLength
        Wscript.Echo "Current Disk Queue Length: " & vbTab &  _
            objDisk.CurrentDiskQueueLength
        Wscript.Echo "Disk Bytes Per Second: " & vbTab &  _
            objDisk.DiskBytesPerSec
        Wscript.Echo "Disk Read Bytes Per Second: " & vbTab &  _
            objDisk.DiskReadBytesPerSec
        Wscript.Echo "Disk Reads Per Second: " & vbTab &  _
            objDisk.DiskReadsPerSec
        Wscript.Echo "Disk Transfers Per Second: " & vbTab &  _
            objDisk.DiskTransfersPerSec
        Wscript.Echo "Disk Write Bytes Per Second: " & vbTab &  _
            objDisk.DiskWriteBytesPerSec
        Wscript.Echo "Disk Writes Per Second: " & vbTab &  _
            objDisk.DiskWritesPerSec
        Wscript.Echo "Free Megabytes: " & vbTab &  objDisk.FreeMegabytes
        Wscript.Echo "Name: " & vbTab &  objDisk.Name
        Wscript.Echo "Percent Disk Read Time: " & vbTab &  _
            objDisk.PercentDiskReadTime
        Wscript.Echo "Percent Disk Time: " & vbTab &  _
            objDisk.PercentDiskTime
        Wscript.Echo "Percent Disk Write Time: " & vbTab &  _
            objDisk.PercentDiskWriteTime
        Wscript.Echo "Percent Free Space: " & vbTab &  _
            objDisk.PercentFreeSpace
        Wscript.Echo "Percent Idle Time: " & vbTab &  _
            objDisk.PercentIdleTime
        Wscript.Echo "Split IO Per Second: " & vbTab &  _
            objDisk.SplitIOPerSec
        Wscript.Sleep 2000
        objRefresher.Refresh
    Next
Next