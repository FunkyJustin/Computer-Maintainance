@echo off
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
echo 5. Exit
echo ======================================
set /p choice="Enter your choice (1-5): "

if %choice%==1 goto compmgmt
if %choice%==2 goto msconfig
if %choice%==3 goto sysproperties
if %choice%==4 goto diskmgmt
if %choice%==5 goto exit

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

:exit
exit
