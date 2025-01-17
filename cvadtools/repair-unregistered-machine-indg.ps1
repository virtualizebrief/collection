<# details

title: repair unregistered machines from delivery group
author: michael.wood
date: 2025.01.16

#>

# variables
$deliveryGroup = "your-dg"
$service = "Citrix Desktop Service"
$logDate = Get-Date -format "yyyyMMdd_hhmmss"
$logFile = "c:\support\repair-unregistered-machines-$logDate.log"

# run forever
while ($true) {

# do thing
    $machines = (Get-BrokerMachine -DesktopGroupName $deliveryGroup).machinename

    foreach ($machine in $machines) {

        $getDate = Get-Date -format "yyyyMMdd_hhmmss"
        $registeredState = (get-brokermachine -machinename $machine).registrationstate

        if ($registeredState -eq "unregistered") {

            Get-Service -DisplayName $service -ComputerName $machine.replace("LCMCHEALTH\","") | Restart-Service
            Add-Content -Path $LogFile -Value "$getDate $machine | $registeredState | service restarted"

        }

    else {Add-Content -Path $LogFile -Value "$getDate $machine | $registeredState"}

    }

start-sleep -s 600  # rest for 5 minutes before checking again

}


