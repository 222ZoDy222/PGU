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
Set colAdapters = objWMIService.ExecQuery _
    ("Select * from Win32_NetworkAdapterConfiguration Where IPEnabled = True")
For Each objAdapter In colAdapters
    Wscript.Echo "Index: " & objAdapter.index
    Wscript.Echo "Host name: " & objAdapter.DNSHostName
    Wscript.Echo "DNS domain: " & objAdapter.DNSDomain
    Wscript.Echo "DNS suffix search list: " & objAdapter.DNSDomainSuffixSearchOrder
    Wscript.Echo "Description: " & objAdapter.Description
    Wscript.Echo "Physical address: " & objAdapter.MACAddress
    Wscript.Echo "DHCP enabled: " & objAdapter.DHCPEnabled
    If Not IsNull(objAdapter.IpAddress) Then
        For i = LBound(objAdapter.IpAddress) To UBound(objAdapter.IpAddress)
            Wscript.Echo "IP address: " & objAdapter.IpAddress(i)
        Next
    End If
    If Not IsNull(objAdapter.IPSubnet) Then
        For i = LBound(objAdapter.IPSubnet) To UBound(objAdapter.IPSubnet)
            Wscript.Echo "Subnet: " & objAdapter.IPSubnet(i)
        Next
    End If
    If Not IsNull(objAdapter.DefaultIPGateway) Then
        For i = LBound(objAdapter.DefaultIPGateway) To UBound(objAdapter.DefaultIPGateway)
            Wscript.Echo "Default gateway: " & objAdapter.DefaultIPGateway(i)
        Next
    End If
    Wscript.Echo "DHCP server: " & objAdapter.DhcpServer
    If Not IsNull(objAdapter.DNSServerSearchOrder) Then
        For i = LBound(objAdapter.DNSServerSearchOrder) To UBound(objAdapter.DNSServerSearchOrder)
            Wscript.Echo "DNS server: " & objAdapter.DNSServerSearchOrder(i)
        Next
    End If
    Wscript.Echo "Primary WINS server: " & objAdapter.WINSPrimaryServer
    Wscript.Echo "Secondary WINS server: " & objAdapter.WINSSecondaryServer
    Wscript.Echo "Lease obtained: " & objAdapter.DHCPLeaseObtained
    Wscript.Echo "Lease expires: " & objAdapter.DHCPLeaseExpires
    Wscript.Echo ""
Next