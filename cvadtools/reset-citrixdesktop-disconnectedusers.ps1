# configurables

$adgroup = "CTX-CitrixDesktopUsers"
$dg = "Citrix Desktop"
$domain = "Domain\"
$logFile = "C:\support\reset-citrixdesktop-disconnectedusers.log"


# Welcome

clear-host
write-host ""
write-host "Powertools" -foregroundcolor Cyan
write-host "Reset Machine if Disconnected User" -foregroundcolor yellow
write-host "Waits 60 seconds then runs again forever."
write-host ""
write-host "Will reset machine if both are true"
write-host "√ " -foregroundcolor green -nonewline
write-host "User is in ad group: $adgroup"
write-host "√ " -foregroundcolor green -nonewline
write-host "User has disconnected: $dg"
write-host ""


for (;;) {

$getDate = Get-Date -format "yyyy-MM-dd hh:mm:ss"

# gather info on whos in ad group entitled and who is disconnected. create list of matching names

$bDisconnectedUsers = $null # clear value
$disconUsers = $null # clear value

$ErrorActionPreference = 'SilentlyContinue' # turn off errror reporting

$bUsers = (Get-ADGroupMember -Identity $adgroup).samaccountname
$disconUsersRaw = (get-brokersession -desktopgroupname $dg -SessionState disconnected).username
$disconUsers = $disconUsersRaw.Replace($domain,"")
$bDisconnectedUsers = Compare-Object -ReferenceObject $bUsers -DifferenceObject $disconUsers -IncludeEqual | Where-Object {$_.SideIndicator -like "=="} |  foreach { $_.InputObject }

$ErrorActionPreference = 'Continue' # turn on error reporting

# take action and reset the machine

foreach ($bDisconnectedUser in $bDisconnectedUsers){

    $getDate = Get-Date -format "yyyy-MM-dd hh:mm:ss"
    $machine = $null # clear value

    $machine = (get-brokersession -username ($domain + $bDisconnectedUser) -desktopgroupname $dg -SessionState disconnected).machinename
    write-host "$getDate " -NoNewline -ForegroundColor Cyan
    write-host "$bDisconnectedUser " -NoNewline -ForegroundColor green
    
        (new-brokerhostingpoweraction -machinename $machine -action reset).machinename

    add-content -Path $logFile -Value "$getDate $bDisconnectedUser $machine reset"
    
    }

If ($bDisconnectedUsers -eq $null) {
    
    write-host "$getDate " -NoNewLine -ForegroundColor cyan
    write-host "No disconnected sessions in " -nonewline -ForegroundColor yellow
    write-host "$dg " -nonewline -ForegroundColor green
    write-host "for " -nonewline -ForegroundColor yellow
    write-host "$adgroup" -ForegroundColor green

    add-content -Path $logFile -Value "$getDate No disconnected sessions in $dg for $adgroup"

    }

# pause before doing again

start-sleep -s 60

}

