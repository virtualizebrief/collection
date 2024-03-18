"C:\Program Files\VMware\VMware View\Server\extras\PowerShell\add-snapin.ps1"
Clear

Write-Host ""
$NameGlobal = Read-Host "Global Entitlement Name"
$NamePool = Read-Host "Application or Desktop Pool Name to add"
$UserName = Read-Host "Enter Your User Name"
$Password = Read-Host "Enter Your Password"
$domain = Read-Host "Enter your domain"
Write-Host ""

lmvutil --authAs $UserName --authDomain $domain --authPassword $Password --addPoolAssociation --entitlementName $NameGlobal --poolId $NamePool

Pause
