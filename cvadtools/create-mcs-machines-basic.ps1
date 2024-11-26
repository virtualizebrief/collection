# set values
$mc = 'machine-catalog'
$dg = 'delivery-group'
$count = '5' # how many machines

# get values for machine catalog, scheme & remove unused accounts
$psUID = ((Get-ProvScheme -ProvisioningSchemeName $mc).ProvisioningSchemeUid).Guid
$mcUID = (get-brokercatalog -name $mc).uid
$ExtraAccounts = (Get-AcctADAccount -IdentityPoolName $mc | Where-Object { $_.State -eq "Available" }).ADAcountSid
foreach ($ExtraAccount in $ExtraAccounts) {Remove-AcctADAccount -IdentityPoolName $mc -ADAccountSid $ExtraAccount}

# create new accounts
    write-host "# New machines" -ForegroundColor cyan
$NewAccounts = ((New-AcctADAccount -IdentityPoolName $mc -Count $count).SuccessfulAccounts).ADAccountName
$NewMachines = $NewAccounts.Replace('$','')
$NewMachines
$Domains = $NewMachines -replace "\\.*$"
$Domain = $Domains | Select-Object -First 1
    write-host ""

# create machines, try 5 times then give up
    write-host "# Created machines" -ForegroundColor green
$taskId = (New-ProvVM -ADAccountName $NewMachines -ProvisioningSchemeUid $psUID).taskId
$CreatedVMs = ((Get-ProvTask -TaskID $taskId).CreatedVirtualMachines).VMName
    $CreatedVMs
    write-host ""
    write-host "# Failed machines" -ForegroundColor red
$FailedVMs = ((Get-ProvTask -TaskID $taskId).FailedVirtualMachines).VMName
    $FailedVMs
    write-host ""

# add to machine catalog, delivery group, power on
foreach ($CreatedVM in $CreatedVMs) {
    $CreatedVMNoDomain = $CreatedVM.Replace("$Domain\","")
    $CreatedVMSid = ((get-adcomputer $CreatedVMNoDomain).sid).value
    $CreatedVMAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $CreatedVMSid
    $SendtoNull = New-BrokerMachine -CatalogUid $mcUID -MachineName $CreatedVMSid
    $SendtoNull = Add-BrokerMachine -MachineName $CreatedVMSid -DesktopGroup $dg
    $SendtoNull = New-BrokerHostingPowerAction -MachineName $CreatedVMSid -Action TurnOn
}

pause
