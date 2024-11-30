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

:: DirectX Diagnostics
echo Running DirectX Diagnostic Tool... Please check the Display tab manually for GPU condition.
dxdiag

:: Check Disk
echo.
echo Scheduling Check Disk...
echo The C drive (boot drive) will always be scanned.
echo If you want to scan additional drives (e.g., D E F), enter them below.
echo Do not include C in your input. Press Enter to skip or wait 30 seconds.
echo.
timeout /t 30 /nobreak >nul
set additionalDrives=

set /p additionalDrives=Enter additional drives (e.g., D E F): 

if defined additionalDrives (
    for %%D in (%additionalDrives%) do (
        if /i not "%%D"=="C" (
            echo Scheduling Check Disk for drive %%D...
            chkdsk %%D: /f /r /x
        ) else (
            echo Skipping duplicate C drive input; it will already be scanned.
        )
    )
)

:: Always scan the C drive
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
