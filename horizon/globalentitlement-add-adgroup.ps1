"C:\Program Files\VMware\VMware View\Server\extras\PowerShell\add-snapin.ps1"
Clear

Write-Host ""
$NameGlobal = Read-Host "Global Entitlement Name"
$NameADGroup = Read-Host "AD Group Name [Format: NT-Childrens\GroupName]"
$UserName = Read-Host "Enter Your User Name"
$Password = Read-Host "Enter Your Password"
Write-Host ""

lmvutil --authAs $UserName --authDomain NT-Childrens --authPassword $Password --addGroupEntitlement --groupName $NameADGroup --entitlementName $NameGlobal

Pause