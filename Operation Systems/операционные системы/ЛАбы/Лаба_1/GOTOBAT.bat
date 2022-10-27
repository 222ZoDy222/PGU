@ECHO OFF
IF EXIST delete.txt (
    Echo deleting delete.txt 
    Del delete.txt 
 ) ELSE ( 
    Echo The file was not found. Should create!
    copy /y NUL delete.txt >NUL
 )