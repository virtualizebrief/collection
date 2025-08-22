# Configurables
$sleepTime = 200
$machines = @(
"machine01.domain.com"
"machine02.domain.com"
"machine03.domain.com"
"machine04.domain.com"
)

# Clear the banner
clear-host
write-host ""
write-host ""
write-host ""
write-host ""
write-host "# Reboot machines" -foregroundcolor cyan

# Run
foreach ($machine in $machines) {

    $startTime = Get-Date -Format "hh:mm:ss tt" 
        write-host "$startTime | Rebooting: " -NoNewline
        write-host "$machine" -NoNewline -ForegroundColor Yellow
        write-host "... " -NoNewline
    restart-computer -computername $machine -force -wait
        write-host "done!" -ForegroundColor Green    
    start-sleep -s 200

}

# Goodbye
write-host ""
pause
