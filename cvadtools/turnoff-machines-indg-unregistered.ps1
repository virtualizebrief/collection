for(;;) {

# Welcome
clear-host
write-host ""
write-host "Powertools" -foregroundcolor Cyan
write-host "Machine fixer" -foregroundcolor yellow
write-host "Operating hours: 06:00 to 24:00"
write-host "Warning: if more than 15 found during" -foregroundcolor red
write-host "both rounds no action is taken. You" -foregroundcolor red
write-host "should investigate yourself." -foregroundcolor red
write-host ""
write-host "Will power off machine if:"
write-host "√ " -foregroundcolor green -nonewline
write-host "Powered On"
write-host "√ " -foregroundcolor green -nonewline
write-host "In delivery group"
write-host "√ " -foregroundcolor green -nonewline
write-host "Maintenance not on"
write-host "√ " -foregroundcolor green -nonewline
write-host "Unregistered for 5+ minutes"
write-host ""

# Hours to run checks. If not closed for business.
$hour = Get-Date -Format "HH"
if ([Int]$hour -gt 5) { 

# Gather info
$busted = get-brokermachine -RegistrationState Unregistered -PowerState On -InMaintenanceMode $false | Where-Object {$_.DesktopGroupName -ne $null}
$bustedList = $busted | Select-Object HostedMachineName,RegistrationState,PowerState,DesktopGroupName
$vdas = ($busted).HostedMachineName
$count = ($vdas).count

# Do something
## No busted
If ($vdas -eq $null){

    write-host "Busted machines found: " -nonewline -foregroundcolor yellow
    write-host "0" -foregroundcolor green
    Get-Date -Format "yyyy.MM.dd | HH:mm:ss tt"
    write-host "Yay! no busted machines. resting for 5 minutes..." -ForegroundColor cyan
    start-sleep -s 300

}

## Busted
If ($vdas -ne $null){

    ### Round 1 display
    write-host "Round 1 - Found busted machines: " -nonewline -ForegroundColor yellow
    write-host "$count" -foregroundcolor red
    $vdas
    Get-Date -Format "yyyy.MM.dd | HH:mm:ss tt"
    write-host "Resting for 5 minutes and check again..." -ForegroundColor cyan
    write-host ""
    start-sleep -s 300

    ### Get 2nd list
    $bustedvdas = $null # reset value
    $busted2 = get-brokermachine -RegistrationState Unregistered -PowerState On | Where-Object {$_.DesktopGroupName -ne $null}
    $vda2s = ($busted2).HostedMachineName
    $bustedvdas = Compare-Object -ReferenceObject $vdas -DifferenceObject $vda2s -IncludeEqual | Where-Object {$_.SideIndicator -like "=="} |  foreach { $_.InputObject }
    $count2 = ($vda2s).count
    $truecount = ($bustedvdas).count

    ### Round 2 display
    write-host "Round 2 - Found busted machines: " -nonewline -ForegroundColor yellow
    write-host "$count2" -foregroundcolor red
    $vda2s
    Get-Date -Format "yyyy.MM.dd | HH:mm:ss tt"
    write-host ""
    write-host "True busted machines: " -nonewline -ForegroundColor yellow
    write-host "$truecount" -ForegroundColor red

    ### Take action if less than 10 machines found
    if ($truecount -lt "16"){

        foreach ($bustedvda in $bustedvdas){
            $dg = (get-brokermachine -HostedMachineName $bustedvda).DesktopGroupName
            write-host "Power off from $dg machine: " -NoNewline
            # Remove-BrokerMachine -MachineName vanclinic\$bustedvda -DesktopGroup $dg -force # Action: Remove from DG
            (new-brokerhostingpoweraction -machinename vanclinic\$bustedvda -action TurnOff).machinename # Action: Power off
            }
    
    }
    if ($truecount -gt "15"){

        write-host "10 or more busted!"
        write-host "No action taken. You need to investigate."
    
    }


    ### Rest before doing all over
    write-host "Resting for 5 minutes to start over..." -ForegroundColor cyan
    start-sleep -s 300
    
}

}
Else {

    # off hours
    write-host "Closed between 00:00 to 06:00 for maintenance" -ForegroundColor red

    ### Rest before doing all over
    write-host "Resting for 5 minutes to start over..." -ForegroundColor cyan
    start-sleep -s 300

}

}

# End of powershell