$dgs = @(
    "deliverygroup01"
    "deliverygroup02"
)

$source = "\\server\path\file.txt"
$destination = "\c$\support\"

clear-host
write-host "# Copy file to Delivery Group" -foregroundcolor cyan
write-host "- Source: " -nonewline
write-host "$source" -foregroundcolor yellow
write-host "- Destination: " -nonewline
write-host "$destination" -foregroundcolor yellow
write-host ""
write-host "# Delivery Groups" -ForegroundColor cyan
write-host $dgs -ForegroundColor Gray
pause

write-host ""
write-host "# Results" -ForegroundColor Cyan
write-host "---"

foreach ($dg in $dgs) {

    write-host ""
    write-host "$dg" -ForegroundColor Gray
    $machines = $null
    $machines = (Get-BrokerMachine -DesktopGroupName $dg).dnsname
    foreach ($machine in $machines) {
        
        write-host "Processing " -NoNewline
        write-host "$machine " -ForegroundColor yellow -NoNewline
        Copy-Item -Path $source -Destination ("\\" + $machine + $destination) -Force
        write-host "done!" -ForegroundColor green

    }
    write-host ""

}

write-host "---"
write-host ""
write-host "# Completed task. Good-bye!" -ForegroundColor Cyan
pause
