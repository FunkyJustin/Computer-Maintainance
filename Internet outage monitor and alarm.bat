@echo off
setlocal

:loop
    echo Checking internet connection...
    curl -s --head http://www.google.com | find "200 OK" >nul

    if errorlevel 1 (
        echo No internet connection...
        timeout /t 5 >nul
        goto loop
    ) else (
        echo Internet is back online!
        call :alert1
    )
goto loop

:alert1
    powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\chimes.wav").PlaySync()
    msg * "Internet is back online!"
goto alert2


:alert2
    timeout /t 5 >nul
    powershell -c (New-Object Media.SoundPlayer "C:\Windows\Media\chimes.wav").PlaySync()
goto alert2


