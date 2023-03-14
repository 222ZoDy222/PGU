echo off
rem	This batch file checks for and sends any outgoing MCI mail
mcidrivr /n
:waitgo
mcidrivr /s
rem	Loop until communications starts up
if errorlevel 1 goto waitstop
goto waitgo
:waitstop
mcidrivr /s
rem	Loop until communications done
if errorlevel 1 goto waitstop
:remove
rem	Remove the driver from memory
mcidrivr /x
