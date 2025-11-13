<#

# Reboots each VDA in a Delivery Group one by one
- Get machine names

# Foreach machine
- Maintenance on  | wait
- Sessions logoff | wait
- Power off       | wait
- Power on        | wait
- Maintenance off | wait

Repeat until all machines are completed. takes around 6 minutes per machine.

#>

# Your input please
$dg = "my-deliverygroup"

# Get list of machines
$vdas = Get-BrokerDesktop -DesktopGroupName $dg | Select-Object MachineName

# Maintenance-on, turn-off, turn-on, maintenance-off 
ForEach ($vda in $vdas){

    Set-BrokerMachineMaintenanceMode -InputObject $vda $true
    start-sleep 10

    Get-BrokerSession -MachineName $vda | Stop-BrokerSession -Force
    start-sleep 40

    New-BrokerHostingPowerAction -Action TurnOff -MachineName $vda
    start-sleep 100

    New-BrokerHostingPowerAction -Action TurnOn -MachineName $vda
    start-sleep 200

    Set-BrokerMachineMaintenanceMode -InputObject $vda $false
    start-sleep 10

}
