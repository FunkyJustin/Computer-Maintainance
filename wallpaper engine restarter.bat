@echo off
:top
echo Terminating Wallpaper Engine processes...

taskkill /F /IM wallpaper32.exe /T

echo.
echo Processes terminated.
echo Restarting Wallpaper Engine...
start "" "E:\SteamLibrary\steamapps\common\wallpaper_engine\wallpaper32.exe"

echo.
set /p choice=Do you want to terminate and restart Wallpaper Engine again? (Y/N): 

if /I "%choice%"=="Y" goto top
echo Exiting...
pause
exit
