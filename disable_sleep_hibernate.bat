@echo off
echo Disabling sleep and hibernation...

:: Disable sleep
powercfg -change standby-timeout-ac 0
powercfg -change standby-timeout-dc 0

:: Disable hibernation
powercfg -hibernate off

echo Sleep and hibernation have been disabled.
pause
