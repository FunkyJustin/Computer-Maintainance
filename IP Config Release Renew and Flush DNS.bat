@echo off

echo Releasing IP Address...
ipconfig /release

echo.
echo Renewing IP Address...
ipconfig /renew

echo.
echo Flushing DNS
ipconfig /flushdns

echo.

pause