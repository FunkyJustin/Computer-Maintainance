# Get all running processes
$processes = Get-Process | Where-Object { $_.Company -ne "Microsoft Corporation" -and $_.Company -ne $null }

# Loop through each process and terminate it
foreach ($process in $processes) {
    try {
        # End the process
        Stop-Process -Id $process.Id -Force
        Write-Host "Terminated process: $($process.Name) (Publisher: $($process.Company))"
    } catch {
        Write-Host "Failed to terminate process: $($process.Name) (Error: $_)"
    }
}
