#-you set these
$path = "C:\Support\Cloud\migrate-apps\Icons"

#-make happen
$apps = (Get-BrokerApplication).Name
ForEach ($app in $apps) {

  $noSpaceApp = $App.replace(' ','')
  $NoSpaceAppUnderscore = $noSpaceApp + '_'
  $iconName = (Get-ChildItem $Folder).Name -like "$NoSpaceAppUnderscore*"
  $iconFull = $Folder + '\' + $iconName
  $iconFull
  $icon=Get-BrokerIcon -FileName $iconFull |New-BrokerIcon | Select-Object Uid

  #-actually do something
  Get-BrokerApplication -name $app | Set-BrokerApplication -IconUid $icon.Uid

}

Pause
exit
