# configurables

$adgroup = "CitrixDesktopusers"
$dg = "CitrixDesktopDG"
$domain = "MyDomain\"
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
    
    }

# if no users found say something

If ($bDisconnectedUsers -eq $null) {
    
    write-host "$getDate " -NoNewLine -ForegroundColor cyan
    write-host "No disconnected sessions in " -nonewline -ForegroundColor yellow
    write-host "$dg " -nonewline -ForegroundColor green
    write-host "for " -nonewline -ForegroundColor yellow
    write-host "$adgroup" -ForegroundColor green

    }

