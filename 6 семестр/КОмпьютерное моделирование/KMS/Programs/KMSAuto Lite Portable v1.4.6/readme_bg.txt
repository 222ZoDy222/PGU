
                        KMSAuto Lite Portable от Ratiborus,
                                       MSFree Inc.

       		                 Системни изисквания: 
                          —————————————————————————————————
  Windows XP, Windows Vista, 7, Windows 8, 8.1, 10, Server 2008, 2008 R2, 2012,
2012 R2, Office 2010/2013/2016 VL версии.
  **** Програмата НЕ изисква никакава версия на .NET Framework. ****

       		                      Описание:
                          —————————————————————————————————
  KMSAuto Lite - KMS-активатор за операционни системи на
Windows VL версии: Vista, 7, 8, 8.1, 10, Server 2008, 2008 R2, 2012,
2012 R2 а также Office 2010, 2013, 2016. Възможна е активацията на Office 2010 VL
на Windows XP.
Ключовете/switches осигуряват достъп за инсталация на GVLK ключове и настройка на
планиране на задачите.


	          Допълнителни параметри на пускане на програмата (keys/ключове):
                          —————————————————————————————————
/win=act	- Стартира програмата в тих режим, активира Windows и изключва програмата.

/ofs=act	- Стартира програмата в тих режим, активира Office и изключва програмата.

/wingvlk=inst	- Стартира програмата в тих режим, инсталира Windows ключ и изключва програмата.

/ofsgvlk=inst	- Стартира програмата в тих режим, инсталира Office ключ и изключва програмата.

/sched=win	- Стартира програмата в тих режим, създава планирана задача за активация на
		  Windows на всеки 25 дни.
/sched=ofs	- Стартира програмата в тих режим, създава планирана задача за активация на
		  Office всеки 25 дни. 



 *** Ключовете се инсталират принудително, всички параметри може да се прилагат заедно.
 *** Конвертирането RETAIL -> VL е възможно само за неактивирани офис продукти.

Чрез бутонът "Settings" може да се посочи външен адрес на KMS Service. Вградената в програмата
служба за активация няма да се стартира. При грешка на активацията 0xc004f074 проверете
дали вашият файъруол не забранява връзките с вашия KMS-Service.
Ако искате да създадете планирана задача за реактивация (в програмата има специален бутон
за тази цел), самата програма можете да местите където поискате, даже можете съвсем
да я премахнете, тя не е нужна за реактивиране.


              			Инсталиране на KMS-Service: 
                          —————————————————————————————————
От бутонът "Settings" може да се инсталира в системата KMS-Service, Windows 7-8 ще могат
да се активират от него самостоятелно, при съответната настройка, на адрес 127.0.0.2:порт,
а на вашия мрежов адрес ще могат да се активират всякакви системи и офиси.
Инсталираният сървър не създава конфликт нито с планираните задачи, нито с ръчната активация,
при употреба на бутоните "Activate Windows" и "Activate Office".
Ако системата ви е 8.1, по време на активиране ще се инсталира специален драйвер, който ще
се премахне след активацията.
За това в настройките трябва да бъде инсталиран "== Integrated KMS-Service ==".
Можете да конфигурирате активиране от външен сървър, при активиране с помощта на копчетата
в главният прозорец на програмата вашите системни настройки няма да бъдат изменени, те ще
бъдат възстановени незабавно след активацията.
С помощта на двете копчета в дъното на прозорецът "Settings" можете да преглеждате лог-файлът
на работещия сървър.


   			    "При мен нищо не се активира !!!!" 
                          —————————————————————————————————
Може би вашият продукт не е VL, които не е предназначен за активация чрез KMS-Service
(Windows 7 Ultimate програмата НЕ АКТИВИРА), или вашият файъруол блокира активацията.


           —————————————————————————————————————————————————————————————————
								Ratiborus



Changes in versions: 
v1.4.6 
-Changes in the interface.

v1.4.5
-Added  KMS38 Activation metod.

v1.4.4
-Fixed bugs.

v1.4.2
-KMS Server Service v2.0.7.

v1.4.0
-Added  W10 Digital License Activation metod.

v1.3.9 
-Changes in the interface.

v1.3.8 
-Changes in the interface.

v1.3.7
-The program is completely rewritten.

v1.3.5.3
-Added GVLK Keys.

v1.3.5 
 -Changes in the interface.
*** It is necessary to add folders "C:\Windows\KMSAutoS" and "KMSAuto_Files" to exceptions to your antivirus !!!

v1.3.4
-Fixed bugs.
-KMS Server Service v2.0.4.

v1.3.3
 -Fixed minor bugs.

v1.3.2
-Added GVLK Keys.

v1.3.1
-Added Keys for Windows Server 2016 Essentials.
-KMSSS v2.0.3

v1.3.0
 -Added Keys for Windows Server 2016.

v1.2.9
 -KMSSS v2.0.0.

v1.2.8
 -Re-compiled KMS Service.

v1.2.7
 -Added Keys for Windows 10 and Office 2016.

v1.2.5
 -Small changes in program code.

v1.2.4
 -Changes in program for compatibility with antivirus software.
 -Fixed the nonworking "Install KMS-Service" button.

v1.2.2
 -Added Keys for Windows 10 and Office 2016.

v1.2.1
 -Added interface translation into Ukrainian.
 -Added program for Windows 10 "Show or hide updates"

v1.2.0
 -Re-compiled KMS Service.
 -Added Keys for Windows 10 and Office 2016.

v1.1.9
 -Added switch "Random IP address".


v1.1.8 
 -Added ability to convert Office 2010 ProPlus on Windows 7-10. 

v1.1.7 
 -In program now is built utility to save and restore activation.

v1.1.6 
-Added interface translation into Vietnamese.

v1.1.5 
 -Added function correcting work MS Excel. 
 -KMS Log Analyzer works with the original logfile KMS-Service. 
 -Small changes in the program interface.

v1.1.4 
 -Can launch only one copy of the program. 
 -Fixed a bug at which key win=act was not working on Windows 7

v1.1.3 
 -Changes in the interface. 
 -Added function "Delete state invalid system"

v1.1.2
 -Changes in the interface. 

v1.1.1 
 -Changes in the interface. 
 -Added new functions. 
 -Fixed a bug with the forced installation of the keys. 
 -New version of the KMS-Service, fixed output HWid.

 v1.1.0 
 -Changes in the interface. 
 -Added new functions.

 v1.0.8 
 -Changes in the interface. 
 -Added English interface.

 v1.0.7 
 -Changes in the interface. 
 -The program now remembers the position of her window on the screen. 
 -Added command line switches. 
 -Added ability to set up a local KMS-Service with the specified parameters. 

 v1.0.6 
 -Changes in the interface. 
 -Added new command line switch. 
 -Changed algorithm some features of the program. 

 v1.0.5.1 
 -Changes in the interface. 
 -Added ability to set your address KMS-Service and any port. 
 -Added ability to convert Office 2013 products on Windows 7-10. 

 v1.0.4 
 -Changes in the interface. 
 -Added ability to run the program with the keys. 
 -Added ability to create a task scheduler for reactivation Windows and 
 Office every 25 days. This function does not work on Windows XP. 

 v1.0.3 
 -Changes in the interface. 
 -Added ability to install GVLK keys forcibly. 

 v1.0.2 
 -Fixed error with installation keys. 

 v1.0.1 
 -Changes in the interface. 
 -Added ability to install GVLK keys. 

 v1.0.0 
 -First version, test. 
 [/more] 