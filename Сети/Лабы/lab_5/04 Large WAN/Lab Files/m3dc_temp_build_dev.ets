File format:			program execution
Title:					"Create an IP Router"
Program:				"op_devcreate -rec_err_suppress TRUE -ets_mode ip 'core technologies:' 'ip, ip_router, ip_generic' 'IP Processing Information' 'SET' 'IP Routing Parameters' 'SET' 'BGP Parameters' 'SET' 'OSPF Parameters' 'SET' 'RIP Parameters' 'SET' 'IGRP Parameters' 'SET' 'EIGRP Parameters' 'SET' 'MPLS Parameters' 'SET' 'RSVP Protocol Parameters' 'SET' 'LDP Parameters' 'SET' 'IS-IS Parameters' 'SET' 'System Management' 'Not Configured' 'HSRP Parameters' 'Not Configured'"
 
Blocking:				yes
Open model:				no
Open text file:			yes
Save current model:		no
Current model name:		no
Current model pathname:	no
Next ets command:		go_file m3dc_success
Current environment: 	yes
start_argument
		argument:		"Model name:"
		type:			"string"
		value:			"my_router,Edit..."
end_argument
start_argument
	argument:	"Model list:"
	type:		string
value:	"my_model_list,3Com,ACE,applications,Ascend,atm,atm_advanced,atm_lane,atm_lane_advanced,Avici,Bay_Networks,bridges,Cabletron,Cisco,client_server,demands,Equipe,ethcoax,ethernet,ethernet_advanced,eXtreme,fddi,Fore_Systems,Foundry,frame_relay,frame_relay_advanced,Hewlett_Packard,hla_interface,internet_toolbox,Juniper,LANE-office_complex,LANE-README,LANs,Layer_4_Switch,Layer_4_Switch_adv,links,links_advanced,Load_Balancers,Lucent,NEC,Newbridge,Nortel,routers,routers_advanced,RPG,sdr,sip,Sm_Int_Model_List,SNA_CIP-Telnet_session,Standard_Chartered_Bank_Network,TCP_Window_Size_Reference,token_ring,transport,utilities,VLANs,WAN-campus_HighLoad,WAN-campus_LowLoad,WAN-campus_MediumLoad,WAN-client_server,wireless_lan,wireless_lan_adv,xDSL_toolkit,Edit..."
end_argument

start_argument
		argument:		"Icon name:"
		type:			"string"
		value:			"router,Edit..."
end_argument
start_argument
         argument:      "IP Routing Speed: (pkts/sec)"
         type:          "string"
         value:         "150000,Edit..."
end_argument
start_argument
		argument:		" "
		type:			"string"
		value:			",Edit..."
end_argument
start_argument
		argument:		"ATM: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"DOCSIS: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"Ethernet: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"Ethernet LANE: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"EtherChannel: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"FDDI: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"Frame Relay: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"SLIP: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"Token Ring: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"TR LANE: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
start_argument
		argument:		"Wireless LAN: "
		type:			"string"
		value:			"0,1,2,4,8,16,32,Edit..."
end_argument
