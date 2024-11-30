@echo off

:: Check if the script is running with administrative privileges
:: If not, it will re-run itself with administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit
)

:: Log file setup
set logFile=diagnostic_log_%date:~-4,4%-%date:~4,2%-%date:~7,2%.txt
echo Diagnostic Log - %date% %time% > "%logFile%"
echo ----------------------------------------- >> "%logFile%"

:: Check internet connection
echo Checking internet connection... >> "%logFile%"
curl -s --head http://www.google.com | find "200 OK" >nul
if errorlevel 1 (
    echo No internet connection... >> "%logFile%"
    echo Opening Adjust date/time settings for manual adjustment...
    control timedate.cpl
    start ms-settings:dateandtime
    timeout /t 5 >nul
) else (
    :: Force time synchronization
    echo Internet connection detected. Synchronizing time... >> "%logFile%"
    w32tm /resync >> "%logFile%" 2>&1
)

:: System File Checker
echo Running System File Checker... >> "%logFile%"
sfc /scannow >> "%logFile%" 2>&1

echo.
echo Running DISM to restore health...
DISM /Online /Cleanup-Image /RestoreHealth >> "%logFile%" 2>&1

:: Added Component Cleanup
echo Running DISM Component Cleanup...
DISM.exe /online /cleanup-image /startcomponentcleanup >> "%logFile%" 2>&1

:: Disk Health Check
echo Checking drive status... >> "%logFile%"
wmic diskdrive get status >> "%logFile%" 2>&1

echo.
echo Checking drive predictive failure... >> "%logFile%"
wmic /namespace:\\root\wmi path MSStorageDriver_FailurePredictStatus >> "%logFile%" 2>&1

:: DirectX Diagnostics
echo Running DirectX Diagnostic Tool... Please check the Display tab manually for GPU condition. >> "%logFile%"
dxdiag

:: Check Disk
echo Scheduling Check Disk... >> "%logFile%"
echo Defaulting to boot drive (C:). >> "%logFile%"
set bootDrive=C
chkdsk %bootDrive% /f /r /x >> "%logFile%" 2>&1

:: Memory Diagnostics
echo Scheduling Windows Memory Diagnostics Tool to run on the next restart... >> "%logFile%"
mdsched >> "%logFile%" 2>&1

:: User Prompt to Specify Drives
echo.
echo If you would like to specify additional drives for Check Disk, enter them separated by spaces (e.g., D E F) or press Enter to skip.
set /p drives=Enter additional drives (leave blank for none): 

if not "%drives%"=="" (
    for %%D in (%drives%) do (
        echo Scheduling Check Disk for drive %%D... >> "%logFile%"
        chkdsk %%D: /f /r /x >> "%logFile%" 2>&1
    )
)

:: Pause for review
echo.
echo Diagnostics completed. Logs have been saved to "%logFile%".
pause
