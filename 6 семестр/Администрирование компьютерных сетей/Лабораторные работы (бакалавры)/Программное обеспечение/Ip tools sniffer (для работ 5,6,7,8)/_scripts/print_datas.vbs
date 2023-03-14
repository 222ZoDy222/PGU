If wscript.arguments.count=0 Then wscript.quit
strComputer = wscript.arguments(0)
'On Error Resume Next

Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20

Const adOpenForwardOnly = 0 , adOpenKeyset = 1, adOpenDynamic = 2, adOpenStatic = 3
# '---- LockTypeEnum Values ----
Const adLockReadOnly = 1, adLockPessimistic = 2, adLockOptimistic = 3, adLockBatchOptimistic = 4
Const ForReading=1, ForWriting =2 


   WScript.Echo
   WScript.Echo "=========================================="
   WScript.Echo "Computer: " & strComputer
   WScript.Echo "=========================================="

   Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\CIMV2")
   Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PerfRawData_Spooler_PrintQueue", "WQL", _
                                          wbemFlagReturnImmediately + wbemFlagForwardOnly)

# 'database
 Set dbAccess = CreateObject("ADODB.Connection")
 StrAccess = "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=print.mdb"
 dbAccess.Open(StrAccess)
#
# 'Recordset
 Set Rs = CreateObject("ADODB.Recordset")
 Rs.CursorType = adOpenStatic
 Rs.LockType = adLockOptimistic
 Rs.Open "SELECT * FROM queues" , Straccess 

   For Each objItem In colItems
      Rs.AddNew 
      Rs.Fields("JobErrors") = objItem.JobErrors
      Rs.Fields("printer") = objItem.Name
      Rs.Fields("NotReadyErrors") = objItem.NotReadyErrors
      Rs.Fields("OutofPaperErrors") = objItem.OutofPaperErrors
      Rs.Fields("TotalJobsPrinted") = objItem.TotalJobsPrinted
      Rs.Fields("TotalPagesPrinted") = objItem.TotalPagesPrinted
      rs.fields("date")=now
      rs.update
   Next



 Rs.Close
 Set Rs = Nothing
#
 dbaccess.Close
 Set dbaccess= Nothing 