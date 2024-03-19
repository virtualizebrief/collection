Clear-Host
Write-Host "Gets a list of delivery group machines start time"
Write-Host ""

$dgs = (Get-BrokerDesktopGroup).name
$LogDate = Get-Date -format "yyyyMMdd_hhmmss"

ForEach ($dg in $dgs) {

    $LogFile = "C:\Support\Reports\MachineStartTimes_$dg_$LogDate.csv"
    Write-Host "Creating: $LogFile" -ForegroundColor Cyan
    Get-BrokerMachine -DesktopGroupName $dg -RegistrationState Registered -MaxRecordCount 5000 |select hostedmachinename,@{n='Last Reboot';e={gcim win32_operatingsystem -Computer $_.hostedMachineName|select -expand lastboo*}} | Export-CSV -Path $LogFile

}

Pause
exit