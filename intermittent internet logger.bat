@echo off
setlocal

:: Set the directory where the batch file is located
set "scriptDir=%~dp0"

:: Define log file and temp file paths
set "logFile=%scriptDir%internet_connection_log.txt"
set "tempFile=%scriptDir%current_status.txt"

:: Initialize log file
echo Internet Connection Log - %date% %time% > "%logFile%"

:loop
    echo Checking internet connection...
    curl -s --head http://www.google.com | find "200 OK" >nul

    if errorlevel 1 (
        :: Internet is down
        echo No internet connection...
        if not exist "%tempFile%" (
            echo Internet connection lost at %date% %time% >> "%logFile%"
            echo 1 > "%tempFile%"
        )
        goto loop
    ) else (
        :: Internet is back
        echo Internet is back online!
        if exist "%tempFile%" (
            del "%tempFile%"
            echo Internet connection restored at %date% %time% >> "%logFile%"
        )
        goto loop
    )
