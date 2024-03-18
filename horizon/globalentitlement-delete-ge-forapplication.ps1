"C:\Program Files\VMware\VMware View\Server\extras\PowerShell\add-snapin.ps1"
Clear

Write-Host ""
Write-Host "!DELETE Global Entitlement for Application!" -ForegroundColor Red
Write-Host "Please provide your login information..." -ForegroundColor Cyan
Write-Host ""
$UserName = Read-Host "Enter Your User Name"
$Password = Read-Host "Enter Your Password"
$domain = Read-Host "Enter your domain"
write-Host ""
$NameEntitlement = Read-Host "!Global Entitlement to Delete for Application!"

Write-Host
Write-Host "If your user press enter!"
Pause

#Delete
lmvutil --authAs $UserName --authDomain $domain --authPassword $Password --deleteGlobalApplicationEntitlement --entitlementName $NameEntitlement
Pause