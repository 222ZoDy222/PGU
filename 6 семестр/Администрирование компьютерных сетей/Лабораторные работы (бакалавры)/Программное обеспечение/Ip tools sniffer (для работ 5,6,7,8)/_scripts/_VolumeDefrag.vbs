If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
On Error Resume Next
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colVolumes = objWMIService.ExecQuery("Select * from Win32_Volume")
For Each objVolume in colVolumes
    errResult = objVolume.DefragAnalysis(blnRecommended, objReport)
    If errResult = 0 then
        Wscript.Echo "Average file size: " & objReport.AverageFileSize
        Wscript.Echo "Average fragments per file: " & _
            objReport.AverageFragmentsPerFile
        Wscript.Echo "Cluster size: " & objReport.ClusterSize
        Wscript.Echo "Excess folder fragments: " & _
            objReport.ExcessFolderFragments
        Wscript.Echo "File percent fragmentation: " & _
            objReport.FilePercentFragmentation
        Wscript.Echo "Fragmented folders: " & objReport.FragmentedFolders
        Wscript.Echo "Free soace: " & objReport.FreeSpace
        Wscript.Echo "Free space percent: " & objReport.FreeSpacePercent
        Wscript.Echo "Free space percent fragmentation: " & _
            objReport.FreeSpacePercentFragmentation
        Wscript.Echo "MFT percent in use: " & objReport.MFTPercentInUse
        Wscript.Echo "MFT record count: " & objReport.MFTRecordCount
        Wscript.Echo "Page file size: " & objReport.PageFileSize
        Wscript.Echo "Total excess fragments: " & _
            objReport.TotalExcessFragments
        Wscript.Echo "Total files: " & objReport.TotalFiles
        Wscript.Echo "Total folders: " & objReport.TotalFolders
        Wscript.Echo "Total fragmented files: " & _
            objReport.TotalFragmentedFiles
        Wscript.Echo "Total MFT fragments: " & objReport.TotalMFTFragments
        Wscript.Echo "Total MFT size: " & objReport.TotalMFTSize
        Wscript.Echo "Total page file fragments: " & _
            objReport.TotalPageFileFragments
        Wscript.Echo "Total percent fragmentation: " & _
            objReport.TotalPercentFragmentation
        Wscript.Echo "Used space: " & objReport.UsedSpace
        Wscript.Echo "Volume name: " & objReport.VolumeName
        Wscript.Echo "Volume size: " & objReport.VolumeSize       
        If blnRecommended = True Then
           Wscript.Echo "This volume should be defragged."
        Else
           Wscript.Echo "This volume does not need to be defragged."
        End If
        Wscript.Echo
    End If
Next