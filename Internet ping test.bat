@echo off

:begin
echo Pinging Google DNS server
ping 8.8.8.8

echo.

echo Tracing route to Google DNS server
tracert 8.8.8.8

echo.


:ask
set /p choice=Do you want to run the program again? (yes/no) or (y/n):

if /i "%choice%"=="yes" goto begin
if /i "%choice%"=="y" goto begin
if /i "%choice%"=="no" goto end
if /i "%choice%"=="n" goto end

echo Invalid choice. Please type (yes/no) or (y/n).
goto ask

:end
echo Program ended.