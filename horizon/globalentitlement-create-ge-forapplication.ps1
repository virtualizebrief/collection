"C:\Program Files\VMware\VMware View\Server\extras\PowerShell\add-snapin.ps1"
Clear

Write-Host "Please provide your login information..." -ForegroundColor Cyan
Write-Host ""
$UserName = Read-Host "Enter Your User Name"
$Password = Read-Host "Enter Your Password"
$domain = Read-Host "Enter your domain"
write-Host ""

$NameEntitlement = Read-Host "Global Entitlement Name"
$defaultProtocol = Read-Host "Default Protocol [BLAST, PCOIP, RDP]"

#Create
lmvutil --authAs $UserName --authDomain $domain --authPassword $Password --createGlobalApplicationEntitlement --entitlementName $NameEntitlement --scope ANY --defaultProtocol $defaultProtocol --htmlAccess --multipleSessionAutoClean --verbose

Pause