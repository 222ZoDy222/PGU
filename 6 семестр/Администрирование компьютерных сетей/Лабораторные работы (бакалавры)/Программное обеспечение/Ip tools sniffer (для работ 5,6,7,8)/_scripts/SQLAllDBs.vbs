strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set colDBs = objSQLServer.databases
For Each objDB In colDBs
   WScript.Echo "DB: "    & objDB.Name
Next