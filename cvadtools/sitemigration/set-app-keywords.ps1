#--- User configured options
Clear-Host
Write-Host "-----Set Keywords-----"
Write-Host ""
    # $DeliveryGroup = Read-Host "Enter delivery group"
    $DeliveryGroups = (Get-BrokerDesktopGroup).name
    $Type = Read-Host "Enter app type: PublishedContent or HostedOnDesktop"
    $Keywords = Read-Host "Enter Keywords"
Write-Host ""

#--- Do the magic
ForEach ($DeliveryGroup in $DeliveryGroups) {

    $UUID = (Get-BrokerDesktopGroup -Name $DeliveryGroup).uuid
    $Apps = (Get-BrokerApplication -AssociatedDesktopGroupUUID $UUID -ApplicationType $Type).name

    Write-Host "Processing..." -ForegroundColor Yellow -NoNewline

    ForEach ($App in $Apps){
        Set-BrokerApplication -Name $App -Description $Keywords
    }

    Write-Host "Done!" -ForegroundColor Green
    write-Host ""

}

Pause
exit
