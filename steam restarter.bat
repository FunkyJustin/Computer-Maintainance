@echo off
:top
echo Terminating Steam processes...

taskkill /F /IM steam.exe /T

echo.
echo Processes terminated.
echo Restarting Steam...
start "" "C:\Program Files (x86)\Steam\steam.exe"

echo.
set /p choice=Do you want to terminate and restart Steam again? (Y/N): 

if /I "%choice%"=="Y" goto top
echo Exiting...
pause
exit
