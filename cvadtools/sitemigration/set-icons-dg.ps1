Clear-Host
Write-Host "-----Set App Icons-----" -ForegroundColor Cyan
Write-Host ""

#--- Get Apps
$DeliveryGroup = Read-Host "Enter delivery group"
$UUID = (Get-BrokerDesktopGroup -Name $DeliveryGroup).uuid
$Apps = (Get-BrokerApplication -AssociatedDesktopGroupUUID $UUID).PublishedName

#--- Get Icons
Write-Host "Hint: \\epic-dc1-fs01\root\Citrix\Icons\FromSelfService" -ForegroundColor Yellow
$Folder = Read-Host "Enter path to icon files"
Write-Host ""
    $Continue = Read-Host "Press enter to continue or Q to exit"
    If ($Continue -eq "q"){exit}
Write-Host ""

#--- Set icon
Foreach ($App in $Apps){

  $noSpaceApp = $App.replace(' ','')
  $NoSpaceAppUnderscore = $noSpaceApp + '_'
  $iconName = (Get-ChildItem $Folder).Name -like "$NoSpaceAppUnderscore*"
  $iconFull = $Folder + '\' + $iconName
  $iconFull
  $icon = Get-BrokerIcon -FileName $iconFull | New-BrokerIcon | Select-Object Uid

  #-actually do something
  Get-BrokerApplication -name $App | Set-BrokerApplication -IconUid $icon.Uid

}

Pause
exit
