@chcp 65001

@echo off



"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2\Programm2\Debug\Programm2.exe" 10

set dir1 = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog2.bat" 
set dir2 = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog3.bat" 


if %errorlevel% == 0 (
	echo Wrong password
	pause
	exit
) else (
if %errorlevel% == -1 ( 
echo timeout
pause
exit
))

:start 
echo choose actions
echo 1 - IDE
echo 2 - Programming
echo 0 - Exit

set /p choice =

echo %choice %

if %choice % == 1 ( 
	%dir1 %
	goto start
) else (
if %choice % == 2 ( 
	%dir2 % 
	goto start
) else (
if %choice % == 0 ( 
	exit 
) else (
echo wrong number
goto start
)))






 