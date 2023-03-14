strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set colLogins = objSQLServer.logins
For Each objLogin In colLogins 
   WScript.Echo "User: "    & objLogin.Name
Next