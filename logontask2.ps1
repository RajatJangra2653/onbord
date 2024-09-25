Start-Transcript -Path C:\WindowsAzure\Logs\Logontask2.txt -Append
Start-Service -Name "com.docker.service"
sleep 60
Get-Service -Name "com.docker.service"
docker --version
Unregister-ScheduledTask -TaskName "Setup1" -Confirm:$false
Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
sleep 180
docker ps
docker pull hello-world
Stop-Transcript
