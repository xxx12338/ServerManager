::===========================================================::
::                                                           ::
::  Prismaillya ����������ϵͳ 1.3                           ::
::                                                           ::
::  Prismaillya Server Manager 1.3                           ::
::                                                           ::
::  CopyRight (C) 2012-2018 Prismaillya All Right Reserved.  ::
::                                                           ::
::===========================================================::

@echo off
title Prismaillya Server Manager

@REM �޸����ڴ�С�� Windows 7 ������ʾ����ȷ������

mode con:cols=120 lines=30

@REM ����ȫ��·����ַ

set WORKDIR=%~dp0

@REM ���ñ��ذ汾��

set localversion=1.3

@REM �����²���

echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo   Prismaillya^> Loading Config, Please wait......
ping 127.0.0.1 -n 2 >nul
echo   Prismaillya^> Checking update......
curl -s https://prisma-illya.github.io/ServerManager/version.txt -o version.txt>nul
for /f %%v in (version.txt) do set newversion=%%v
del "version.txt"
echo   Prismaillya^> Getting System Info......
systeminfo|find "�����ڴ�����">systeminfo.txt
for /f "tokens=1*" %%d in (systeminfo.txt) do set systemram=%%e
del "systeminfo.txt"
set systemram=%systemram:,=%
set systemram=%systemram: MB=%
set /a systemrams=%systemram%/1000
if not "%newversion%"=="%localversion%" goto update
cd tools/
if not exist "RemoteStart.jar" goto unknownversion
cd ../

@REM ��������ҳ����

:home

@REM ��ת����Ŀ¼

cd %WORKDIR%
title Prismaillya Server Manager Ver.%localversion% �� ��ҳ
if not exist "Config" mkdir Config
if not exist "Minecraft" mkdir Minecraft
if not exist "Java" goto javanotfound
if not exist "tools" goto toolsnotfound
if exist "7z.exe" del "7z.exe"
if exist "curl.exe" del "curl.exe"
if exist "7z.dll" del "7z.dll"
if exist "libcurl.dll" del "libcurl.dll"
if exist "curl-ca-bundle.crt" del "curl-ca-bundle.crt"
cd Config/
if not exist "%WORKDIR%\Config\Version.ini" cd ../&goto install
if not exist "%WORKDIR%\Config\Ram.ini" echo.1024>Ram.ini
cd ../
for /f %%a in (Config/Version.ini) do set JarName=%%a
for /f %%b in (Config/Ram.ini) do set MaxRam=%%b
cd tools/
for /f "delims=" %%i in ('get_memory.exe') do set ramuse=%%i
wget -q http://temp.tcotp.cn/getip/?from=smg -O tempip.txt>nul
for /f %%c in (tempip.txt) do set localip=%%c
del "tempip.txt"
curl -s https://www.prismaillya.com/Prismaillya/ServerManager/message/ -o message.txt
for /f %%m in (message.txt) do set sysmessage=%%m
del "message.txt"
cd ../
set autorestart=����
set JAVADIR=%WORKDIR%Java\bin\Java.exe
if exist "Config/Restart.ce" set autorestart=����
set tempram=%ramuse%*100
set /a issueram1=%systemram%*%ramuse%
set /a issueram2=%issueram1%/100000
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo   ��ӭʹ�ô˹���ϵͳ���� Prismaillya ������
echo   �������ʹ���������κ�����������и��õĽ��飬��ӭ�����ʼ��� Prismaillya@tcotp.cn
echo   ����ͨ������Ĺ��ܸ������ԣ�
echo.
echo   ��Ȩ���� (C) 2012-2017 Prismaillya ��������Ȩ����
echo.
::if %PROCESSOR_ARCHITECTURE%==AMD64 echo   [ ϵͳ��ʾ ]&echo   ���Ĳ���ϵͳ��64λ�ģ������������� Java �� 32 λ�ġ�&echo   �Ƽ���ʹ�� 64 λ�汾�� Prismaillya ��������&echo   �����ʹ�� 32 λ�� Java�����޷����ó��� 2GB ������ڴ棬���һή�����ܡ�&echo   64 λ�� Prismaillya �������������������ء�&echo.
::��������������
echo  �������������Щ��������Щ���������������������������������������������������������
echo  ����������Ϣ��ϵͳ��ʾ��  Powered by Prismaillya(https://www.prismaillya.com/)  ��
echo  �������������ة��������ة���������������������������������������������������������
echo  ����ǰ�ڴ�ռ�ã�%issueram2%G / %systemrams%G (%ramuse%%%)
echo  ����ǰ��¼�û���%USERNAME%
echo  ����ǰ�������ƣ�%USERDOMAIN%
echo  ������������IP��%localip%
echo  ���ط��Զ�������%autorestart%
echo  ��ϵͳ������Ϣ��%NUMBER_OF_PROCESSORS% ���Ĵ�������%systemrams%G �ڴ�
echo  ���������������������������������Щ�����������������������������������������������
echo  ��ѡ��һ�������ʼ������ķ������� ��ʾ����M�ɰ��죬��E����ͧ��                 ��
echo  ���������������������Щ����������ة������Щ������������������Щ�������������������
echo  �� 1.�������ķ����� �� 4.���ùط������� �� 7.��շ����Ŀ¼ ��10.Unicode ת���� ��
echo  ���������������������੤�����������������੤�����������������੤������������������
echo  �� 2.���÷�������Ϣ �� 5.���ùط������� �� 8.���ݷ�������ͼ ��11.ǿ�ƽ��������� ��
echo  ���������������������੤�����������������੤�����������������੤������������������
echo  �� 3.�����߷��ͷ��� �� 6.ħ������Դ�㳡 �� 9.Զ�̷��ʷ����� ��12.�˳����������� ��
echo  ���������������������ة������������������ة������������������ة�������������������
echo.
set /p doconsole=[INPUT] ����������ѡ��(1/2/3/4/5/6/7/8/9/10/11/12)��
if "%doconsole%"=="1" goto startserver
if "%doconsole%"=="2" goto install
if "%doconsole%"=="3" goto report
if "%doconsole%"=="4" echo.>./Config/Restart.ce&goto home
if "%doconsole%"=="5" cd Config/&del "Restart.ce"&cd ../&goto home
if "%doconsole%"=="6" goto magicgirlshop
if "%doconsole%"=="7" goto cleardir
if "%doconsole%"=="8" goto backupmap
if "%doconsole%"=="9" goto remotestart
if "%doconsole%"=="10" start https://www.prismaillya.com/unicode&goto home
if "%doconsole%"=="11" goto ssstop
if "%doconsole%"=="12" exit
if "%doconsole%"=="e" goto excited
if "%doconsole%"=="E" goto excited
if "%doconsole%"=="m" goto iamangry
if "%doconsole%"=="M" goto iamangry
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  Prismaillya ��һ����ݹ���������Ŀ���̨������ Prismaillya ������( û���������
echo  �����ʹ���������һ�����ء����á��������������ȥ�˷����İ�װ���ò��衣
echo  �����������಻��ĵط����������ʲô�õĽ��飬��ӭ������Ŷ��
echo  �����ͨ�������ҳ�ġ������߷��ͷ������Ĺ��ܸ����ң��һ᲻�����Ʋ���ĵط����ޣ�
echo  PS����Ȼ˵��������д������޽������(\\\\)...�������ǡ�����л���ʹ�ã�
echo.
echo                                                                    ���ߣ�Prismaillya
echo.
echo    QQ��1732182334
echo  ������www.prismaillya.com
echo  ���䣺Prismaillya@tcotp.cn
echo.
pause>nul
goto home

@REM ��M�ɰ���

:iamangry
echo @echo off>./tools/player.cmd
echo title Prismaillya MusicPlayer>>./tools/player.cmd
echo "%JAVADIR%" -jar MusicPlayer.jar echo_notitle.mp3>>./tools/player.cmd
echo exit>>./tools/player.cmd
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ��ӭ���� ���� - Echo
echo.
echo  �ڲ������а��� Ctrl + C ��ֱ�ӹرռ���ֹͣ���š�
echo.
cd tools/
start player.cmd
cd ../
ping 127.0.0.1>>nul
goto home

@REM ��E����ͧ

:excited
echo @echo off>./tools/player.cmd
echo title Prismaillya MusicPlayer>>./tools/player.cmd
echo "%JAVADIR%" -jar MusicPlayer.jar colorx3d.mp3>>./tools/player.cmd
echo exit>>./tools/player.cmd
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ��ӭ���� ����Բ - Color-X 3D
echo.
echo  �ڲ������а��� Ctrl + C ��ֱ�ӹرռ���ֹͣ���š�
echo.
cd tools/
start player.cmd
cd ../
ping 127.0.0.1>>nul
goto home

@REM ǿ�ƽ�������������

:ssstop
cd %WORKDIR%
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ǿ�ƽ��������������ܻᵼ�����ݶ�ʧ��
echo.
echo  �ò���ͬʱ��������� Java ���̣���ע�⡣
echo.
choice /C YN /N /M "�Ƿ�ǿ�ƽ�����������(��Y����N)��"
if %errorlevel%==2 goto home
taskkill /f /im java.exe
echo.
echo  ��ǿ�ƽ������������̣����ܻᵼ�����ݶ�ʧ��
echo.
echo  ^> ���������������ҳ��
echo.
pause>nul
goto home

@REM ���ݵ�ͼ����

:backupmap
cd %WORKDIR%
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ���ݷ�������ͼ
echo.
echo  ��������Ҫ���ݵ��������֣���֧������������
echo.
echo  ���� /back ������һҳ��
echo.
set /p backupworld=[INPUT] ��������������
if "%backupworld%"=="/back" goto home
echo.
echo  ���ڱ������硱%backupworld%��......
echo.
cd Minecraft/
"../tools/7z" a %backupworld%_%date:~8,2%_%time:~0,2%.zip .\%backupworld%\*
cd ../
echo  ���ݳɹ����Ѵ��浽 %backupworld%_%date:~8,2%_%time:~0,2%.zip
echo.
echo  ^> ���������������ҳ��
echo.
pause>nul
goto home

@REM Զ������������

:remotestart
cd Config/
if not exist "Remote_Port.ini" goto remotesetting
if not exist "Remote_Pass.ini" goto remotesetting
for /f %%k in (Remote_Port.ini) do set remotesetport=%%k
for /f %%j in (Remote_Pass.ini) do set remotesetpass=%%j
cd ../
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  Զ������������ģʽ��
echo.
echo  �������������......
echo.
pause>nul
goto remoteenable

@REM ����Զ��ģʽ

:remoteenable
cd tools/
start "Prismaillya Զ�̷�����������" "%JAVADIR%" -jar RemoteStart.jar %remotesetport% %remotesetpass%
for /f "delims=" %%u in ('md5 -d%remotesetpass%') do set remotepassmd5=%%u
goto remotestatus

@REM Զ�̼��

:remotestatus
cd %WORKDIR%tools
if exist "startserver.ce" goto remotestartserver
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  Զ������ģʽ�����У�����ǰ����ͨ������̨������������
echo.
echo  ��ֻ���Է��� http://localhost:%remotesetport%/start/%remotepassmd5% ������������
echo.
ping 127.0.0.1>>nul
tasklist /FI "WINDOWTITLE eq Prismaillya Զ�̷�����������"|find "java.exe"
if %errorlevel%==0 goto remotestatus
goto home

@REM Զ�̷���������

:remotesetting
cd ../
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  Զ���������������ã�������ͨ���˹���Զ���������ķ�������
echo.
echo  ����������Զ������ģʽʱ�����������ֶ����Ʒ�������
echo.
echo  ���ڿ�ʼ����Զ�̷�������
echo.
echo  ΪԶ�̷�����ָ��һ���˿ڣ�1~65535 ֮��
echo.
set /p remoteport=[INPUT] ������Զ�̶˿ڣ�
echo.
echo  ΪԶ�̷�����ָ��һ�����룬��֧��Ӣ�ĺ�����
echo.
set /p remotepass=[INPUT] ������Զ�����룺
echo.
if "%remoteport%"=="" echo   ����Ҫ���ö˿ڣ�&ping 127.0.0.1 -n 2 >nul&goto remotesetting
if "%remotepass%"=="" echo   ����Ҫ�������룡&ping 127.0.0.1 -n 2 >nul&goto remotesetting
echo %remoteport%>./Config/Remote_Port.ini
echo %remotepass%>./Config/Remote_Pass.ini
echo  ������ɣ����������������һҳ��
echo.
pause>nul
goto remotestart

@REM ��շ����Ŀ¼

:cleardir
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo   ��һ��Ҫ�������ò�����ɾ�����е��ļ���
echo.
echo   �����ȷʵҪ����ļ��У������� confirm
echo.
echo   �������������򷵻���һҳ��
echo.
set /p isclear=[INPUT] ȷ��ɾ�������ļ���
if "%isclear%"=="confirm" del /q /s "Minecraft"&rmdir /s /q "Minecraft"&mkdir Minecraft
goto home

@REM ��������������

:startserver
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
cd Minecraft/
if not exist "%JarName%" goto jarnotfound
echo @echo off>launcher.cmd
echo echo serverrunning^>status.pri>>launcher.cmd
echo "%JAVADIR%" -Xmx%MaxRam%M -jar %JarName%>>launcher.cmd
echo del "status.pri">>launcher.cmd
echo echo.>>launcher.cmd
echo echo   �������ѹرգ�����������˳�����̨��>>launcher.cmd
::echo pause^>nul>>launcher.cmd
echo exit>>launcher.cmd
start "Prismaillya Server Manager Ver.%localversion% �� ����������̨" launcher.cmd
if %errorlevel%==1 echo  [ERROR] ��⵽����������ʱ�����˴���
ping 127.0.0.1 -n 2 >>nul
cd ../
goto status

@REM Զ�̷�������������

:remotestartserver
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
set JAVADIR=%WORKDIR%Java\bin\Java.exe
cd %WORKDIR%Minecraft
if not exist "%JarName%" goto remotejarnotfound
echo @echo off>launcher.cmd
echo echo serverrunning^>status.pri>>launcher.cmd
echo "%JAVADIR%" -Xmx%MaxRam%M -jar %JarName%>>launcher.cmd
echo del "status.pri">>launcher.cmd
echo echo.>>launcher.cmd
echo echo   �������ѹرգ�����������˳�����̨��>>launcher.cmd
echo cd ../tools/>>launcher.cmd
echo del "startserver.ce">>launcher.cmd
echo cd ../Minecraft/>>launcher.cmd
::echo pause^>nul>>launcher.cmd
echo exit>>launcher.cmd
start "Prismaillya Server Manager Ver.%localversion% �� ����������̨" launcher.cmd
if %errorlevel%==1 echo  [ERROR] ��⵽����������ʱ�����˴���
ping 127.0.0.1 -n 2 >>nul
cd ../
goto remotestartstatus

@REM ����˺���δ�ҵ�

:jarnotfound
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �޷��ҵ�����˺��ģ������Ƿ���ɾ�˷���˺��ģ�
echo.
echo  �ֶ��޸ĺ������ֵķ�����
echo    �� Config/Version.ini �������µĺ������֣�Ȼ�󱣴档
echo.
echo  ��Ҳ����ͨ�����÷����������������غ��ġ�
echo.
echo  ^> ���������������ҳ
echo.
pause>nul
goto home

@REM ����˺���δ�ҵ�

:remotejarnotfound
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �޷��ҵ�����˺��ģ������Ƿ���ɾ�˷���˺��ģ�
echo.
echo  �ֶ��޸ĺ������ֵķ�����
echo    �� Config/Version.ini �������µĺ������֣�Ȼ�󱣴档
echo.
echo  ��Ҳ����ͨ�����÷����������������غ��ġ�
echo.
echo  ^> ���������������ҳ
echo.
pause>nul
goto remotestartserver

@REM ״̬��ز���

:status
cd tools/
for /f "delims=" %%i in ('%WORKDIR%tools\get_memory.exe') do set ramused=%%i
cd ../
title Prismaillya Server Manager Ver.%localversion% �� ������������ �����ڴ棺%ramused%%%
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �������ѿ������������ƣ�%JarName%������ڴ棺%MaxRam%
echo.
echo  ��������Դ��أ�
echo.
echo   �����ڴ棺%ramused% %%
echo.
ping 127.0.0.1>nul
tasklist /FI "WINDOWTITLE eq Prismaillya Server Manager Ver.%localversion% �� ����������̨ - launcher.cmd"|find "cmd.exe"
if %errorlevel%==0 goto status
if %errorlevel%==1 goto serverstop
if exist "Minecraft/status.pri" goto status

@REM Զ��״̬��ز���

:remotestartstatus
cd %WORKDIR%tools
for /f "delims=" %%i in ('%WORKDIR%tools\get_memory.exe') do set ramused=%%i
cd ../
title Prismaillya Server Manager Ver.%localversion% �� ������������ �����ڴ棺%ramused%%%
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �������ѿ������������ƣ�%JarName%������ڴ棺%MaxRam%
echo.
echo  ��������Դ��أ�
echo.
echo   �����ڴ棺%ramused% %%
echo.
ping 127.0.0.1>nul
tasklist /FI "WINDOWTITLE eq Prismaillya Server Manager Ver.%localversion% �� ����������̨ - launcher.cmd"|find "cmd.exe"
if %errorlevel%==0 goto remotestartstatus
if %errorlevel%==1 goto remoteserverstop
if exist "Minecraft/status.pri" goto remotestartstatus

@REM �������Ѿ�ֹͣ

:serverstop
cd Minecraft/
del "launcher.cmd"
if exist "status.pri" del "status.pri"
cd ../
title Prismaillya Server Manager Ver.%localversion% �� �������ѹر�
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ��⵽�������ѹرա�
echo.
echo  �������Զ�����������%autorestart%��
echo.
ping 127.0.0.1>nul
if exist "Config/Restart.ce" echo  ��������������...&goto startserver
goto home

@REM Զ�̷������Ѿ�ֹͣ

:remoteserverstop
cd %WORKDIR%Minecraft
del "launcher.cmd"
if exist "status.pri" del "status.pri"
cd ../
title Prismaillya Server Manager Ver.%localversion% �� �������ѹر�
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ��⵽�������ѹرա�
echo.
echo  �������Զ�����������%autorestart%��
echo.
ping 127.0.0.1>nul
if exist "Config/Restart.ce" echo  ��������������...&goto startserver
goto remotestatus

@REM �����߷��ͷ�������

:report
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ����ʹ��������ʲô���⣬��������ʲô�õĽ��飬����ͨ�����ﷴ�����ң�
echo.
echo  ���� back �Ϳ��Է�����һҳ�����������������ύ�����ߡ�
echo.
echo  �������Ҫ���У�������[n]�����ߵ�����ҲҪ���롣
echo.
echo  �������������и���������ϵ��ʽ������������ϵ��~
echo.
set /p reporttext=[INPUT] �������������ķ�����
if %reporttext%==back goto home
cd tools/
start /MIN cmd /c curl -d "ip=%localip%&report=[%localversion%]%reporttext%" -A "Prismaillya" https://www.prismaillya.com/Prismaillya/ServerManager/report/>>nul
echo.
echo  �����ύ�ɹ���
echo.
echo  ����������ͻ��Զ��˳�......
echo  ����Ҳ��֪��ʲôԭ�� ( ����
echo  �����ǳ���������� 233333
echo  ���ֶ���������......
echo.
pause>nul
exit

@REM ħ������Դ�㳡����

:magicgirlshop
title Prismaillya Server Manager Ver.%localversion% �� ħ����Դ�㳡
cls
echo.
echo  ���� Prismaillya ��������Դ�㳡 ��������������������
echo.
cd %WORKDIR%tools
set day=%date:~8,2%
set time=%time:~0,2%
if /i %time% lss 10 set time=0%time:~1,1%
set hash=%day%%time%
md5 -d%hash%>tempmd5.txt
::for /f "delims=" %%i in ('md5 -d%hash%') do set sign=%%i
for /f %%s in (tempmd5.txt) do set sign=%%s
del "tempmd5.txt"
echo   Prismaillya^> Login For token: %sign%
echo.
curl -d "action=home&sign=%sign%" https://www.prismaillya.com/Prismaillya/ServerManager/Resource/
echo.
echo  ���� back ���Է�����ҳ��
echo.
set /p select=[INPUT] �������ѡ��
if "%select%"=="back" goto home
goto magicgirlshoptype

@REM ħ������Դ�㳡ѡ������

:magicgirlshoptype
title Prismaillya Server Manager Ver.%localversion% �� ѡ��������Ŀ
cls
curl -d "action=select&row=type&type=%select%&sign=%sign%" https://www.prismaillya.com/Prismaillya/ServerManager/Resource/
echo.
set /p selectid=[INPUT] �������ѡ��
if "%selectid%"=="back" goto magicgirlshop
title Prismaillya Server Manager Ver.%localversion% �� ��ʼ�����ļ�
cls
echo.
echo   ���� Prismaillya ��������Դ�㳡 ��������������������
echo.
echo   ^> ������ʼ���ء�
echo.
cd %WORKDIR%\Minecraft
if not exist "plugins" mkdir plugins & echo   ^> plugins Ŀ¼�����ڣ����ڴ���...
cd ../tools/
curl https://www.prismaillya.com/Prismaillya/ServerManager/Resource/?c=getname^&id=%selectid% >tempname.txt
for /f %%n in (tempname.txt) do set downname=%%n
del "tempname.txt"
wget "http://www.prismaillya.com/Prismaillya/ServerManager/Resource/?c=download&id=%selectid%" -O "../Minecraft/plugins/%downname%"
echo.
if %errorlevel%==1 echo   ^> ����ʧ�ܣ�δ֪����
if %errorlevel%==0 echo   ^> ������ɣ��Ѵ��浽������ Minecraft/plugins Ŀ¼��
echo.
echo   ^> ���������������һҳ��
pause>nul
goto magicgirlshoptype

@REM ����ģʽ����

:install
title Prismaillya Server Manager Ver.%localversion% �� ����������
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��ӭʹ�� Prismaillya ��������Ŀǰ��������ģʽ��
echo.
echo   �����������ʼ���÷�������
pause>nul
echo.
echo   ����������Ҫ���ķ���������
echo.
echo   1.PaperSpigot        (�Ƽ�)(�ɿ�������������֧�ֲ��)
echo.
echo   2.Cauldron           (�ɿ�Mod��������֧�� forge �Ͳ����ԭ MCPC)
echo.
echo   3.Minecraft Server   (�ٷ�����������֧��Mod�Ͳ��)
echo.
echo   4.CraftBukkit        (�ɿ�������������֧�ֲ��)
echo.
echo   5.Spigot             (�ɿ�������������֧�ֲ��)
echo.
echo   6.��Ҫʹ���Լ��ĺ����ļ�
echo.
set /p installtype=[INPUT] ����������Ҫ��װ������(����1/2/3/4/5/6)��
if %installtype%==1 goto installpaperspigot
if %installtype%==2 goto installcauldron
if %installtype%==3 goto installminecraftserver
if %installtype%==4 goto installcraftbukkit
if %installtype%==5 goto installspigot
if %installtype%==6 goto installcustom
goto install

@REM ��װPaperSpigot����

:installpaperspigot
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��������Ҫ��װ�� PaperSpigot �汾����ѡ�İ汾�У�
echo.
echo   1 ) 1.7.10
echo   2 ) 1.8
echo   3 ) 1.8.8
echo   4 ) 1.11.2
echo   5 ) 1.12
echo.
set /p installversion=[INPUT] ����������Ҫ��װ�İ汾(����1/2/3/4/5)��
if %installversion%==1 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.7.10-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==2 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.8-R0.1-SNAPSHOT-b235.jar&goto downloadFile
if %installversion%==3 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.11.2-b1040.jar&goto downloadFile
if %installversion%==5 set downloadtype=PaperSpigot&set downloadname=PaperSpigot-1.12-latest.jar&goto downloadFile
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��ѡ��İ汾����ȷ��
echo.
pause>nul
goto installpaperspigot

@REM ��װCauldron����

:installcauldron
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��������Ҫ��װ�� Cauldron �汾����ѡ�İ汾�У�
echo.
echo   1 ) 1.7.2
echo   2 ) 1.7.10
echo.
set /p installversion=[INPUT] ����������Ҫ��װ�İ汾(����1/2)��
if %installversion%==1 set downloadtype=Cauldron&set downloadname=cauldron-1.7.2-1.1147.04.98-server.zip&goto downloadFile
if %installversion%==2 set downloadtype=KCauldron&set downloadname=KCauldron-1.7.10-1614.201-bundle.zip&goto downloadFile
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��ѡ��İ汾����ȷ��
echo.
pause>nul
goto installcauldron

@REM ��װMinecraft_Server����

:installminecraftserver
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��������Ҫ��װ�� Minecraft Server �汾����ѡ�İ汾�У�
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
set /p installversion=[INPUT] ����������Ҫ��װ�İ汾(����1/2/3/4/5/6/7/8/9/10)��
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
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��ѡ��İ汾����ȷ��
echo.
pause>nul
goto installminecraftserver

@REM ��װCraftBukkit����

:installcraftbukkit
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��������Ҫ��װ�� CraftBukkit �汾����ѡ�İ汾�У�
echo.
echo   1 ) 1.7.2
echo   2 ) 1.7.10
echo   3 ) 1.8
echo   4 ) 1.8.8
echo   5 ) 1.9.4
echo   6 ) 1.10.2
echo   7 ) 1.11.2
echo.
set /p installversion=[INPUT] ����������Ҫ��װ�İ汾(����1/2/3/4/5/6/7)��
if %installversion%==1 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.7.2-R0.4-20140216.012104-3.jar&goto downloadFile
if %installversion%==2 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.7.10-R0.1-20140808.005431-8.jar&goto downloadFile
if %installversion%==3 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==5 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.9.4-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==6 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.10.2-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==7 set downloadtype=CraftBukkit&set downloadname=craftbukkit-1.11.2-R0.1-SNAPSHOT.jar&goto downloadFile
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��ѡ��İ汾����ȷ��
echo.
pause>nul
goto installcraftbukkit

@REM ��װSpigot����

:installspigot
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ��������Ҫ��װ�� Spigot �汾����ѡ�İ汾�У�
echo.
echo   1 ) 1.7.10
echo   2 ) 1.8
echo   3 ) 1.8.8
echo   4 ) 1.11.2
echo.
set /p installversion=[INPUT] ����������Ҫ��װ�İ汾(����1/2/3/4)��
if %installversion%==1 set downloadtype=Spigot&set downloadname=spigot-1.7.10-SNAPSHOT-b1643.jar&goto downloadFile
if %installversion%==2 set downloadtype=Spigot&set downloadname=spigot-1.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==3 set downloadtype=Spigot&set downloadname=spigot-1.8.8-R0.1-SNAPSHOT-latest.jar&goto downloadFile
if %installversion%==4 set downloadtype=Spigot&set downloadname=spigot-1.11.2-R0.1-SNAPSHOT.jar&goto downloadFile
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��ѡ��İ汾����ȷ��
echo.
pause>nul
goto installspigot

@REM �Զ��� JAR ���Ĳ���

:installcustom
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ���Ƚ�����Ҫ�Զ���� Jar ���뱾�������� Minecraft �ļ����С�
echo.
echo   Ȼ����������Զ��� Jar �������֣���Ҫ�����β�ġ�.jar��
echo.
set /p customjarname=[INPUT] ����JAR���֣�
if exist "Minecraft/%customjarname%.jar" set downloadtype=Custom&goto settingserver
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   [����]��������Զ��� Jar ���Ĳ����ڣ���ȷ�ϸ��ļ��ڱ��������� Minecraft �ļ����
echo.
pause>nul
goto installcustom

@REM �ļ����ز���

:downloadFile
title Prismaillya Server Manager Ver.%localversion% �� ���غ���
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo   ׼����ʼ����......
echo.
echo     [�ļ���Ϣ]
echo.
echo     ��ѡ������������ǣ�%downloadtype%
echo.
echo     �������ص��ļ����ǣ�%downloadname%
echo.
echo   �����������ʼ����ѡ�а汾������ Ctrl + C �˳����ء�
pause>nul
echo.
echo   ���ڿ�ʼ���أ�http://cdn.tcotp.cn/download/server/%downloadtype%/%downloadname%
echo.
echo   ���ش�Լ��Ҫ 10 ���ʱ�䣬�����ĵȴ���
echo.
echo   ����ʹ�ø��Ѱ����� OSS Ϊ����������������飡
echo.

@REM ����Ѿ����ڸð汾����ɾ��

if exist "Minecraft/%downloadname%" del "Minecraft/%downloadname%"
set DType=%downloadtype%

@REM ����� KCauldron �汾����ΪAPI����ԭ��KCauldron ���������� Cauldron ��

if %downloadtype%==KCauldron set DType=Cauldron
cd tools/

@REM ��ʼ���غ���

wget.exe -P ../Minecraft/ http://cdn.tcotp.cn/download/server/%DType%/%downloadname% >nul
title Prismaillya Server Manager Ver.%localversion% �� �����������
cd ../
echo.
echo   %downloadname% ������ɣ������ص� Minecraft Ŀ¼��

@REM ����� KCauldron �� Cauldron

if %downloadtype%==Cauldron echo   �����ص��ǰ�װ���汾����Ҫ��ѹ�������������ʼ��ѹ��&pause>nul&goto unzip
if %downloadtype%==KCauldron echo   �����ص��ǰ�װ���汾����Ҫ��ѹ�������������ʼ��ѹ��&pause>nul&goto unzip
goto settingserver

@REM ��ѹ�ļ�

:unzip
title Prismaillya Server Manager Ver.%localversion% �� ��ѹ�����ļ�
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ���ڽ�ѹ %downloadname%......
cd Minecraft/
start ../tools/7z.exe x %downloadname%>nul
echo.
echo  %downloadname% ��ѹ��ɣ�
echo.
echo  �����������ʼ���÷�������
cd ../

@REM ���������ò���

:settingserver
title Prismaillya Server Manager Ver.%localversion% �� ���÷�������Ϣ
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  �ܺã������档
echo.
echo  ����˺����Ѿ���������ˣ����ڿ�ʼ���÷��������ܡ�
echo.
echo  �밴���������ʼ���á�
pause>nul
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ����ķ�������һ�����ְɣ��������ġ�Ӣ�ġ������Լ��»��ߡ�
echo.
set /p servername=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ����Ҫ����������������ڴ棿��λ MB��Ĭ��1024
::echo  ע�⣺�˰汾Ϊ 32 λ�汾������ڴ��벻Ҫ���ó��� 1024�������޷�������
echo.
set /p maxram=[INPUT] ���������֣�
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ����Ҫ�÷������������ĸ��˿ڣ�Ĭ�ϣ�25565
echo.
set /p serverport=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ���������ٸ����ͬʱ���ߣ����������֡�
echo.
set /p maxplayers=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  �Ƿ��������PVP(���๥��)����true/��false
echo.
set /p pvp=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  �Ƿ�������ҽ����������true/��false
echo.
set /p allownether=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  �Ƿ�����������֤�����ڰ������ڵ�����޷��������������true/��false
echo.
set /p whitelist=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  �Ƿ��������½ģʽ����true/��false
echo.
set /p onlinemode=[INPUT] �����룺
cls
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ����������������������֣���֧�����ġ�
echo.
set /p levelname=[INPUT] �����룺
cls

@REM ��ʼд�������ļ�

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

@REM ����� Cauldron �� KCauldron

if "%downloadtype%"=="Cauldron" echo cauldron-1.7.2-1.1147.04.98-server.jar>./Config/Version.ini
if "%downloadtype%"=="KCauldron" echo KCauldron.jar>./Config/Version.ini
if "%downloadtype%"=="Custom" echo %customjarname%.jar>./Config/Version.ini

@REM �������

title Prismaillya Server Manager Ver.%localversion% �� �������
echo.
echo  ���� Prismaillya ����������ģʽ ��������������������
echo.
echo  ��ϲ���������Ѿ���������ˣ�
echo.
echo  �������Ѿ����Կ������ķ������ˣ�
echo.
echo  �����������ת�������棡
echo.
pause>nul
goto home

@REM δ�ҵ� Java

:javanotfound
title Prismaillya Server Manager Ver.%localversion% �� Java δ�ҵ�
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �޷��ҵ� Java��������û�������Ľ�ѹ���߸��Ʊ���������
echo.
echo  �������Ҫʹ���Լ��� Java���뽫 jre1.x.x_xxx �ļ��и��Ƶ� %WORKDIR% Ŀ¼�¡�
echo.
echo  ���� jre1.x.x_xxx �ļ���������Ϊ Java
echo.
choice /C DRE /N /M "  ��������Java���������� Java Ŀ¼�����˳���(����D�������أ�R����������E�˳�)"
if %errorlevel%==1 goto javadownload
if %errorlevel%==2 goto home
exit

@REM δ�ҵ����

:toolsnotfound
title Prismaillya Server Manager Ver.%localversion% �� ���δ�ҵ�
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  �޷��ҵ���������������û�������Ľ�ѹ���߸��Ʊ���������
echo.
echo  �볢�����½�ѹ��������������ֱ�����������
echo.
choice /C DRE /N /M "  ������������������������Ŀ¼�����˳���(����D�������أ�R����������E�˳�)"
if %errorlevel%==1 goto toolsdownload
if %errorlevel%==2 goto home
exit

@REM Java ���ز���

:javadownload
title Prismaillya Server Manager Ver.%localversion% �� Java ����
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
set javatype=i386
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set javatype=amd64
if not exist "Java-%javatype%.zip" curl http://cdn.tcotp.cn/Prismaillya/Files/Java/Java-%javatype%.zip -o Java-%javatype%.zip
7z x Java-%javatype%.zip
del "Java-%javatype%.zip"
echo.
echo  ^> Java ������ɣ�������������ء�
pause>nul
goto home

@REM ������ز���

:toolsdownload
title Prismaillya Server Manager Ver.%localversion% �� �������
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
set toolstype=i386
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set toolstype=amd64
if not exist "tools-%toolstype%.zip" curl http://cdn.tcotp.cn/Prismaillya/Files/Tools/tools-%toolstype%.zip -o tools-%toolstype%.zip
7z x tools-%toolstype%.zip
del "tools-%toolstype%.zip"
echo.
echo  ^> ���������ɣ�������������ء�
pause>nul
goto home

@REM ����ϵͳ����

:update
title Prismaillya Server Manager Ver.%localversion% �� ϵͳ����
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo   Prismaillya ����ϵͳ���°汾�����ˣ�
echo.
echo   ��ǰ�汾��%localversion%
echo.
echo   ���°汾��%newversion%
echo.
echo   �������ݣ�
echo.
curl -s https://prisma-illya.github.io/ServerManager/news.txt
echo.
echo.
choice /C YN /N /M "  �Ƿ����ϵͳ��(Yȷ����Nȡ��)"
if %errorlevel%==1 goto downloadnewversion
goto home

@REM �����°汾����

:downloadnewversion
title Prismaillya Server Manager Ver.%localversion% �� ϵͳ����
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo   ���������°汾��PrismaillyaServerManager.%newversion%.exe
echo.
curl https://prisma-illya.github.io/ServerManager/PrismaillyaServerManager.%newversion%.exe -o PrismaillyaServerManager.%newversion%.exe
echo.
echo   ������ɣ�����������˳�����������°汾���ɣ�
echo.
echo   �°汾�ļ�����PrismaillyaServerManager.%newversion%.exe
echo.
pause>nul
exit

@REM δ֪�汾����

:unknownversion
cd %WORKDIR%
title Prismaillya Server Manager Ver.%localversion% �� δ֪�汾
cls
echo.
echo  ���� Prismaillya ����������ϵͳ ��������������������
echo.
echo  ����ǰ�汾��֧�ֿ��������򲻼��ݣ���Ҫ��������֧�ֿ⡣
echo.
echo  �����������ʼ�����°汾��֧�ֿ⡣
echo.
pause>nul
del /q "tools"
rmdir /q /s "tools"
set toolstype=i386
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set toolstype=amd64
if not exist "tools-%toolstype%.zip" curl http://cdn.tcotp.cn/Prismaillya/Files/Tools/tools-%toolstype%.zip -o tools-%toolstype%.zip
7z x tools-%toolstype%.zip
del "tools-%toolstype%.zip"
echo.
echo  ֧�ֿ��ļ�������ϣ�
echo.
echo  ^> ���������������ҳ��
echo.
pause>nul
goto home