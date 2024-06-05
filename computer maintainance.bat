@echo off

:: Check if the script is running with administrative privileges
:: If not, it will re-run itself with administrative privileges

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
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
echo Scheduling Check Disk to run on the next restart...
echo Note: chkdsk will only check drive C, the boot drive containing the operating system.
chkdsk C: /f /r /x

echo.
echo Scheduling Windows Memory Diagnostics Tool to run on the next restart...
mdsched

pause
