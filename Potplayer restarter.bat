@echo off
:top
echo Terminating Potplayer processes...

taskkill /F /IM PotPlayerMini64.exe /T

echo.
echo Processes terminated.
echo Restarting Potplayer...
start "" "C:\Program Files\DAUM\PotPlayer\PotPlayerMini64.exe"

echo.
set /p choice=Do you want to terminate and restart Potplayer again? (Y/N): 

if /I "%choice%"=="Y" goto top
echo Exiting...
pause
exit
