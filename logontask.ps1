Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension1.txt -Append
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
Start-Service -Name "com.docker.service"
sleep 60
Get-Service -Name "com.docker.service"
docker --version
Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
sleep 60
docker ps
docker pull hello-world
Stop-Transcript
