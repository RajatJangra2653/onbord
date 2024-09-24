Start-Transcript -Path C:\WindowsAzure\Logs\CloudLabsCustomScriptExtension1.txt -Append

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
Set-ItemProperty -Path $regPath -Name "Docker Desktop" -Value "C:\Program Files\Docker\Docker\Docker Desktop.exe"

Start-Service -Name "com.docker.service"


sleep 180

Get-Service -Name "com.docker.service"

docker --version
$dockerUsersGroupExists = Get-LocalGroup -Name 'docker-users' -ErrorAction SilentlyContinue
$CurrentUser = "demouser"
if ($dockerUsersGroupExists -ne $null) {
    Add-LocalGroupMember -Group 'docker-users' -Member $CurrentUser -Verbose
    Write-Host "User '$CurrentUser' added to the 'docker-users' group."
} else {
    Write-Host "'docker-users' group does not exist. Skipping adding the user to 'docker-users'."
}


Start-Process -FilePath "C:\Program Files\Docker\Docker\Docker Desktop.exe"
sleep 180
docker ps

docker pull hello-world


Stop-Transcript
