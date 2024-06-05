Just a simple batch file that runs commonly-run commands on command prompt on your typical windows systems whenever you encounter any computer problems

Checks for Administrative Privileges:
        The script checks if it is running with administrative privileges. If not, it restarts itself with elevated permissions using PowerShell.

Runs System File Checker:
        Executes sfc /scannow to scan and repair protected system files.

Restores System Health:
        Executes DISM /Online /Cleanup-Image /RestoreHealth to repair the Windows image.

Checks Disk Status:
        Uses wmic diskdrive get status to check the current status of all disk drives.

Checks Predictive Failure:
        Uses wmic /namespace:\root\wmi path MSStorageDriver_FailurePredictStatus to check for any predictive failures in the disk drives.

Schedules Disk Check:
        Schedules chkdsk C: /f /r /x to run on the next restart, specifically targeting the C drive (the boot drive containing the operating system).

Schedules Windows Memory Diagnostics:
        Schedules the Windows Memory Diagnostics Tool (mdsched) to run on the next restart to check for memory issues.

The script ensures comprehensive system maintenance by performing file integrity checks, system health restoration, disk status checks, predictive failure analysis, and memory diagnostics, all while ensuring it runs with the necessary administrative privileges.
