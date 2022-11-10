echo off

rem cd "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2"

set dir2Programm = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_1\Debug\Programm_2_1.exe"

set dirVisualStudio = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
set dirSublimeText = "C:\Program Files\Sublime Text 3\sublime_text.exe"

set bat1 = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog1.bat"

:start2 
echo choose actions
echo Vs - Visual studio
echo S - Sublime text
echo 0 - Exit

set /p choice =

"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_1\Debug\Programm_2_1.exe" %choice %

echo %errorlevel%
pause

IF %errorlevel% == 1 (
	echo -1
pause
	rem call %dirVisualStudio  %
	goto start2 
) else (
if %errorlevel% == 2 (
	echo -2
	rem call %dirSublimeText % 
	goto start2 
) else (
if %errorlevel% == 5 (
	echo -3
	rem %bat1 % 
) else (
	echo wrong number
	goto start2
)
pause