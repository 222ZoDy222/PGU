''Get CPU info
If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)

Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery  ("Select * from Win32_ComputerSystemProduct") ' Where Default = True")

For Each objPrinter in colInstalledPrinters
    'Wscript.Echo "Vendor:" & objPrinter.Vendor
    'Wscript.Echo "Name:" & objPrinter.Name
    Wscript.Echo objPrinter.IdentifyingNumber
Next