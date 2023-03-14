strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
Set colUsers = objDB.Users
For Each objUser In colUsers
   WScript.Echo "User: "    & objUser.Name
   WScript.Echo "Login: "   & objUser.Login
Next