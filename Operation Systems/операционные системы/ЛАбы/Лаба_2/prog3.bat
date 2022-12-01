
@chcp 65001
@echo off

SETLOCAL EnableDelayedExpansion

rem cd "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2"

set dir2Programm = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_1\Debug\Programm_2_1.exe"

set dirPython = "C:\Users\nikgo\AppData\Local\Programs\Python\Python38\python.exe"
set dirCalculate = "C:\Windows\System32\calc.exe"
set dirGithub = "C:\Users\nikgo\AppData\Local\GitHubDesktop\GitHubDesktop.exe"

set bat1 = "D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog1.bat"

:start2
cls 
echo choose actions
echo p- Python
echo c - Calculator
echo g - GitHub
echo 0 - Exit

set /p choice =

"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\Programm_2_2\Debug\Programm_2_2.exe" %choice %


if errorlevel 5 goto exit
if errorlevel 3 goto GitHub
if errorlevel 2 goto Calculator
if errorlevel 1 goto python

cls

	
echo write another value
rem Если не попадёт ни в одну
goto start2



rem -----------------------------
:python
	%dirPython %

goto start2
rem -----------------------------





rem -----------------------------
:Calculator
	%dirCalculate %

goto start2
rem -----------------------------





rem -----------------------------
:GitHub
	%dirGithub %
goto start2
rem -----------------------------



rem -----------------------------
:exit
"D:\универ\PGU\Operation Systems\операционные системы\ЛАбы\Лаба_2\prog1.bat"
rem -----------------------------






