@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -command "Start-Process '%~f0' -Verb runAs"
    exit /B
)

:: Set the backup folder path
set "backupFolder=C:\Users\%USERNAME%\Desktop\Drivers Backup"

:: Check if the folder exists, if not, create it
if not exist "%backupFolder%" (
    mkdir "%backupFolder%"
)

:: Run the DISM command to export drivers
dism /online /export-driver /destination:"%backupFolder%"

echo Drivers have been backed up to %backupFolder%
pause


::source of the command is https://youtu.be/nufUHWGS9DE
::watch the youtube video to see how it is used