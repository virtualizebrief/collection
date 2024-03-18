"C:\Program Files\VMware\VMware View\Server\extras\PowerShell\add-snapin.ps1"
Clear

Write-Host "Please provide your login information..." -ForegroundColor Cyan
Write-Host ""
$UserName = Read-Host "Enter Your User Name"
$Password = Read-Host "Enter Your Password"
$domain = Read-Host "Enter your domain"
write-Host ""

$NameEntitlement = Read-Host "Global Entitlement Name for Desktop Pool!"
$defaultProtocol = Read-Host "Default Protocol [BLAST, PCOIP, RDP]"

#Create
lmvutil --authAs $UserName --authDomain $domain --authPassword $Password --createGlobalEntitlement --entitlementName $NameEntitlement --scope ANY --defaultProtocol $defaultProtocol --isFloating

Pause