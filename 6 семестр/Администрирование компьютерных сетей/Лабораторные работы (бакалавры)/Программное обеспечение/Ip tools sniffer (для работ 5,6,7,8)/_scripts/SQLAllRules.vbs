strDBServerName = wscript.arguments(0)
strDBName = "tempdb"
Set objSQLServer = CreateObject("SQLDMO.SQLServer")
objSQLServer.LoginSecure = True
objSQLServer.Connect strDBServerName
Set objDB = objSQLServer.Databases(strDBName)
Set colRules = objDB.Rules
For Each objRule In colRules
   WScript.Echo "Rule Name: "    & objRule.Name
Next