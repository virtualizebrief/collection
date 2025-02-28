# You configure
$dg = "Deliver-Group"

# Gather info
$dgMachines = get-brokermachine -DesktopGroupName $dg -MaxRecordCount 100000
$mcs = ($dgMachines).catalogname | select -Unique
$dgAvailable = ($dgMachines | where-object SessionsEstablished -eq "0").Count
$dgTotal = ($dgMachines).count

# Output
clear-host
write-host "----------------------------------------"
write-host "Delivery Group: $dg" -ForegroundColor Cyan
write-host "----------------------------------------" -NoNewline
get-date
write-host "Total machines    : $dgTotal"
write-host "Available machines: $dgAvailable" 
write-host "----------------------------------------"
write-host ""

Foreach ($mc in $mcs) {

    # Get info
    $info =     ($dgMachines | where-object CatalogName -eq $mc)
    $machines = ($info).count
    $inuse =    ($info | where-object sessioncount -eq 1).count
    $newImage = ($info | where-object {$_.ImageOutOfDate -eq $false -and $_.SessionsEstablished -eq "1"}).count
    
    # Output results
    write-host $mc -ForegroundColor yellow
    write-host "machines : $machines"
    write-host "Inuse    : $inuse"
    write-host "New Image: $newImage"
    write-host ""

}
write-host "Done. Good-bye" -foregroundcolor green
pause
