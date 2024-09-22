@echo off

:: Check if the script is running with administrative privileges
:: If not, it will re-run itself with administrative privileges

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: Check internet connection
echo Checking internet connection...
curl -s --head http://www.google.com | find "200 OK" >nul

if errorlevel 1 (
    echo No internet connection...
    echo Opening Adjust date/time settings for manual adjustment...
    start ms-settings:dateandtime
    timeout /t 5 >nul
) else (
    :: Force time synchronization
    :: Time synchronization can resolve issues with website certificate errors due to incorrect system time.
    w32tm /resync
)

echo Running System File Checker...
sfc /scannow

echo.
echo Running DISM to restore health...
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo Checking drive status...
wmic diskdrive get status

echo.
echo Checking drive predictive failure...
wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus

echo.
echo Running DirectX Diagnostic Tool, please select Display tab manually and look at the message under Notes to see GPU condition...
dxdiag

echo.
echo Scheduling Check Disk to run on the next restart...
echo Note: chkdsk will only check drive C, the boot drive containing the operating system.
chkdsk C: /f /r /x

echo.
echo Scheduling Windows Memory Diagnostics Tool to run on the next restart...
mdsched

pause
