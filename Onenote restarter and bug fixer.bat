@echo off
:top
echo Terminating OneNote processes...

taskkill /F /IM ONENOTE.EXE /T
taskkill /F /IM ONENOTEM.EXE /T

echo.
echo Processes terminated.
echo Restarting OneNote...
start "" "C:\Program Files (x86)\Microsoft Office\root\Office16\ONENOTE.EXE"

echo.
set /p choice=Do you want to terminate and restart OneNote again? (Y/N): 

if /I "%choice%"=="Y" goto top
echo Exiting...
pause
exit
