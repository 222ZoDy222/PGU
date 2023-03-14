@ECHO OFF

FOR %%i in (*.txt) DO (
	echo %%i
	findstr /c:rrr "%%i" > nul
	if errorlevel==1 (echo 1) else (echo 0)
	echo %errorlevel%

)
