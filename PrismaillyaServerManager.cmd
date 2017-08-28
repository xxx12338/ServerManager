::=========================================================::
::                                                         ::
::  Prismaillya 服务器管理系统 1.0                         ::
::                                                         ::
::  Prismaillya Server Manager 1.0                         ::
::                                                         ::
::  CopyRight © 2012-2017 Prismaillya All Right Reserved.  ::
::                                                         ::
::=========================================================::

@echo off
title Prismaillya Server Manager Ver.1.0
set WORKDIR=%~dp0

@REM 开服器主页部分

:home
title Prismaillya Server Manager Ver.1.0 — 首页
if not exist "Config" mkdir Config
cd Config/
if not exist "Version.ini" cd ../&goto install
if not exist "Ram.ini" echo.1024>Ram.ini
cd ../
for /f %%a in (Config/Version.ini) do set JarName=%%a
for /f %%b in (Config/Ram.ini) do set MaxRam=%%b
cd tools/
for /f "delims=" %%i in ('get_memory.exe') do set ramuse=%%i
wget -q http://temp.tcotp.cn/getip/ -O tempip.txt>nul
for /f %%c in (tempip.txt) do set localip=%%c
del "tempip.txt"
cd ../
set autorestart=禁用
if exist "Config/Restart.ce" set autorestart=启用
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
echo   欢迎使用此管理系统，由 Prismaillya 开发。
echo   如果您在使用中遇到任何问题或者你有更好的建议，欢迎发送邮件到 Prismaillya@tcotp.cn
echo   或者通过下面的功能给我留言！
echo.
echo   版权所有 (C) 2012-2017 Prismaillya 保留所有权利。
echo.
::if %PROCESSOR_ARCHITECTURE%==AMD64 echo   [ 系统提示 ]&echo   您的操作系统是64位的，而本开服器的 Java 是 32 位的。&echo   推荐您使用 64 位版本的 Prismaillya 开服器。&echo   如果您使用 32 位的 Java，将无法设置超过 2GB 的最大内存，并且会降低性能。&echo   64 位的 Prismaillya 开服器请在帖子里下载。&echo.
echo  服务器信息：
echo.
echo   当前内存占用：%ramuse%%%
echo   当前登录用户：%USERNAME%
echo   当前主机名称：%USERDOMAIN%
echo   服务器外网IP：%localip%
echo   关服自动重启：%autorestart%
echo.
echo  选择一项操作开始管理你的服务器
echo.
echo   1.开启您的服务器   3.给作者发送反馈   5.禁用关服后重启
echo.
echo   2.设置服务器信息   4.启用关服后重启   6.退出此管理系统
echo.
set /p doconsole=[INPUT] 请输入您的选择(1/2/3/4/5/6)：
if %doconsole%==1 goto startserver
if %doconsole%==2 goto install
if %doconsole%==3 goto report
if %doconsole%==4 echo.>./Config/Restart.ce&goto home
if %doconsole%==5 cd Config/&del "Restart.ce"&cd ../&goto home
if %doconsole%==6 exit
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
echo  Prismaillya 是一个快捷管理服务器的控制台程序，由 Prismaillya 开发。( 没错，就是这货
echo  你可以使用这个程序一键下载、配置、管理服务器，减去了繁琐的安装配置步骤。
echo  这个程序还有许多不足的地方，如果你有什么好的建议，欢迎告诉我哦！
echo  你可以通过软件主页的“给作者发送反馈”的功能告诉我，我会不断完善不足的地方的噢！
echo  感谢使用！
echo.
echo                                                                    作者：Prismaillya
echo.
echo    QQ：1732182334
echo  官网：www.prismaillya.com
echo  邮箱：Prismaillya@tcotp.cn
echo.
pause>nul
goto home

@REM 服务器启动部分

:startserver
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
set JAVADIR=%WORKDIR%\Java\bin\Java.exe
cd Minecraft/
echo @echo off>launcher.cmd
echo echo serverrunning^>status.pri>>launcher.cmd
echo "%JAVADIR%" -Xmx%MaxRam%M -jar %JarName%>>launcher.cmd
echo del "status.pri">>launcher.cmd
echo echo.>>launcher.cmd
echo echo   服务器已关闭，按下任意键退出控制台。>>launcher.cmd
::echo pause^>nul>>launcher.cmd
echo exit>>launcher.cmd
start "Prismaillya Server Manager Ver.1.0 — 服务器控制台" launcher.cmd
if %errorlevel%==1 echo  [ERROR] 检测到服务器开启时出现了错误。
ping 127.0.0.1 -n 2 >>nul
cd ../
goto status

@REM 状态监控部分

:status
cd tools/
for /f "delims=" %%i in ('%WORKDIR%tools\get_memory.exe') do set ramused=%%i
cd ../
title Prismaillya Server Manager Ver.1.0 — 服务器运行中 已用内存：%ramused%%%
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
echo  服务器已开启，核心名称：%JarName%，最大内存：%MaxRam%
echo.
echo  服务器资源监控：
echo.
echo   已用内存：%ramused% %%
echo.
ping 127.0.0.1>nul
tasklist /FI "WINDOWTITLE eq Prismaillya Server Manager Ver.1.0 — 服务器控制台 - launcher.cmd"|find "cmd.exe"
if %errorlevel%==0 goto status
if %errorlevel%==1 goto serverstop
if exist "Minecraft/status.pri" goto status

@REM 服务器已经停止

:serverstop
cd Minecraft/
del "launcher.cmd"
if exist "status.pri" del "status.pri"
cd ../
title Prismaillya Server Manager Ver.1.0 — 服务器已关闭
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
echo  检测到服务器已关闭。
echo.
echo  服务器自动重启功能已%autorestart%。
echo.
ping 127.0.0.1>nul
if exist "Config/Restart.ce" echo  正在重启服务器...&goto startserver
goto home

@REM 给作者发送反馈部分

:report
cls
echo.
echo  —— Prismaillya 服务器管理系统 ——————————
echo.
echo  您在使用中遇到什么问题，或者您有什么好的建议，可以通过这里反馈给我！
echo.
echo  输入 back 就可以返回上一页，输入其他内容则提交给作者。
echo.
echo  如果您需要换行，请输入[n]，两边的括号也要输入。
echo.
echo  建议您在留言中附上您的联系方式，方便作者联系您~
echo.
set /p reporttext=[INPUT] 在这里输入您的反馈：
if %reporttext%==back goto home
cd tools/
start /MIN cmd /c curl -d "ip=%localip%&report=%reporttext%" -A "Prismaillya" https://www.prismaillya.com/Prismaillya/ServerManager/report/>>nul
echo.
echo  反馈提交成功！
echo.
echo  按下任意键就会自动退出......
echo  作者也不知道什么原因 ( 滑稽
echo  可能是程序设计问题 233333
echo  请手动重启程序......
echo.
pause>nul
exit

@REM 配置模式部分

:install
title Prismaillya Server Manager Ver.1.0 — 服务器设置
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   欢迎使用 Prismaillya 开服器，目前进入配置模式。
echo.
echo   按下任意键开始配置服务器。
pause>nul
echo.
echo   请输入你想要开的服务器类型
echo.
echo   1.PaperSpigot        (推荐)(可开纯净服务器，支持插件)
echo.
echo   2.Cauldron           (可开Mod服务器，支持 forge 和插件，原 MCPC)
echo.
echo   3.Minecraft Server   (官方服务器，不支持Mod和插件)
echo.
echo   4.CraftBukkit        (可开纯净服务器，支持插件)
echo.
echo   5.Spigot             (可开纯净服务器，支持插件)
echo.
echo   6.我要使用自己的核心文件
echo.
set /p installtype=[INPUT] 请输入你想要安装的类型(数字1/2/3/4/5/6)：
if %installtype%==1 goto installpaperspigot
if %installtype%==2 goto installcauldron
if %installtype%==3 goto installminecraftserver
if %installtype%==4 goto installcraftbukkit
if %installtype%==5 goto installspigot
if %installtype%==6 goto installcustom
goto install

@REM 安装PaperSpigot部分

:installpaperspigot
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请输入需要安装的 PaperSpigot 版本，可选的版本有：
echo.
echo   1 ) 1.7.10
echo   2 ) 1.8
echo   3 ) 1.8.8
echo   4 ) 1.11.2
echo   5 ) 1.12
echo.
set /p installversion=[INPUT] 请输入你想要安装的版本(数字1/2/3/4/5)：
if %installversion%==1 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.7.10-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==2 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.8-R0.1-SNAPSHOT-b235.jar&goto downloadFile
if %installversion%==3 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.11.2-b1040.jar&goto downloadFile
if %installversion%==5 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.12-latest.jar&goto downloadFile
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您选择的版本不正确。
echo.
pause>nul
goto installpaperspigot

@REM 安装Cauldron部分

:installcauldron
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请输入需要安装的 Cauldron 版本，可选的版本有：
echo.
echo   1 ) 1.7.2
echo   2 ) 1.7.10
echo.
set /p installversion=[INPUT] 请输入你想要安装的版本(数字1/2)：
if %installversion%==1 set downloadtype=Cauldron&set downloadname=cauldron-1.7.2-1.1147.04.98-server.zip&goto downloadFile
if %installversion%==2 set downloadtype=KCauldron&set downloadname=KCauldron-1.7.10-1614.201-bundle.zip&goto downloadFile
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您选择的版本不正确。
echo.
pause>nul
goto installcauldron

@REM 安装Minecraft_Server部分

:installminecraftserver
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请输入需要安装的 Minecraft Server 版本，可选的版本有：
echo.
echo   1 ) 1.7.2
echo   2 ) 1.7.10
echo   3 ) 1.8
echo   4 ) 1.8.8
echo   5 ) 1.9.4
echo   6 ) 1.10.1
echo   7 ) 1.10.2
echo   8 ) 1.11.1
echo   9 ) 1.11.2
echo   10) 1.12
echo.
set /p installversion=[INPUT] 请输入你想要安装的版本(数字1/2/3/4/5/6/7/8/9/10)：
if %installversion%==1 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.7.2.jar&goto downloadFile
if %installversion%==2 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.7.10.jar&goto downloadFile
if %installversion%==3 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.8.jar&goto downloadFile
if %installversion%==4 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.8.8.jar&goto downloadFile
if %installversion%==5 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.9.4.jar&goto downloadFile
if %installversion%==6 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.10.1.jar&goto downloadFile
if %installversion%==7 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.10.2.jar&goto downloadFile
if %installversion%==8 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.11.1.jar&goto downloadFile
if %installversion%==9 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.11.2.jar&goto downloadFile
if %installversion%==10 set downloadtype=Minecraft_Server&set downloadname=minecraft_server.1.12.jar&goto downloadFile
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您选择的版本不正确。
echo.
pause>nul
goto installminecraftserver

@REM 安装CraftBukkit部分

:installcraftbukkit
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请输入需要安装的 CraftBukkit 版本，可选的版本有：
echo.
echo   1 ) 1.7.2
echo   2 ) 1.7.10
echo   3 ) 1.8
echo   4 ) 1.8.8
echo   5 ) 1.9.4
echo   6 ) 1.10.2
echo   7 ) 1.11.2
echo.
set /p installversion=[INPUT] 请输入你想要安装的版本(数字1/2/3/4/5/6/7)：
if %installversion%==1 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.7.2-R0.4-20140216.012104-3.jar&goto downloadFile
if %installversion%==2 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.7.10-R0.1-20140808.005431-8.jar&goto downloadFile
if %installversion%==3 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==5 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.9.4-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==6 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.10.2-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==7 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.11.2-R0.1-SNAPSHOT.jar&goto downloadFile
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您选择的版本不正确。
echo.
pause>nul
goto installcraftbukkit

@REM 安装Spigot部分

:installspigot
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请输入需要安装的 Spigot 版本，可选的版本有：
echo.
echo   1 ) 1.7.10
echo   2 ) 1.8
echo   3 ) 1.8.8
echo   4 ) 1.11.2
echo.
set /p installversion=[INPUT] 请输入你想要安装的版本(数字1/2/3/4)：
if %installversion%==1 set downloadtype=Spigot&set downloadname=spigot-1.7.10-SNAPSHOT-b1643.jar&goto downloadFile
if %installversion%==2 set downloadtype=Spigot&set downloadname=spigot-1.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==3 set downloadtype=Spigot&set downloadname=spigot-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=Spigot&set downloadname=spigot-1.11.2-R0.1-SNAPSHOT.jar&goto downloadFile
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您选择的版本不正确。
echo.
pause>nul
goto installspigot

@REM 自定义 JAR 核心部分

:installcustom
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   请先将你想要自定义的 Jar 放入本开服器的 Minecraft 文件夹中。
echo.
echo   然后输入你的自定义 Jar 核心名字，不要输入结尾的“.jar”
echo.
set /p customjarname=[INPUT] 输入JAR名字：
if exist "Minecraft/%customjarname%.jar" set downloadtype=Custom&goto settingserver
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   [错误]您输入的自定义 Jar 核心不存在，请确认该文件在本开服器的 Minecraft 文件夹里。
echo.
pause>nul
goto installcustom

@REM 文件下载部分

:downloadFile
title Prismaillya Server Manager Ver.1.0 — 下载核心
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo   准备开始下载......
echo.
echo     [文件信息]
echo.
echo     您选择的下载类型是：%downloadtype%
echo.
echo     即将下载的文件名是：%downloadname%
echo.
echo   按下任意键开始下载选中版本，按下 Ctrl + C 退出下载。
pause>nul
echo.
echo   正在开始下载：http://cdn.tcotp.cn/download/server/%downloadtype%/%downloadname%
echo.
echo   下载大约需要 10 秒的时间，请耐心等待！
echo.
echo   我们使用付费阿里云 OSS 为你带来最快的下载体验！
echo.

@REM 如果已经存在该版本，则删除

if exist "Minecraft/%downloadname%" del "Minecraft/%downloadname%"
set DType=%downloadtype%

@REM 如果是 KCauldron 版本，因为API特殊原因，KCauldron 被分类在了 Cauldron 下

if %downloadtype%==KCauldron set DType=Cauldron
cd tools/

@REM 开始下载核心

wget.exe -P ../Minecraft/ http://cdn.tcotp.cn/download/server/%DType%/%downloadname% >nul
title Prismaillya Server Manager Ver.1.0 — 核心下载完成
cd ../
echo.
echo   %downloadname% 下载完成！已下载到 Minecraft 目录！

@REM 如果是 KCauldron 或 Cauldron

if %downloadtype%==Cauldron echo   您下载的是安装包版本，需要解压，按下任意键开始解压！&pause>nul&goto unzip
if %downloadtype%==KCauldron echo   您下载的是安装包版本，需要解压，按下任意键开始解压！&pause>nul&goto unzip
goto settingserver

@REM 解压文件

:unzip
title Prismaillya Server Manager Ver.1.0 — 解压核心文件
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  正在解压 %downloadname%......
cd Minecraft/
start ../tools/7z.exe x %downloadname%>nul
echo.
echo  %downloadname% 解压完成！
echo.
echo  按下任意键开始配置服务器。
cd ../

@REM 服务器设置部分

:settingserver
title Prismaillya Server Manager Ver.1.0 — 配置服务器信息
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  很好，很清真。
echo.
echo  服务端核心已经配置完成了，现在开始配置服务器功能。
echo.
echo  请按下任意键开始配置。
pause>nul
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  给你的服务器起一个名字吧，允许中文、英文、数字以及下划线。
echo.
set /p servername=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  你想要给服务器分配多大的内存？单位 MB，默认1024
::echo  注意：此版本为 32 位版本，最大内存请不要设置超过 1024！否则无法启动！
echo.
set /p maxram=[INPUT] 请输入数字：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  你想要让服务器运行在哪个端口？默认：25565
echo.
set /p serverport=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  最大允许多少个玩家同时在线？请输入数字。
echo.
set /p maxplayers=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  是否允许玩家PVP(互相攻击)？是true/否false
echo.
set /p pvp=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  是否允许玩家进入地狱？是true/否false
echo.
set /p allownether=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  是否开启白名单认证？不在白名单内的玩家无法进入服务器！是true/否false
echo.
set /p whitelist=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  是否开启正版登陆模式？是true/否false
echo.
set /p onlinemode=[INPUT] 请输入：
cls
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  请输入服务器的主世界名字，不支持中文。
echo.
set /p levelname=[INPUT] 请输入：
cls

@REM 开始写入配置文件

echo server-name=%servername%>./Minecraft/server.properties
echo allow-nether=%allownether%>>./Minecraft/server.properties
echo pvp=%pvp%>>./Minecraft/server.properties
echo enable-command-block=true>>./Minecraft/server.properties
echo max-players=%maxplayers%>>./Minecraft/server.properties
echo server-port=%serverport%>>./Minecraft/server.properties
echo level-name=%levelname%>>./Minecraft/server.properties
echo white-list=%whitelist%>>./Minecraft/server.properties
echo online-mode=%onlinemode%>>./Minecraft/server.properties
echo motd=\u00a7c\u00a7l[ \u00a7d\u00a7lPrismaillya \u00a7c\u00a7l] \u00a7aMinecraft \u00a76Server>>./Minecraft/server.properties
echo eula=true>./Minecraft/eula.txt
echo %maxram%>./Config/Ram.ini
echo %downloadname%>./Config/Version.ini

@REM 如果是 Cauldron 或 KCauldron

if "%downloadtype%"=="Cauldron" echo cauldron-1.7.2-1.1147.04.98-server.jar>./Config/Version.ini
if "%downloadtype%"=="KCauldron" echo KCauldron.jar>./Config/Version.ini
if "%downloadtype%"=="Custom" echo %customjarname%.jar>./Config/Version.ini

@REM 配置完成

title Prismaillya Server Manager Ver.1.0 — 配置完成
echo.
echo  —— Prismaillya 服务器配置模式 ——————————
echo.
echo  恭喜！服务器已经配置完成了！
echo.
echo  您现在已经可以开启您的服务器了！
echo.
echo  按下任意键跳转到主界面！
echo.
pause>nul
goto home
