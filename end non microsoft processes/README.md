Here's a sample `README.md` file for your program:

---

# End Non-Microsoft Processes

This program terminates all running processes that are not published by **Microsoft Corporation**. It uses a **PowerShell script** to identify processes based on their publisher and a **batch file** to execute the PowerShell script automatically.

## How It Works
- The **PowerShell script** (`EndNonMicrosoftProcesses.ps1`) retrieves all running processes, checks their publisher, and terminates processes that are not from Microsoft.
- The **batch file** (`run_end_non_microsoft.bat`) runs the PowerShell script with elevated permissions, bypassing execution policy restrictions.

## Files

1. **EndNonMicrosoftProcesses.ps1**  
   A PowerShell script that identifies and terminates all non-Microsoft processes.
   
2. **run_end_non_microsoft.bat**  
   A batch file that invokes the PowerShell script automatically.

## How to Use

1. **Download/Save the files**:
   - Save the `EndNonMicrosoftProcesses.ps1` and `run_end_non_microsoft.bat` files in the same directory.
   
2. **Run the program**:
   - Double-click `run_end_non_microsoft.bat`. 
   - This will execute the PowerShell script, which will terminate non-Microsoft processes.
   
3. **Command window**:
   - After execution, the command window will display the names of terminated processes.
   - The window will remain open to allow you to review the output.

## Requirements

- **Windows PowerShell**: The script uses PowerShell to retrieve and manage processes.
- **Administrator privileges**: Make sure you run the batch file with Administrator rights to allow it to terminate processes.

## Important Notes

- **Safety**: The script may terminate important non-Microsoft processes. Please ensure that you save all your work before running the script, as it may close applications such as browsers, third-party software, etc.
- **Customization**: You can modify the script (`EndNonMicrosoftProcesses.ps1`) to whitelist certain non-Microsoft processes if needed.

## Troubleshooting

1. **PowerShell Execution Policy Errors**:
   If you encounter errors related to script execution policies, the batch file already bypasses these restrictions. However, ensure that PowerShell is allowed to run scripts on your system.

2. **Process Not Terminated**:
   Some system-critical processes cannot be terminated even if they are not from Microsoft. This behavior is by design to protect the integrity of your system.

---

### Example of Project Structure:
```
your-folder/
├── EndNonMicrosoftProcesses.ps1
└── run_end_non_microsoft.bat
```

---

