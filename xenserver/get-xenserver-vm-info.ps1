Clear-Host
Write-Host ""
Write-Host "Gathering info..." -ForegroundColor Green
Write-Host ""

#-you configure these
$reportLocation = "C:\Support\xenserver\reports"
Write-Host "Report location: " -ForegroundColor Cyan -NoNewLine
Write-Host "$reportLocation"
$Password = Read-Host "Password for XenServers"
Write-Host ""

#-get list of xenservers
$gethosts = (Get-BrokerMachine -MaxRecordCount 10000).HostingServerName
$XenServers = $gethosts | Sort-Object | Select-Object -Unique
    Write-Host "XenServer in use with Citrix site" -ForegroundColor cyan
    Write-Host "Count: " -ForegroundColor Yellow -NoNewline
    ($XenServers).count

#-load powershell module
Dir C:\Windows\System32\WindowsPowerShell\v1.0\Modules\XenServerPSModule\* | Unblock-File
Import-Module XenServerPSModule
Remove-Item $reportLocation\* -force

#-do the thing
$GetDate = Get-Date -format "yyyyMMdd.hhmmss"
Get-XenSession | Disconnect-XenServer
Write-Host ""
Write-Host "Checking each XenServer..." -ForegroundColor Yellow -NoNewLine

ForEach ($XenServer in $XenServers) {

#Write-Host "$XenServer " -ForegroundColor Yellow -NoNewline
Connect-XenServer -Url "http://$XenServer" -UserName root -Password $password

    $GetDate = Get-Date -format "yyyyMMdd.hhmmss"
    Get-XenVM | Where-Object -Property name_label -like ‘CTX*’ | Select-Object name_label,vcpus_max,memory_static_max |
    Export-Csv $reportLocation\$XenServer-$GetDate.csv -NoTypeInformation -Force

Get-XenSession | Disconnect-XenServer


    $csv = Import-Csv $reportLocation\$XenServer-$GetDate.csv
    ForEach ($row in $csv) {
        $row | Add-Member -NotePropertyName 'XenServer' -NotePropertyValue $XenServer
        }
    $csv | Export-Csv $reportLocation\$XenServer-$GetDate.csv -NoTypeInformation -Force


#Write-Host "done!" -ForegroundColor Green

}

#-create single big report
$fileheader = (Get-ChildItem -Path $reportLocation\*.csv | Select -First 1).name
$header = Get-Content $reportLocation\$fileheader -Head 1
$removeheaders = (Get-ChildItem -Path $reportLocation\*.csv).name
$GetDate = Get-Date -format "yyyyMMdd.hhmmss"
start-sleep -s 3
$LogFile = "$reportLocation\XenServer-VM-BigReport-$GetDate.csv"

ForEach ($removeheader in $removeheaders){
    (gc $reportLocation\$removeheader | select -Skip 1) | sc $reportLocation\$removeheader
    $content = Get-Content $reportLocation\$removeheader
    Add-Content -Path $LogFile -Value $content
    }

($header, (Get-Content -Path $LogFile)) | Set-Content $LogFile

Write-Host "done!" -Foregroundcolor Green
Write-Host "Created single log file: " -ForegroundColor Cyan -NoNewline
Write-Host "$LogFile"
Write-Host ""

Pause
exit