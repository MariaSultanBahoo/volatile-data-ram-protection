# 🔐 Volatile Data Saving from Windows  
### Cryptanalysis and Protection of Login Credentials in RAM

## 📌 Overview

This project demonstrates how login credentials handled by Windows applications can persist in **volatile memory (RAM)** and be recovered using forensic tools. A basic C# login form was developed to simulate a real-world scenario. Using `Process Hacker` and `strings.exe`, sensitive data was successfully extracted from memory dumps. A lightweight **PowerShell-based memory clearing mechanism** was then implemented to mitigate the risk of credential exposure.

---

## 🧰 Tools & Technologies

| Tool                      | Purpose                              |
|---------------------------|--------------------------------------|
| C# (.NET Framework)       | Custom login form (WinForms)         |
| Process Hacker            | Memory dump of specific processes    |
| strings.exe (Sysinternals)| Analyze memory dump for plaintext    |
| PowerShell                | Script to clear memory and processes |
| Clear-MemoryStandbyList   | Free standby memory on Windows       |

---

## 🧪 Demonstration Steps

### Step 1: Simulate Login
- Launch `loginapp.exe`
- Enter credentials: `testuser / password123`

### Step 2: Capture Memory Dump
- Open **Process Hacker** → Locate `loginapp.exe`  
- Right-click → Miscellaneous → Create Dump → **Full Dump**  
- Save as `before_fix.dmp`

### Step 3: Analyze Dump with Strings
```
strings before_fix.dmp > strings_before.txt
Open strings_before.txt and search for password123 or admin
✅ Expected Result
Plaintext credentials found in the memory.

🛡️ **Protection Mechanism**
A PowerShell script was created to:
Terminate the login application process
Clear standby memory to reduce data retention

🔧 **PowerShell Script**
# Kill the login application
Stop-Process -Name "loginapp" -Force
# Clear standby memory (Sysinternals tool)
Start-Process -FilePath "C:\Tools\Clear-MemoryStandbyList.exe" -Wait
Download memory clearing tool:
🔗 https://wj32.org/wp/software/empty-standby-list/

🔁 **Post-Fix Analysis**
Step 1: Relaunch Login App
Input credentials again
Run cleanup.ps1 script after login

Step 2: Create New Memory Dump
Save dump as after_fix.dmp

Step 3: Run strings
strings after_fix.dmp > strings_after.txt
🔒 Expected Result
Credentials no longer appear in memory dump or are scrambled.

📊 **Results**
Metric	                 Before Fix	           After Fix
Credentials in RAM	      Found	               Not Found
Process Residue	          Present               Cleared
Memory Exposure Time	  ~30 seconds	           ~5–10 seconds

📁 **Project Structure**
📦 VolatileDataRAM
├── loginapp.exe               # C# compiled login application
├── cleanup.ps1                # PowerShell script to clear memory
├── before_fix.dmp             # Dump before applying fix
├── after_fix.dmp              # Dump after applying fix
├── strings_before.txt         # Output of strings before fix
├── strings_after.txt          # Output of strings after fix

