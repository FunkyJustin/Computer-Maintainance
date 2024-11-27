@echo off
setlocal

echo Stopping non-Microsoft tasks...

:: List of Microsoft programs that should not be terminated
set "whitelist=explorer.exe wininit.exe winlogon.exe lsass.exe svchost.exe csrss.exe services.exe smss.exe cmd.exe"

:: Get the name of the currently running batch file (without the path)
for %%a in ("%~nx0") do set "batchFile=%%a"

:: Loop through all running tasks
for /f "skip=3 tokens=1" %%i in ('tasklist /fo csv /nh') do (
    :: Remove quotes from the task name
    set "taskName=%%~i"
    
    :: Enable delayed expansion to compare variable values inside loops
    setlocal enabledelayedexpansion
    
    :: Check if the task is in the whitelist
    set "isWhitelisted=0"
    for %%w in (%whitelist%) do (
        if /i "!taskName!"=="%%w" (
            set "isWhitelisted=1"
        )
    )
    
    :: If the task is not whitelisted and not the batch file, terminate it
    if "!isWhitelisted!"=="0" (
        if /i "!taskName!" neq "%batchFile%" (
            echo Terminating !taskName!
            taskkill /f /im "!taskName!" >nul 2>&1
        )
    )
    
    endlocal
)

echo Done.
endlocal
exit /b
