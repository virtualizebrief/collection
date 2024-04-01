#-welcome and get desktop name

clear-host
write-host ""
write-host "Powertools" -ForegroundColor Cyan
write-host " Get & set Desktop after use what to do" -ForegroundColor Green
$desktop = read-host " Enter name of desktop"
write-host ""

#-get current setting
write-host "Current setting for $desktop : " -ForegroundColor Yellow -NoNewline
(get-brokerdesktopgroup -name $desktop).ShutdownDesktopsAfterUse
write-host ""

#-menu to toggle setting or exit
Write-Host "Menu"
Write-Host "-----------------------------------------------"
write-Host " Enter 1 to " -NoNewLine
write-host "enable " -NoNewLine -ForegroundColor Green
write-host "Shutdown Desktop After Use"
write-Host " Enter 2 to " -NoNewLine
write-host "disable " -NoNewLine -ForegroundColor Red
write-host "Shutdown Desktop After Use"
Write-Host "-----------------------------------------------"
Write-Host ""
$choice = Read-Host "Choice (or enter q to quit)"
Write-Host ""

If ($choice -eq "1"){
    Set-BrokerDesktopGroup -Name $desktop -ShutdownDesktopsAfterUse $True
    Write-Host "$desktop Shutdown Desktop After Use: " -ForegroundColor Yellow -NoNewLine
    (get-brokerdesktopgroup -name $desktop).ShutdownDesktopsAfterUse
    Write-Host ""
    Write-Host "Good bye!"
    Exit
}

If ($choice -eq "2"){
    Set-BrokerDesktopGroup -Name $desktop -ShutdownDesktopsAfterUse $False
    Write-Host "$desktop Shutdown Desktop After Use: " -ForegroundColor Yellow -NoNewLine
    (get-brokerdesktopgroup -name $desktop).ShutdownDesktopsAfterUse
    Write-Host ""
    Write-Host "Good bye!"
    Exit
}

If ($choice -eq "q"){Pause
    exit}