# Define the URLs for Sysmon and sysmonconfig.xml
$sysmonUrl = "https://github.com/malindarathnayake/Wazuh-sysmon-integration/raw/main/Sysmon64.exe"
$configUrl = "https://raw.githubusercontent.com/malindarathnayake/Wazuh-sysmon-integration/main/sysmonconfig.xml"

# Define the destination folder
$destinationFolder = "C:\FTS-IT\sysmon"

# Create the destination folder if it doesn't exist
if (-not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Kill Sysmon if its running 
Stop-Process -Name Sysmon -Force

# Download Sysmon executable
$sysmonPath = Join-Path $destinationFolder "Sysmon64.exe"
Invoke-WebRequest -Uri $sysmonUrl -OutFile $sysmonPath

# Download sysmonconfig.xml
$configPath = Join-Path $destinationFolder "sysmonconfig.xml"
Invoke-WebRequest -Uri $configUrl -OutFile $configPath
write-output "files downloaded"

# Run Sysmon with the provided configuration
write-output "Running sysmon with the provided configuration"
$sysmonCommand = Join-Path $destinationFolder "Sysmon64.exe"
Start-Process -FilePath $sysmonCommand -ArgumentList "-accepteula -i $configPath" -Wait -ErrorVariable $err1

if ($err1){
Write-Output "Ooops something didnt work!!!"
Write-Output $err1 
}
