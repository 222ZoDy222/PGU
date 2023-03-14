''Get CPU info
If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
wscript.echo "System Information for " & strcomputer & Chr(10)

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set colChassis = objWMIService.ExecQuery ("SELECT * FROM Win32_SystemEnclosure")
For Each objChassis in colChassis
For Each intType in objChassis.ChassisTypes
desc = intType
If	desc = 1 Then PCkind = "Other" '' Could use Virtual here for VM machine. ''VM machines have in my testing always pulled this Category.
If	desc = 2 Then PCkind = "Unknown"
If	desc = 3 Then PCkind = "Desktop"
If	desc = 4 Then PCkind = "Low Profile Desktop"
If	desc = 5 Then PCkind = "Pizza Box"
If	desc = 6 Then PCkind = "Mini Tower"
If	desc = 7 Then PCkind = "Tower"
If	desc = 8 Then PCkind = "Portable"
If	desc = 9 Then PCkind = "Laptop"
If	desc = 10 Then PCkind = "Notebook"
If	desc = 11 Then PCkind = "Hand Held"
If	desc = 12 Then PCkind = "Docking Station"
If	desc = 13 Then PCkind = "All in One"
If	desc = 14 Then PCkind = "Sub Notebook"
If	desc = 15 Then PCkind = "Space-Saving"
If	desc = 16 Then PCkind = "Lunch Box"
If	desc = 17 Then PCkind = "Main System Chassis"
If	desc = 18 Then PCkind = "Expansion Chassis"
If	desc = 19 Then PCkind = "SubChassis"
If	desc = 20 Then PCkind = "Bus Expansion Chassis"
If	desc = 21 Then PCkind = "Peripheral Chassis"
If	desc = 22 Then PCkind = "Storage Chassis"
If	desc = 23 Then PCkind = "Rack Mount Chassis"
If	desc = 24 Then PCkind = "Sealed-Case PC"
 ctype = "Chassis Types : "& desc &" - "& PCkind ''intType
 wscript.echo ctype

'' You can uncheck the message boxes if you want to see the info recorded.
''MsgBox ctype, 0,"Chassis Types"
Next
Next

Set SystemSet = objWMIService.ExecQuery ("SELECT * FROM Win32_ComputerSystem")
For each System in SystemSet
	system_name = System.Caption 
        system_type = System.SystemType
	system_mftr = System.Manufacturer
	system_model = System.Model
next

Set ProcSet = objWMIService.ExecQuery ("SELECT * FROM Win32_Processor")
For each System in ProcSet
	proc_desc = System.Caption 
	proc_mftr = System.Manufacturer
	proc_mhz = System.CurrentClockSpeed
next

Set BiosSet = objWMIService.ExecQuery ("SELECT * FROM Win32_BIOS")
For each System in BiosSet
	bios_info = System.Version
next

'' I need to research this better to have it convert to a more recognizable format.

Set ZoneSet = objWMIService.ExecQuery ("SELECT * FROM Win32_TimeZone")
For each System in ZoneSet
	loc_timezone = System.StandardName
next

Set OS_Set = objWMIService.ExecQuery ("SELECT * FROM Win32_OperatingSystem")
For each System in OS_Set
	os_name = System.Caption
        os_version = System.Version
	os_mftr = System.Manufacturer
	os_build = System.BuildNumber
	os_dir = System.WindowsDirectory
        os_locale = System.Locale
	os_totalmem = System.TotalVisibleMemorySize
	os_freemem = System.FreePhysicalMemory
        os_totalvirmem = System.TotalVirtualMemorySize
	os_freevirmem = System.FreeVirtualMemory
	os_pagefilesize = System.SizeStoredInPagingFiles
next

'' Write info to CSV or text file.
strResponseText = ("OS Name:  " & os_name & Chr(10))
strResponseText = strResponseText & ("Version:  " & os_version & " Build " & os_build & Chr(10))
strResponseText = strResponseText & ("OS Manufacturer:  " & os_mftr & Chr(10))
strResponseText = strResponseText & ("System Name:  " & system_name & Chr(10))
strResponseText = strResponseText & ("System Manufacturer:  " & system_mftr & Chr(10))
strResponseText = strResponseText & ("System Model:  " & system_model & Chr(10))
strResponseText = strResponseText & ("System Type:  " & system_type & Chr(10))
strResponseText = strResponseText & ("Processor:  " & proc_desc & " " & proc_mftr & " ~" & proc_mhz & "Mhz" & Chr(10))
'strResponseText = strResponseText & ("BIOS Version:  " & bios_info & Chr(10))
strResponseText = strResponseText & ("Windows Directory:  " & os_dir & Chr(10))
'strResponseText = strResponseText & ("Locale:  " & os_locale & Chr(10))  
'strResponseText = strResponseText & ("Time Zone:  " & loc_timezone & Chr(10))
strResponseText = strResponseText & ("Total Physical Memory:  " & os_totalmem & "KB" & Chr(10))
'strResponseText = strResponseText & ("Available Physical Memory:  " & os_freemem & "KB" & Chr(10))
strResponseText = strResponseText & ("Total Virtual Memory:  " & os_totalvirmem & "KB" & Chr(10))
'strResponseText = strResponseText & ("Available Virtual Memory:  " & os_freevirmem & "KB" & Chr(10))
strResponseText = strResponseText & ("Page File Space : " & os_pagefilesize & "KB" )
wscript.echo strResponseText

 
Set DiskSet = objWMIService.ExecQuery("Select * from Win32_LogicalDisk where deviceid='C:'",,48)
For Each objItem in DiskSet
    Wscript.Echo "DiskSpace on C drive (Free/Total): " & round(objItem.FreeSpace / 1024 / 1024,0) & "MB / " & round(objItem.Size / 1024 / 1024,0) & "MB"
Next  
 
''MsgBox strResponseText, 0,"System Summary Information"


Set colInstalledPrinters =  objWMIService.ExecQuery  ("Select * from Win32_ComputerSystemProduct") ' Where Default = True")
For Each objPrinter in colInstalledPrinters
    'Wscript.Echo "Vendor:" & objPrinter.Vendor
    'Wscript.Echo "Name:" & objPrinter.Name
    Wscript.Echo "IdentifyingNumber:" & objPrinter.IdentifyingNumber
Next