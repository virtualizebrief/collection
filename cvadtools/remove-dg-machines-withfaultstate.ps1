#-Welcome message
Clear-Host
Write-Host ""
Write-Host "Citrix Powertools" -ForegroundColor Cyan
Write-Host ""
Write-Host "Remove Machines from Delivery Group which are:" -ForegroundColor Yellow
Write-Host "1. Powered on"
Write-Host "2. Not in Maintenance"
Write-Host "3. UnRegistered"
Write-Host "4. FaultState is not: none"
Write-Host ""

#-user configurable settings
Write-Host "Note: No action is taken till later if you choose to." -ForegroundColor Green
$DG = Read-Host "Enter delivery group to check"
Write-Host ""

#-do something
Clear-Content .\computers.txt
$totalCount = (Get-BrokerMachine -DesktopGroupName $DG -MaxRecordCount 10000).count
Write-Host "Machine checked: $totalCount"
Write-Host "Reason machine was flagged" -ForegroundColor Yellow
Write-Host "--------------------------------------"

$VMs = (Get-BrokerMachine -DesktopGroupName $DG -InMaintenanceMode $false -PowerState On -RegistrationState Unregistered).MachineName
Foreach ($VM in $VMs) {

    $Result = (Get-BrokerMachine -MachineName $VM).FaultState
    If ($Result -notLike "*none*"){
        Write-Host "$VM " -NoNewline -ForegroundColor Cyan
        Write-Host "$Result"
        Add-Content -Path .\computers.txt -Value "$VM"
        }

}
Write-Host "--------------------------------------"
Write-Host ""

$takeAction = Read-Host "Remove from $DG (yes/anything else to exit without action)?"
Write-Host ""
If ($takeAction -eq "yes"){

$FixMes = Get-Content .\computers.txt
Foreach ($FixMe in $FixMes){

    Remove-BrokerMachine $FixMe -DesktopGroup $DG

}
Write-Host "Completed!" -ForegroundColor Green
Pause
Exit
}

Write-Host "No action taken. Goodbye." -ForegroundColor Green
Pause
Exit
