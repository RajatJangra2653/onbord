Start-Transcript -Path C:\WindowsAzure\Logs\CustomScriptExtension.txt -Append

$webClient = New-Object System.Net.WebClient
$url = "https://desktop.docker.com/win/main/amd64/165256/Docker%20Desktop%20Installer.exe"
$outputFile ="C:\WindowsAzure\DockerDesktopInstaller.exe"
$webClient.DownloadFile($url, $outputFile)

Start-Process $outputFile -Wait -ArgumentList 'install', '--accept-license', '--always-run-service', '--quiet', '--admin-settings'

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://raw.githubusercontent.com/RajatJangra2653/onbord/refs/heads/main/logontask.ps1","C:\LabFiles\logontask.ps1")


$Trigger= New-ScheduledTaskTrigger -AtLogOn
$User= "$($env:ComputerName)\demouser"
$Action= New-ScheduledTaskAction -Execute "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe" -Argument "-executionPolicy Unrestricted -File C:\LabFiles\logontask.ps1"
Register-ScheduledTask -TaskName "Setup" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest -Force
Set-ExecutionPolicy -ExecutionPolicy bypass -Force



Stop-Transcript
Restart-Computer -Force 


