# set values
$mc = 'machine-catalog-name'
$dg = 'delivery-group-name'
$count = '#'

# get values
$psUID = ((Get-ProvScheme -ProvisioningSchemeName $mc).ProvisioningSchemeUid).guid
$mcUID = (get-brokercatalog -name $mc).uid

# create new accounts and get new machine names
New-AcctADAccount -IdentityPoolName $mc -Count $count
$NewAccounts = (Get-AcctADAccount -IdentityPoolName $mc | Where-Object {$_.State -eq "Available"}).ADAccountName | Sort-Object
$NewMachines = $NewAccounts.Replace('$','')

# create machine, add to machine catalog, add to delivery group, power on
ForEach ($NewMachine in $NewMachines) {

    New-ProvVM -ADAccountName $NewMachines -ProvisioningSchemeUid $psUID
    New-BrokerMachine -CatalogUid $NewMachine -MachineName $NewMachine
    Add-BrokerMachine $NewMachine -DesktopGroup $dg
    New-BrokerHostingPowerAction -MachineName $NewMachine -Action TurnOn

}
