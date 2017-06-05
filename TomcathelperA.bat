@echo ***************************************************************************
@echo * regular backup tomcat logs and restart tomcat
@echo * Ver:20170604
@echo * Copyright (c) 2017 
@echo ***************************************************************************

if not exist "%2\logs" goto foldererr

cd %2\logs
set dst=%date:~0,4%%date:~5,2%%date:~8,2%

if exist "%3\logs\%dst%" goto restart
md %3\logs\%dst%

:restart
for /f "tokens=*"  %%t in ('net start ') do (if "%%t"==%1  @echo %%t & goto   restarttomcat )
goto quit
:restarttomcat
@echo net stop %1
net stop %1

move /Y %2\logs\*.log %3\logs\%dst%\
move /Y %2\logs\*.txt %3\logs\%dst%\
net start %1
goto quit

:foldererr
@echo on
@echo %2\logs folder not  exist.
@echo off
goto quit

:quit

