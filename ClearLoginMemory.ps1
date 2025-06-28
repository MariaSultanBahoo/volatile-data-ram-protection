
$loginProcessName = "Simpleloginform"
Write-Host "`n[INFO] Starting memory cleanup process..."
# Step 1: Kill the login app
$loginApp = Get-Process -Name $loginProcessName -ErrorAction SilentlyContinue
if ($loginApp) {
    Stop-Process -Name $loginProcessName -Force
    Write-Host "[OK] Process '$loginProcessName' terminated."
} else {
    Write-Host "[WARNING] Process '$loginProcessName' not found or already closed."
}

# Step 2: Clear standby memory using Clear-MemoryStandbyList.exe
$clearingTool = ".\Clear-MemoryStandbyList.exe"
if (Test-Path $clearingTool) {
    Write-Host "[INFO] Running memory clearing tool..."
    Start-Process -FilePath $clearingTool -Wait
    Write-Host "[OK] Standby memory cleared successfully."
} else {
    Write-Host "[ERROR] $clearingTool not found. Please ensure it's in the same folder."
}

Write-Host "`n[COMPLETE] Protection mechanism executed.`n"
