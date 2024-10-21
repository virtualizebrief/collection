# sites (you configure these)

$siteA = "siteA-con1.yourdomain.com"
$siteB = "siteB-con1.yourdomain.com"

# run menu

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

$siteAKeys = ((Get-BrokerSession -AdminAddress $siteA -UserName $User).SessionKey).Guid | sort-object
$siteBKeys = ((Get-BrokerSession -AdminAddress $siteB -UserName $User).SessionKey).Guid | sort-object


function show-sessions-a {

$siteAName = (get-brokersite -AdminAddress $siteA).name
write-host "# Site: $siteAName" -ForegroundColor Cyan
write-host "---"
foreach ($siteAKey in $siteAKeys){

    $lineNumber = ($siteAKeys | Select-String -Pattern $siteAKey).LineNumber
    write-host "SessionNumber : A$lineNumber" -ForegroundColor green
    $SiteAResults = Get-BrokerSession -AdminAddress $siteA -SessionKey $siteAKey | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName,protocol | Out-String
    $siteAResults.trim()
    write-host ""
    }
if (!($siteAResults)) {write-host "No sessions found" -foregroundcolor red}
write-host "---"
write-host ""
}


function show-sessions-b {

$siteBName = (get-brokersite -AdminAddress $siteB).name
write-host "# Site: $siteBName" -ForegroundColor Cyan
write-host "---"
foreach ($siteBKey in $siteBKeys){

    $lineNumber = ($siteBKeys | Select-String -Pattern $siteBKey).LineNumber
    write-host "SessionNumber : B$lineNumber" -ForegroundColor green
    $siteBResults = Get-BrokerSession -AdminAddress $siteB -SessionKey $siteBKey | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName,protocol | Out-String
    $siteBResults.trim()
    write-host ""
    }
if (!($siteBResults)) {write-host "No sessions found" -foregroundcolor red}
write-host "---"
write-host ""
}

Clear-Host
write-host "# Citrix Session Manager" -foregroundcolor Cyan
write-host "Edition: Desktop Support & Help desk" -foregroundcolor yellow
write-host "Selected user: $userGet"
write-host ""

show-sessions-a
show-sessions-b

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

If ($sessionKill -like "*a*") {

    $sessionKillNumber = $sessionKill.trim("a")
    $Uid = $siteAKeys | Select-object -Index ($sessionKillNumber-1)

    write-host "# Selected session from Blue" -ForegroundColor cyan
    write-host "---"
    $which = Get-BrokerSession -AdminAddress $siteA -UserName $User -SessionKey $Uid | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName,protocol | Out-String
    $which.trim()
    write-host "---"
    write-host ""
    write-host "# Taking action" -ForegroundColor cyan

    # finally take action
    $try = Get-BrokerSession -AdminAddress $siteA -UserName $User -SessionKey $Uid | Disconnect-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "disconnect"

    $try = Get-BrokerSession -AdminAddress $siteA -UserName $User -SessionKey $Uid | Stop-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "logoff"
        
    $try = Get-BrokerSession -AdminAddress $siteA -UserName $User -SessionKey $Uid | Set-BrokerSession -hidden $true
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "hide"
    
    $sessiontype = (Get-BrokerSession -AdminAddress $siteBlue -UserName $User -SessionKey $Uid).sessionsupport
    If ($sessiontype -eq "SingleSession") {
        $resetmachine = (Get-BrokerSession -AdminAddress $siteBlue -UserName $User -SessionKey $Uid).MachineName
        $try = New-BrokerHostingPowerAction -MachineName $resetmachine -Action Reset
        start-sleep -s 2
        write-host " √ " -foregroundcolor green -nonewline
        write-host "reset-machine"
        }
    If ($sessiontype -eq "MultiSession") {
        start-sleep -s 2
        write-host " • " -foregroundcolor yellow -nonewline
        write-host "reset-machine skipped: $sessiontype"
        }

}

If ($sessionKill -like "*b*") {

    $sessionKillNumber = $sessionKill.trim("b")
    $Uid = $siteBKeys | Select-object -Index ($sessionKillNumber-1)

    write-host "# Selected session from $siteB" -ForegroundColor cyan
    write-host "---"
    $which = Get-BrokerSession -AdminAddress $siteB -UserName $User -SessionKey $Uid | select-object LaunchedViaPublishedName,SessionState,Hidden,DesktopGroupName,DNSName.protocol | Out-String
    $which.trim()
    write-host "---"
    write-host ""
    write-host "# Taking action" -ForegroundColor cyan

    # finally take action
    $try = Get-BrokerSession -AdminAddress $siteB -UserName $User -SessionKey $Uid | Disconnect-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "disconnect"

    $try = Get-BrokerSession -AdminAddress $siteB -UserName $User -SessionKey $Uid | Stop-BrokerSession
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "logoff"

    $try = Get-BrokerSession -AdminAddress $siteB -UserName $User -SessionKey $Uid | Set-BrokerSession -hidden $true
    start-sleep -s 2
    write-host " √ " -foregroundcolor green -nonewline
    write-host "hide"
    
    $sessiontype = (Get-BrokerSession -AdminAddress $siteBlue -UserName $User -SessionKey $Uid).sessionsupport
    If ($sessiontype -eq "SingleSession") {
        $resetmachine = (Get-BrokerSession -AdminAddress $siteBlue -UserName $User -SessionKey $Uid).MachineName
        $try = New-BrokerHostingPowerAction -MachineName $resetmachine -Action Reset
        start-sleep -s 2
        write-host " √ " -foregroundcolor green -nonewline
        write-host "reset-machine"
        }
    If ($sessiontype -eq "MultiSession") {
        start-sleep -s 2
        write-host " • " -foregroundcolor yellow -nonewline
        write-host "reset-machine skipped: $sessiontype"
        }

}

write-host "Completed!" -foregroundcolor green
write-host ""
write-host "Can run this again to check if session is gone or"
write-host "verify in Citrix Director."
write-host ""
write-host "# Goodbye." -foregroundcolor cyan
pause
