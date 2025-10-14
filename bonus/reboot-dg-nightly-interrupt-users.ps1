<#

Power off & power on machines in delivery group

1. Before taking action get current last reboot for each machine
2. Send message to end user sessions
3. Get list of vdas
4. Put in maintenance
5. Send user message & logoff sessions
6. Power off & wait
7. Power on & wait
8. Take out of maintenance
9. After taking action et current last reboot for each machine 

#>

#-Your input please
$dg = "YOUR-DELIVERYGROUP" # for you to edit

#-Create log path if not existing
$logPath = "C:\Support\Reports"
if (-not (Test-Path -Path $logPath -PathType Container)) {
    New-Item -Path $logPath -ItemType Directory -Force}

#-Report of current start times of machines *before taking action*
$LogDate = Get-Date -format "yyyyMMdd_hhmmss"
$LogFile = "$logPath\LastBoot-$dg-$LogDate.csv"
Get-BrokerMachine -DesktopGroupName $dg -MaxRecordCount 5000 |select hostedmachinename,@{n='Last Reboot';e={gcim win32_operatingsystem -Computer $_.hostedMachineName|select -expand lastboo*}} | Export-CSV -Path $LogFile

#-Get list of machines and put in maintenance
$vdas = (Get-BrokerMachine -DesktopGroupName $dg).MachineName
ForEach ($vda in $vdas) {
    Set-BrokerMachineMaintenanceMode -InputObject $vda $true}
Start-Sleep -s 60

#-Set message of logoff to sessions
Foreach ($vda in $vdas) {
    Get-BrokerSession -MachineName $vda | Send-BrokerSessionMessage -Title "StoreFront Maintenance" -MessageStyle Critical -Text "In 1 minutes your application will logoff. This maintenance will last approximately 15 minutes."}
Start-Sleep -s 60

#-Logoff user sessions
Foreach ($vda in $vdas) {
    Get-BrokerSession -MachineName $vda | Stop-BrokerSession}
Start-Sleep -s 180

#-Power off vdas
Foreach ($vda in $vdas) {
    New-BrokerHostingPowerAction -Action TurnOff -MachineName $vda}
Start-Sleep -s 60

#-Power on vdas
Foreach ($vda in $vdas) {
    New-BrokerHostingPowerAction -Action TurnOn -MachineName $vda
    Start-Sleep -s 10 } # reset a little between power on per vda
Start-Sleep -S 600

#-Turn off maintenance
Foreach ($vda in $vdas) {
    Set-BrokerMachineMaintenanceMode -InputObject $vda $false}
Start-Sleep -S 60

#-Report of current start times of machines *after taking action*
$LogDate = Get-Date -format "yyyyMMdd_hhmmss"
$LogFile = "C:\Support\Reports\LastBoot-$dg-$LogDate.csv"
Get-BrokerMachine -DesktopGroupName $dg -MaxRecordCount 5000 |select hostedmachinename,@{n='Last Reboot';e={gcim win32_operatingsystem -Computer $_.hostedMachineName|select -expand lastboo*}} | Export-CSV -Path $LogFile
