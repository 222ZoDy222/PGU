strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
WScript.Echo "Space Left (Data File + Transaction Log) for DB " &_
 strDBName & ": " & objDB.SpaceAvailableInMB & "(MB)"