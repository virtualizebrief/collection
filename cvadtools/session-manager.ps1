clear-host
write-host "# Citrix Session Manager" -foregroundcolor Cyan
write-host "Edition: Desktop support & service desk" -foregroundcolor yellow
write-host "End user version Citrix site: Citrix Session Manager"
write-host ""
write-host "---"
write-host "See users Citrix sessions and end one if selected" -foregroundcolor green
write-host "or 'q' to quite and take no action." -foregroundcolor green
write-host "---"
write-host ""
$userGet = read-host "User name (ie first.last)"
If ($userGet -eq 'q'){write-host ""
    write-host "Quite selected." -foregroundcolor green
    pause
    exit}
$user = "*" + $userGet
write-host ""

$cloudKeys = ((Get-BrokerSession -UserName $User).SessionKey).Guid | sort-object


function show-sessions-cloud {

write-host "# Site: Cloud" -ForegroundColor Cyan
write-host "---"
foreach ($cloudKey in $cloudKeys){

    $lineNumber = ($cloudKeys | Select-String -Pattern $cloudKey).LineNumber
    write-host "SessionNumber : c$lineNumber" -ForegroundColor green
    $cloudResults = Get-BrokerSession -SessionKey $cloudKey | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName,protocol | Out-String
    $cloudResults.trim()
    write-host ""
    }
if (!($cloudResults)) {write-host "No sessions found" -foregroundcolor red}
write-host "---"
write-host ""
}


Clear-Host
write-host "# Citrix Session Manager" -foregroundcolor Cyan
write-host "Edition: Desktop Support & Help desk" -foregroundcolor yellow
write-host "Selected user: $userGet"
write-host ""

show-sessions-cloud

write-host ""
Write-host "This will disconnect, logoff and hide a users session" -ForegroundColor yellow
$sessionKill = read-host "Enter session number (or 'q' to quit)"
If ($sessionKill -eq 'q'){write-host ""
    write-host "Quite selected." -foregroundcolor green
    pause
    exit}

Clear-Host
write-host "# Citrix Session Manager" -foregroundcolor Cyan
write-host "Edition: Desktop Support & Help desk" -foregroundcolor yellow
write-host "Selected user: $userGet"
write-host ""

If ($sessionKill -like "c*") {

    $sessionKillNumber = $sessionKill.trim("c")
    $Uid = $cloudKeys | Select-object -Index ($sessionKillNumber-1)

    write-host "# Selected session from Blue" -ForegroundColor cyan
    write-host "---"
    $which = Get-BrokerSession -UserName $User -SessionKey $Uid | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName,protocol | Out-String
    $which.trim()
    write-host "---"
    write-host ""
    write-host "# Taking action" -ForegroundColor cyan

    # finally take action
    $try = Get-BrokerSession -UserName $User -SessionKey $Uid | Disconnect-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "disconnect"

    $try = Get-BrokerSession -UserName $User -SessionKey $Uid | Stop-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "logoff"
        
    $try = Get-BrokerSession -UserName $User -SessionKey $Uid | Set-BrokerSession -hidden $true
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "hide"

}

write-host "Completed!" -foregroundcolor green
write-host ""
write-host "Can run this again to check if session is gone or"
write-host "verify in Citrix Director."
write-host ""
write-host "# Goodbye." -foregroundcolor cyan
pause