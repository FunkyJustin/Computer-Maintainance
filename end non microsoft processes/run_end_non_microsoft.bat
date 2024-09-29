@echo off
:: Run the PowerShell script with Bypass ExecutionPolicy
powershell -ExecutionPolicy Bypass -File "%~dp0EndNonMicrosoftProcesses.ps1"
pause
