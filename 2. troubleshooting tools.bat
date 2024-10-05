@echo off
:: Check for Administrator Privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit
)

title Windows Troubleshooting Tools
:menu
cls
echo ======================================
echo       WINDOWS TROUBLESHOOTING MENU
echo ======================================
echo 1. Computer Management
echo 2. System Configuration (msconfig)
echo 3. System Properties
echo 4. Disk Management
echo 5. Set Date and Time
echo 6. Synchronize Time
echo 7. Open My Computer (This PC)
echo 8. Exit
echo ======================================
set /p choice="Enter your choice (1-8): "

if %choice%==1 goto compmgmt
if %choice%==2 goto msconfig
if %choice%==3 goto sysproperties
if %choice%==4 goto diskmgmt
if %choice%==5 goto datetime
if %choice%==6 goto synctime
if %choice%==7 goto mycomputer
if %choice%==8 goto exit

echo Invalid choice, please try again.
pause
goto menu

:compmgmt
start compmgmt.msc
goto menu

:msconfig
start msconfig
goto menu

:sysproperties
start sysdm.cpl
goto menu

:diskmgmt
start diskmgmt.msc
goto menu

:datetime
control timedate.cpl
goto menu

:synctime
echo Checking if Windows Time service is running...
sc query w32time | find "RUNNING"
if %errorlevel%==1 (
    echo Windows Time service is not running. Starting the service...
    net start w32time
)
echo Synchronizing time...
w32tm /resync
echo Time synchronized successfully.
pause
goto menu

:mycomputer
start explorer shell:MyComputerFolder
goto menu

:exit
exit
