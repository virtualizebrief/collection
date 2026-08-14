$ps = ""
$printers = (get-smbshare -cimsession $ps | where-object {$_.sharetype -eq "printqueue"}).name

foreach ($printer in $printers) {
  $map = "\\$ps\$printer"
  try {add-printer -connectionname $map
    write-host "Added: $map" -foregroundcolor green}
  catch {write-warning "Failed: $map}
}
pause
