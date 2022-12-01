
@chcp 65001
@echo off

SETLOCAL EnableDelayedExpansion

rem cd "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2"

set dir2Programm = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_1\Debug\Programm_2_1.exe"

set dirVisualStudio = "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe"
set dirSublimeText = "C:\Program Files\Sublime Text 3\sublime_text.exe"

set bat1 = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog1.bat"

:start2 
cls
echo choose actions
echo Vs - Visual studio
echo S - Sublime text
echo 0 - Exit

set /p choice =

"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_1\Debug\Programm_2_1.exe" %choice %


if errorlevel 5 goto exit
if errorlevel 2 goto sublime
if errorlevel 1 goto visualStudio



	
echo write another value
rem Если не попадёт ни в одну
goto start2



rem -----------------------------
:visualStudio
	%dirVisualStudio %

goto start2
rem -----------------------------





rem -----------------------------
:sublime
	%dirSublimeText %

goto start2
rem -----------------------------



rem -----------------------------
:exit
"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog1.bat"
rem -----------------------------






