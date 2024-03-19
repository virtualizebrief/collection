Clear-Host
write-host ""
Write-Host "Powertools" -foregroundcolor cyan
Write-Host "Gets a list of delivery group > machine start times"
Write-Host ""

$dgs = (Get-BrokerDesktopGroup).name
$LogDate = Get-Date -format "yyyyMMdd_hhmmss"

ForEach ($dg in $dgs) {

    #$dg = Read-Host "Enter delivery group name"
    $LogFile = "C:\Support\Reports\MachineStartTimes.$dg.$LogDate.csv"
    Write-Host "Creating: " -NoNewLine
    Write-Host "$LogFile..." -ForegroundColor Yellow -NoNewLine
    
        Get-BrokerMachine -DesktopGroupName $dg -RegistrationState Registered -MaxRecordCount 5000 | where-object {$_.name -ne "*kn*"} |select hostedmachinename,@{n='Last Reboot';e={gcim win32_operatingsystem -Computer $_.hostedMachineName|select -expand lastboo*}} | Export-CSV -Path $LogFile
    
    Write-Host "done!" -ForegroundColor Green

}

Write-Host ""
Pause
exit