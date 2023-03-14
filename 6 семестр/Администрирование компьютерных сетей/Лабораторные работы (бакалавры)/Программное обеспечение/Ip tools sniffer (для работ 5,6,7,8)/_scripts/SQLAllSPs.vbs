strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
Set colStoredProcedures = objDB.StoredProcedures
For Each objStoredProcedure In colStoredProcedures
   WScript.Echo "SP Name: "    & objStoredProcedure.Name
Next