@echo off

:begin
echo Releasing IP Address...
ipconfig /release

echo.
echo Renewing IP Address...
ipconfig /renew

echo.
echo Flushing DNS
ipconfig /flushdns

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