			KMSAuto Lite Portable 编写由 Ratiborus 
 				  MSFree Inc. 
		    （界面语言及自述文件简体中文化由：YanJun Sun）

          			系统需求： 
                          ----------------------------------
 Windows XP，Windows Vista，7，Windows 8，8.1，10，Server 2008，2008 R2，2012，
 2012 R2，Office 2010/2013/2016 卷许可版（批量许可版或简称 VL）。
 **** 本程序不需要 .NET Framework。****

 			         描述： 
                           ----------------------------------
 KMSAuto Lite - 用于激活操作系统的 KMS-激活程序
 Windows 卷许可版：Vista，7，8，8.1，10，Server 2008，2008 R2，2012， 2012 R2 和
                   Office 2010，2013，2016。
                   您可以在 Windows XP 上激活 Office 2010 卷许可版。
 此外也提供了用于安装 GVLK 密匙和配置重新激活计划任务的开关。

 			         本程序的高级启动选项：
                          ----------------------------------
 /win=act	- 以隐身模式运行本程序，激活 Windows 并退出本程序。
 /ofs=act	- 以隐身模式运行本程序，激活 Office 并退出本程序。
 /wingvlk=inst	- 隐身模式运行本程序，安装 Windows 密匙并退出本程序。
 /ofsgvlk=inst	- 隐身模式运行本程序，安装 Office 密匙并退出本程序。
 /sched=win	- 创建每 25-日重新激活一次 Windows 的计划任务。
 /sched=ofs	- 创建每 25-日重新激活一次 Office 的计划任务。

 *** 强制安装密匙，此参数可以连同其它参数一起应用。
 *** 转换 零售版 -> 卷许可版 仅能转换为非激活的 Office 产品。

 您可以在“设置”窗口内指定 KMS 服务的外部地址。当其激活时则不能运行本程序内置的服务。
 如果激活失败，出现错误代码 0xc004f074，那么请检查并确保您的防火墙软件没有阻止与您
 KMS-服务的连接。
 在您创建了用于重新激活的计划任务（此功能位于本程序的工具窗口内）之后，您可以移动
 本程序至任何位置，甚至可完全移除它，因此其对于重新激活已不是必需的了。

 			         安装 KMS-服务： 
                          ----------------------------------
 您可在“设置”窗口内安装 KMS-服务到您的系统上，便可实现 Windows 7-8 自激活。
 如果设置了地址 127.0.0.2:端口，那么便可激活位于您网络地址上的任何 Windows 系统 和 Office 产品。
 安装的服务不会与重新激活计划任务或使用“激活 Windows”/“激活 Office”功能手动激活冲突。
 如果您的系统为 Windows 8.1，那么激活进程将会安装为特殊的驱动程序且可以在激活后移除之。 对于此配置，
 必须安装 "== Integrated KMS-Service =="。
 您也可以配置用外部服务器激活，在按主窗口内的相关按钮激活时，您的系统设置不会发生改变，激活后
 这些按钮会立即恢复至原始状态。
 您可使用“设置”窗口内的按钮查看服务器运行日志。

 			         "什么也没能激活！！！" 
                          ----------------------------------
 或许您安装的产品为非卷许可版（批量许可版或简称为 VL），其不能使用 KMS-服务激活或是您的反病毒程序拦截了激活过程。
 （本程序不能激活 7 旗舰版）

           —————————————————————————————————————————————————————————————————
                                				 Ratiborus 



版本变更日志：
--------------
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

v1.2.1
 -添加乌克兰界面语言。
 -添加用于 Windows 10 的程序 "Show or hide updates"

v1.2.0
 -重新编译 KMS 服务。
 -添加用于 Windows 10 和 Office 2016 的密匙。

v1.1.9
 -添加开关“随意 IP 地址”。

v1.1.8 
 -添加功能：在 Windows 7-10 转换 Office 2010 ProPlus

v1.1.7 
 -添加功能：保存和恢复激活信息

v1.1.6 
-添加越南界面语言

v1.1.5 
 -添加功能：正确处理 MS Excel。
 -KMS 日志分析器可以处理 KMS-服务的原始日志文件
 -少许界面更改

v1.1.4 
 -仅可单实例运行本程序
 -修复开关 win=act 不能工作于 Windows 7 的错误

v1.1.3 
 -更改界面
 -添加功能：“重置无效的系统状态”

v1.1.2
 -更改界面

v1.1.1 
 -更改界面
 -添加新功能
 -修复强制安装密匙时发生的错误
 -KMS-服务新版本，修复 HWID 输出

 v1.1.0 
 -更改界面
 -添加新功能

 v1.0.8 
 -更改界面
 -添加英语界面语言

 v1.0.7 
 -更改界面 
 -本程序现在可记忆窗口的打开位置
 -添加命令行开关
 -添加功能：用指定参数设置本地 KMS-服务

 v1.0.6 
 -更改界面
 -添加新命令行开关
 -更改本程序某些功能的运算法则 

 v1.0.5.1 
 -更改界面
 -添加功能：自定义 KMS-服务地址和端口。
 -添加功能：在 Windows 7-10 上转换 Office 2013 产品。 

 v1.0.4 
 -更改界面
 -添加功能：用启动参数运行本程序
 -添加功能：创建每 25-日重新激活一次 Windows 和 Office 的计划任务。
	    此功能不可用于 Windows XP。

 v1.0.3 
 -更改界面
 -添加功能：强制安装 GVLK 密匙。

 v1.0.2 
 -修复安装密匙时发生的错误

 v1.0.1 
 -更改界面
 -添加功能：安装 GVLK 密匙

 v1.0.0 
 -初始测试版本
 [/more] 



