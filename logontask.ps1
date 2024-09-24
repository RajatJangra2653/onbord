Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension1.txt -Append
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
