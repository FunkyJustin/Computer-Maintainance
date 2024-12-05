@echo off

:: Check if the script is running with administrative privileges
:: If not, it will re-run itself with elevated privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

echo Disabling sleep and hibernation...

:: Disable sleep
powercfg -change standby-timeout-ac 0
powercfg -change standby-timeout-dc 0

:: Disable hibernation
powercfg -hibernate off

echo Sleep and hibernation have been disabled.
pause
