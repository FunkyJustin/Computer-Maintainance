@echo off

:: Check if the script is running with administrative privileges
:: If not, it will re-run itself with elevated privileges
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
    control timedate.cpl
    start ms-settings:dateandtime
    timeout /t 5 >nul
) else (
    :: Force time synchronization
    echo Internet connection detected. Synchronizing time...
    w32tm /resync
)

:: System File Checker
echo Running System File Checker...
sfc /scannow

:: Running DISM to restore health
echo Running DISM to restore health...
DISM /Online /Cleanup-Image /RestoreHealth

:: Running DISM Component Cleanup
echo Running DISM Component Cleanup...
DISM.exe /online /cleanup-image /startcomponentcleanup

:: Disk Health Check
echo Checking drive status...
wmic diskdrive get status

echo Checking drive predictive failure...
wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus

:: DirectX Diagnostics (runs without waiting for user to close the window)
echo Running DirectX Diagnostic Tool... Please check the Display tab manually for GPU condition.
start /wait dxdiag /t dxdiag.txt

:: Check Disk (Always scan C drive)
echo.
echo Scheduling Check Disk for C:...
chkdsk C: /f /r /x

:: Memory Diagnostics
echo.
echo Scheduling Windows Memory Diagnostics Tool to run on the next restart...
mdsched

:: Pause for review if not unattended
echo.
echo Diagnostics completed.
pause
