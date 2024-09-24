Start-Transcript -Path C:\WindowsAzure\Logs\Logon1.txt -Append
Write-Host "Custom Script Extention Started"
$webClient = New-Object System.Net.WebClient
$url = "https://desktop.docker.com/win/main/amd64/165256/Docker%20Desktop%20Installer.exe"
$outputFile ="C:\WindowsAzure\DockerDesktopInstaller.exe"
$webClient.DownloadFile($url, $outputFile)

Write-Host "Docker Downloaded"

Start-Process $outputFile -Wait -ArgumentList 'install', '--accept-license', '--always-run-service', '--quiet', '--admin-settings'
Write-Host "Docker Installed"
sleep 60
$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $regPath -Name "Docker Desktop" -Value "C:\Program Files\Docker\Docker\Docker Desktop.exe"

$Trigger= New-ScheduledTaskTrigger -AtLogOn
$User= "$($env:ComputerName)\demouser"
$Action= New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File C:\WindowsAzure\logontask2.ps1"
Register-ScheduledTask -TaskName "Setup" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Force
Write-Host "Logon Task 2 Scheduled"

Stop-Transcript
Restart-Computer -Force 
