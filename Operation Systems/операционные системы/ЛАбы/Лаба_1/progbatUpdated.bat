


@ECHO OFF
SETLOCAL EnableDelayedExpansion



set /p str =
set /p type =

FOR %%G in (*.%type %) DO (
	rem ------------------------
	
	findstr %str % %%G
	
	IF !ERRORLEVEL! EQU 0 (
		echo in file %%G find string %str %

	) ELSE (
		echo in %%G not find %str %

	)
	rem -------------------------
	

)

rem PAUSE