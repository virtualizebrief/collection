clear-host

# delivery group
$dg = "DG-Name"
$time = "260"
$sessionState = "Disconnected"

# Get current time
$currentTime = Get-Date

# Query disconnected sessions
$sessions = Get-BrokerSession -DesktopGroupName $dg -MaxRecordCount 10000 | Where-Object { $_.SessionState -eq $sessionState }
$count = ($sessions).count

# Heading
write-host ""
write-host "# Delivery group: $dg" -ForegroundColor cyan
Write-Host "- Sessionstates $sessionState : $count"
write-host "- Greater than time to filter by : $time minutes"
write-host ""
write-host "# Sessionstates with greater than time & connected" -ForegroundColor green
Write-Host "Time | Machine Name | User Name (sometimes blank)" -ForegroundColor yellow
Write-Host "---------------------------------------------------"

# Check if there are any disconnected sessions
if ($sessions) {
    foreach ($session in $sessions) {
        # Calculate minutes disconnected
        $minutes = [math]::Round(($currentTime - $session.SessionStateChangeTime).TotalMinutes, 0)

        if ($minutes -gt $time) {
            # Output session details
            Write-Output "$minutes $($session.MachineName) $($session.UserFullName)"
            # Restart VDA
            # New-BrokerHostingPowerAction -Action "Restart" -MachineName $($session.MachineName)
        }
    }
} else {
    Write-Output "No results." -foregroundcolor red
}
Write-Host "---------------------------------------------------"
write-host ""

write-host "# Power reset the above machines" -foregroundcolor red
                $warn = Read-Host "- Continue? (y/n)"
                write-host ""
                If ($warn -eq "y"){

                # Check if there are any disconnected sessions
                if ($sessions) {
                    foreach ($session in $sessions) {
                    # Calculate minutes disconnected
                    $minutes = [math]::Round(($currentTime - $session.SessionStateChangeTime).TotalMinutes, 0)

                    if ($minutes -gt $time) {
                        # Restart VDA
                        write-host "rebooting... " -ForegroundColor red -nonewline
                        (New-BrokerHostingPowerAction -Action "Reset" -MachineName $($session.MachineName)).HostedMachineName
                        }
                    }
                }            
}

write-host ""
write-host "done!" -ForegroundColor Green
pause
