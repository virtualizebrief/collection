#--- User configured options
Clear-Host
Write-Host "-----Export Citrix Applications-----"
Write-Host ""
    $DeliveryGroup = Read-Host "Enter delivery group"
    $LogDate = Get-Date -format "yyyyMMdd_hhmmss"
    $Path = (Get-Item .).FullName
    $LogFile = "$Path\$DeliveryGroup-$LogDate.xml"

#--- Do the magic
Write-Host "Processing..." -ForegroundColor Yellow -NoNewline
    $UUID = (Get-BrokerDesktopGroup -Name $DeliveryGroup).uuid
    Get-BrokerApplication -AssociatedDesktopGroupUUID $UUID | Export-CliXML $LogFile
Write-Host "Done!" -ForegroundColor Green
Write-Host ""
Write-Host "XML file created: " -NoNewLine
Write-Host "$LogFile" -ForegroundColor Cyan

Pause
exit
