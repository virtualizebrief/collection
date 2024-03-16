#---delivery group name
$deliveryGroup = "YourDeliveryGroupName"

#---do the thing
$UUID = (Get-BrokerDesktopGroup -PublishedName $deliveryGroup).uuid
$apps = (Get-BrokerApplication -AssociatedDesktopGroupUUID $UUID).Name

Write-Host "DG: $deliveryGroup" -ForegroundColor Cyan
ForEach ($app in $apps){

Set-BrokerApplication -Name $app -Enabled $true
Write-Host "enabled " -NoNewLine -ForegroundColor green
Write-Host "$app"

}

Pause
exit
