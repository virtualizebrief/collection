for(;;) {

# Welcome
clear-host
write-host ""
write-host "Powertools" -foregroundcolor Cyan
write-host "Busted machine checker & fixer" -foregroundcolor yellow
write-host "Will take action to remove a machine from"
write-host "delivery group if the follow is found:"
write-host ""
write-host "√ " -foregroundcolor green -nonewline
write-host "Powered On"
write-host "√ " -foregroundcolor green -nonewline
write-host "Unregistered"
write-host "√ " -foregroundcolor green -nonewline
write-host "In delivery group"
write-host "√ " -foregroundcolor green -nonewline
write-host "Is this way for 5 minutes"
write-host ""

# Gather info
$busted = get-brokermachine -RegistrationState Unregistered -PowerState On | Where-Object {$_.DesktopGroupName -ne $null}
$bustedList = $busted | Select-Object HostedMachineName,RegistrationState,PowerState,DesktopGroupName
$vdas = ($busted).HostedMachineName
$count = ($vdas).count

# Do something
## No busted
If ($vdas -eq $null){

    write-host "Busted machines found: " -nonewline -foregroundcolor yellow
    write-host "0" -foregroundcolor green
    get-date
    write-host "Yay! no busted machines. resting for 5 minutes..." -ForegroundColor cyan
    start-sleep -s 300

}

## Busted
If ($vdas -ne $null){

    ### Round 1 display
    write-host "Round 1 - Found busted machines: " -nonewline -ForegroundColor yellow
    write-host "$count" -foregroundcolor red
    $vdas
    get-date
    write-host "Resting for 5 minutes and check again..." -ForegroundColor cyan
    write-host ""
    start-sleep -s 300

    ### Get 2nd list
    $busted2 = get-brokermachine -RegistrationState Unregistered -PowerState On | Where-Object {$_.DesktopGroupName -ne $null}
    $vda2s = ($busted2).HostedMachineName
    $bustedvdas = Compare-Object -ReferenceObject $vdas -DifferenceObject $vda2s -IncludeEqual | Where-Object {$_.SideIndicator -like "=="} |  foreach { $_.InputObject }
    $count2 = ($vda2s).count
    $truecount = ($bustedvdas).count

    ### Round 2 display
    write-host "Round 2 - Found busted machines: " -nonewline -ForegroundColor yellow
    write-host "$count2" -foregroundcolor red
    $vda2s
    write-host ""
    get-date
    write-host ""
    write-host "True busted machines: " -nonewline -ForegroundColor yellow
    write-host "$truecount"

    ### Take action: remove busted machines from delivery group
    foreach ($bustedvda in $bustedvdas){
        $dg = (get-brokermachine -HostedMachineName $bustedvda).DesktopGroupName
        write-host "Removing $bustedvda from $dg..."
        Remove-BrokerMachine -MachineName vanclinic\$bustedvda -DesktopGroup $dg -force
        write-host "done!"
        }

    ### Rest before doing all over
    write-host "Busted machine no longer a problem."
    write-host "Resting for 5 minutes to start over..." -ForegroundColor cyan
    start-sleep -s 300
    
}

}

# End of powershell