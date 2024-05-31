for(;;) {

# Welcome
clear-host
write-host ""
write-host "Powertools" -foregroundcolor Cyan
write-host "Busted machine checker & fixer" -foregroundcolor yellow
write-host "Will take action to power off machine"
write-host "if the follow is found:"
write-host ""
write-host "√ " -foregroundcolor green -nonewline
write-host "Powered On"
write-host "√ " -foregroundcolor green -nonewline
write-host "In delivery group"
write-host "√ " -foregroundcolor green -nonewline
write-host "Unregistered for 5+ minutes"
write-host ""

# Hours to run checks. If not closed for business.
$hour = Get-Date -Format "HH"
if ([Int]$hour -gt 5 -or [Int]$hour -lt 3) { 

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
    if ($truecount -lt "10"){

        foreach ($bustedvda in $bustedvdas){
            $dg = (get-brokermachine -HostedMachineName $bustedvda).DesktopGroupName
            write-host "Power off from $dg machine: " -NoNewline
            (new-brokerhostingpoweraction -machinename vanclinic\$bustedvda -action TurnOff).machinename  # Remove-BrokerMachine -MachineName vanclinic\$bustedvda -DesktopGroup $dg -force
            }
    
    }
    if ($truecount -gt "9"){

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
    write-host "Closed between 3am to 6am for maintenance" -ForegroundColor red

    ### Rest before doing all over
    write-host "Resting for 5 minutes to start over..." -ForegroundColor cyan
    start-sleep -s 300

}

}

# End of powershell