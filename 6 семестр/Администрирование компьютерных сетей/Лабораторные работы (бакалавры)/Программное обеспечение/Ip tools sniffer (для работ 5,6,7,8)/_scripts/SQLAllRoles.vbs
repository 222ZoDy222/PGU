strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
Set colRoles = objDB.DatabaseRoles
For Each objRole In colRoles
   WScript.Echo "Role Name: "    & objRole.Name
Next