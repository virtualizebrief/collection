<#

---
title: Citrix MCS Machine Creator
author: Michael Wood
date: 2024.11.22
link: virtualizebrief.com
avatar: https://avatars.githubusercontent.com/u/153381859
---

# Citrix MCS Machine Creator
Works with both Cloud & On-Prem sites, simpatico. For good measure you do need Citrix Studio (for on-prem site) or Citrix PoshSDK (for cloud site)

# Prerequisites
- Run from Windows machine as AD User with permissions to add Computer Objects
- Machine Catalog
- Delivery Group
- Powershell must have ADUC commands

# What happens?
- Creates machine account(s) (active directory)
- Creates machine(s) (real VMs on hypervisor)
- Add machine(s) to machine catalog
- Add machine(s) to delivery group
- powers on machine(s)

#>

function timer {
$duration = 300
$endTime = (Get-Date).AddSeconds($duration)
while ((Get-Date) -lt $endTime) {
    # Calculate the percentage complete
    $percentComplete = 100 - [int](((($endTime - (Get-Date)).TotalSeconds) / $duration) * 100)

    # Display the progress bar
    Write-Progress -Activity "Pausing for AD Accounts to register" -Status "Time remaining: $((($endTime - (Get-Date)).TotalSeconds).ToString('F0')) seconds" -PercentComplete $percentComplete

    # Sleep for 1 second
    Start-Sleep -Seconds 1
    }
}

clear-host

# set values
$mc = 'LCMCDesktop-E'
$dg = 'LCMC Desktop AWS'
$count = '10'

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

timer

# create machines
    write-host "# Attempt 1 of 3" -ForegroundColor cyan
$taskId = (New-ProvVM -ADAccountName $NewMachines -ProvisioningSchemeUid $psUID).taskId

    write-host "Created machines: " -ForegroundColor green -NoNewline
$CreatedVMs = $null #empty value to start with
$CreatedVMs = ((Get-ProvTask -TaskID $taskId).CreatedVirtualMachines).VMName
    ($CreatedVMs).count
    write-host "Failed machines : " -ForegroundColor red -NoNewline
$FailedVMs = $null #empty value to start with
$FailedVMs = ((Get-ProvTask -TaskID $taskId).FailedVirtualMachines).VMName
    ($FailedVMs).count

If ($CreatedVMs -eq $null) {}
Else { 

# add to machine catalog, delivery group, power on
foreach ($CreatedVM in $CreatedVMs) {
    $CreatedVMNoDomain = $CreatedVM.Replace("$Domain\","")
    $CreatedVMSid = ((get-adcomputer $CreatedVMNoDomain).sid).value 
    $CreatedVMAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $CreatedVMSid
    $SendtoNull = New-BrokerMachine -CatalogUid $mcUID -MachineName $CreatedVMSid
    $SendtoNull = Add-BrokerMachine -MachineName $CreatedVMSid -DesktopGroup $dg
    $SendtoNull = New-BrokerHostingPowerAction -MachineName $CreatedVMSid -Action TurnOn
    }
}

if ((($FailedVMs).count) -gt 0) {

#-Second try
timer
    write-host ""

# create machines that failed, one more try!
    write-host "# Attempt 2 of 3" -ForegroundColor cyan
$FailedDomainVMs = $FailedVMs | ForEach-Object { "LCMCHEALTH\" + $_ }
$taskId = (New-ProvVM -ADAccountName $FailedDomainVMs -ProvisioningSchemeUid $psUID).taskId

    write-host "Created machines: " -ForegroundColor green -NoNewline
$CreatedVMs = $null #empty value to start with
$CreatedVMs = ((Get-ProvTask -TaskID $taskId).CreatedVirtualMachines).VMName
    ($CreatedVMs).count

    write-host "Failed machines : " -ForegroundColor red -NoNewline
$FailedVMs = $null #empty value to start with
$FailedVMs = ((Get-ProvTask -TaskID $taskId).FailedVirtualMachines).VMName
    ($FailedVMs).count

If ($CreatedVMs -eq $null) {}
Else { 

# add to machine catalog, delivery group, power on
foreach ($CreatedVM in $CreatedVMs) {
    $CreatedVMNoDomain = $CreatedVM.Replace("$Domain\","")
    $CreatedVMSid = ((get-adcomputer $CreatedVMNoDomain).sid).value 
    $CreatedVMAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $CreatedVMSid
    $SendtoNull = New-BrokerMachine -CatalogUid $mcUID -MachineName $CreatedVMSid
    $SendtoNull = Add-BrokerMachine -MachineName $CreatedVMSid -DesktopGroup $dg
    $SendtoNull = New-BrokerHostingPowerAction -MachineName $CreatedVMSid -Action TurnOn
    }
}

}

if ((($FailedVMs).count) -gt 0) {
#-Third try
timer
    write-host ""

# create machines that failed, one more try!
    write-host "# Attempt 3 of 3" -ForegroundColor cyan
$FailedDomainVMs = $FailedVMs | ForEach-Object { "LCMCHEALTH\" + $_ }
$taskId = (New-ProvVM -ADAccountName $FailedDomainVMs -ProvisioningSchemeUid $psUID).taskId

    write-host "Created machines: " -ForegroundColor green -NoNewline
$CreatedVMs = $null #empty value to start with
$CreatedVMs = ((Get-ProvTask -TaskID $taskId).CreatedVirtualMachines).VMName
    ($CreatedVMs).count

    write-host "Failed machines : " -ForegroundColor red -NoNewline
$FailedVMs = $null #empty value to start with
$FailedVMs = ((Get-ProvTask -TaskID $taskId).FailedVirtualMachines).VMName
    ($FailedVMs).count
    write-host ""

If ($CreatedVMs -eq $null) {}
Else { 

# add to machine catalog, delivery group, power on
foreach ($CreatedVM in $CreatedVMs) {
    $CreatedVMNoDomain = $CreatedVM.Replace("$Domain\","")
    $CreatedVMSid = ((get-adcomputer $CreatedVMNoDomain).sid).value 
    $CreatedVMAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $CreatedVMSid
    $SendtoNull = New-BrokerMachine -CatalogUid $mcUID -MachineName $CreatedVMSid
    $SendtoNull = Add-BrokerMachine -MachineName $CreatedVMSid -DesktopGroup $dg
    $SendtoNull = New-BrokerHostingPowerAction -MachineName $CreatedVMSid -Action TurnOn
    }
}

}

write-host ""
pause
