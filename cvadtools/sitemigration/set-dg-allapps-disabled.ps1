#---delivery group name
$dg = "YourDeliveryGroupName"

#---do the thing
$UUID = (Get-BrokerDesktopGroup -Name $dg).uid
$apps = (Get-BrokerApplication -DesktopGroupUid $UUID).Name

Write-Host "DG: $deliveryGroup" -ForegroundColor Cyan
ForEach ($app in $apps){

Set-BrokerApplication -Name $app -Enabled $false
Write-Host "disabled " -NoNewLine -ForegroundColor yellow
Write-Host "$app"

}

Pause
exit
