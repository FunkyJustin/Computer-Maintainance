@echo off
:top
echo Terminating Firefox processes...

taskkill /F /IM firefox.exe /T

echo.
echo Processes terminated.
echo Restarting Firefox...
start "" "C:\Program Files\Mozilla Firefox\firefox.exe"

echo.
set /p choice=Do you want to terminate and restart Firefox again? (Y/N): 

if /I "%choice%"=="Y" goto top
echo Exiting...
pause
exit
