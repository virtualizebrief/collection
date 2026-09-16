$users = @(
"newuser01" 
)
$adgroups = @(
"group01"
"group02"
)
$ou = "OU=Users,OU=AutoLogin,DC=MyDomian,DC=com"
$password = Read-Host -AsSecureString "Enter Password"

Import-Module ActiveDirectory

foreach ($user in $users) {

write-host "$user " -NoNewline

New-ADUser -Name $user `
    -SamAccountName $user `
    -UserPrincipalName "$user@lcmchealth.org" `
    -Path $ou `
    -AccountPassword $password `
    -Enabled $true

foreach ($adgroup in $adgroups) {
    Add-ADGroupMember -Identity $adgroup -Members $user
}

write-host "done!" -ForegroundColor Green

}

