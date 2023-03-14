strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
WScript.Echo "Total Size of Data File + Transaction Log of DB " & strDBName & ": " & objDB.Size & "(MB)"