strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
Set colTables = objDB.Tables
For Each objTable In colTables
   WScript.Echo "Table Name: "    & objTable.Name
Next