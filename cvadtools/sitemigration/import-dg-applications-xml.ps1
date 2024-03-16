#--- User configured options
Clear-Host
Write-Host "-----Import Citrix Applications-----"
Write-Host ""
    $DG = Read-Host "Enter delivery group"
    $File = Read-Host "file of XML app list"
    $Apps = Import-Clixml "C:\Support\Cloud\migrate-apps\$File"
Write-Host ""
    $Continue = Read-Host "Press enter to continue or Q to exit"
    If ($Continue -eq "q"){exit}
Write-Host ""

#--- Do the magic
ForEach ($app in $apps){

If ($app.ApplicationType -like "HostedOnDesktop"){
New-BrokerApplication `
 -ApplicationType "HostedOnDesktop" `
 -Name $app.PublishedName `
 -BrowserName $app.PublishedName `
 -Description $app.Description `
 -CommandLineExecutable $app.CommandLineExecutable `
 -CommandLineArguments $app.CommandLineArguments `
 -WorkingDirectory $app.WorkingDirectory `
 -Enabled $app.Enabled `
 -UserFilterEnabled $app.UserFilterEnabled `
 -DesktopGroup $dg
}

If ($app.ApplicationType -like "PublishedContent"){
New-BrokerApplication `
 -ApplicationType "PublishedContent" `
 -Name $app.PublishedName `
 -BrowserName $app.PublishedName `
 -Description $app.Description `
 -CommandLineExecutable $app.CommandLineExecutable `
 -Enabled $app.Enabled `
 -UserFilterEnabled $app.UserFilterEnabled `
 -DesktopGroup $dg
}

$users = $app.AssociatedUserNames
ForEach ($user in $users){ 
 Add-BrokerUser -Name "$user" -Application $app.PublishedName
}

}

Write-Host ""
Write-Host "All done!" -ForegroundColor Green
Pause
exit
