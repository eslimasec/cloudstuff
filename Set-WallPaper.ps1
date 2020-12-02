# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0
# modified to suit needs

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Resolve-DnsName github.com
Resolve-DnsName raw.githubusercontent.com
Resolve-DnsName live.sysinternals.com

$wc = new-object System.Net.WebClient
# Download BgInfo
$wc.DownloadFile('http://live.sysinternals.com/bginfo.exe', 'C:\ProgramData\bginfo.exe')

# Copy Wallpaper
$wc.DownloadFile('https://raw.github.com/eslimasec/cloudstuff/otr.jpg', 'C:\ProgramData\otr.jpg')

# Copy BGInfo config
$wc.DownloadFile('https://raw.githubusercontent.com/OTRF/Blacksmith/master/resources/configs/bginfo/OTRWallPaper.bgi', 'C:\ProgramData\OTRWallPaper.bgi')

# Set Run Key
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "BgInfo" -Value "C:\ProgramData\bginfo.exe C:\ProgramData\OTRWallPaper.bgi /silent /timer:0 /nolicprompt" -PropertyType "String" -force

#download security scene recommended Sysmon template
Invoke-WebRequest -Uri https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml -UseBasicParsing -OutFile C:\ProgramData\sysmonconfig-export.xml

#download Sysmon, unzip it and install it with the downloaded template
Invoke-WebRequest -UseBasicParsing -Uri https://download.sysinternals.com/files/Sysmon.zip -OutFile C:\ProgramData\sysmon.zip

Expand-Archive C:\ProgramData\Sysmon.zip

C:\ProgramData\Sysmon\Sysmon64.exe -accepteula -i C:\ProgramData\sysmonconfig-export.xml

