@echo off

:: modify nginx.exe directory in nginx-service.xml
:modify_xml
set nginx_path=%cd%
echo ^<service^> >nginx-service.xml
echo  ^<id^>nginx^</id^> >>nginx-service.xml
echo  ^<name^>Nginx Service^</name^> >>nginx-service.xml
echo  ^<description^>High Performance Nginx Service^</description^> >>nginx-service.xml
echo  ^<logpath^>%nginx_path%\logs^</logpath^> >>nginx-service.xml
echo  ^<log mode="roll-by-size"^> >>nginx-service.xml
echo    ^<sizeThreshold^>10240^</sizeThreshold^> >>nginx-service.xml
echo    ^<keepFiles^>8^</keepFiles^> >>nginx-service.xml
echo  ^</log^> >>nginx-service.xml
echo  ^<executable^>%nginx_path%\nginx.exe^</executable^> >>nginx-service.xml
echo  ^<startarguments^>-p %nginx_path%\^</startarguments^> >>nginx-service.xml
echo  ^<stopexecutable^>%nginx_path%\nginx.exe^</stopexecutable^> >>nginx-service.xml
echo  ^<stoparguments^>-p %nginx_path%\nginx -s stop^</stoparguments^> >>nginx-service.xml
echo ^</service^> >>nginx-service.xml

:: Start the installation selection interface
:start
CLS
echo *=========================================================================*
echo *         Note: The bat file must be at the same level as nginx.exe       *
echo *         1.Install and start nginx                                       *
echo *         2.Install the nginx-service as service                          *
echo *         3.Uninstall the nginx-service service                           *
echo *         4.Start nginx                                                   *
echo *         5.Stop nginx                                                    *
echo *         6.Quit                                                          *
echo *=========================================================================*
Set /P option=¡¡Please select the operation to be performed (1/2/3/4/5/6) £¬then press Enter£º
if /I "%option%"=="1" goto setup_start
if /I "%option%"=="2" goto install_service
if /I "%option%"=="3" goto uninstall_service
if /I "%option%"=="4" goto start_nginx
if /I "%option%"=="5" goto stop_nginx
if /I "%option%"=="6" goto Exit
goto start

:: Install and start nginx
:setup_start
nginx-service.exe install 
net start nginx
pause
goto start

:: Install the nginx-service as service
:install_service
nginx-service.exe install 
pause
goto start

:: Uninstall the nginx-service service
:uninstall_service
net stop nginx
tasklist | find /i "nginx.exe" | taskkill /F /IM nginx.exe
sc delete nginx
pause
goto start

:: Start nginx
:start_nginx
net start nginx
pause
goto start

:: Stop nginx 
:stop_nginx
net stop nginx
rem nginx.exe -s stop
tasklist | find /i "nginx.exe" | taskkill /F /IM nginx.exe
pause
goto start
