<#

Author: Michael Wood
Website: virtualizebrief.com
Date: 2024.11.22
Notes: I admit code could be cleaner, yet gets the job done and might help understand whats going on more.

Citrix MCS Machine Creator
Works with both Cloud & On-Prem sites, simpatico. For good measure you do need Citrix Studio (for on-prem site) or Citrix PoshSDK (for cloud site)

Prerequisites
- Run from Windows machine as AD User with permissions to add Computer Objects
- Machine Catalog
- Delivery Group
- Powershell must have ADUC commands

What happens?
- Creates machine account(s) (active directory)
- Creates machine(s) (real VMs on hypervisor)
- Add machine(s) to machine catalog
- Add machine(s) to delivery group
- powers on machine(s)

#>

# set values
$mc = 'machine-catalog'
$dg = 'delivery-group'
$count = '#' # how many you want


# welcome banner
clear-host ""
write-host "Citrix MCS Machine Creator" -foregroundcolor white
write-host ""
write-host "# Selections" -foregroundcolor cyan
write-host "- machine catalog: $mc"
write-host "- delivery group: $dg"
write-host "- new machines: $count"
write-host ""


# get values for machine catalog and scheme
$psUID = (Get-ProvScheme -ProvisioningSchemeName $mc).ProvisioningSchemeUid
$mcUID = (get-brokercatalog -name $mc).uid
$AlreadyCount = (Get-AcctADAccount -IdentityPoolName $mc | Where-Object { $_.State -eq "Available" }).count


# create new accounts
write-host "# Create $count accounts | use $AlreadyCount already available" -foregroundcolor cyan
$SendtoNull = New-AcctADAccount -IdentityPoolName $mc -Count $count
$NewAccounts = (Get-AcctADAccount -IdentityPoolName $mc | Where-Object { $_.State -eq "Available" }).ADAccountName | Sort-Object
$NewMachines = $NewAccounts.Replace('$','')
$Domain = $NewMachine -replace "\\.*$"
$NewMachines
write-host "Resting for 5 seconds..." -ForegroundColor Magenta
write-host ""
start-sleep -s 5 # let things marinate


# create machines
write-host "# Create machine | tries up to 5x then gives up" -foregroundcolor Cyan
ForEach ($NewMachine in $NewMachines) {

    $NewMachineNoDomain = $NewMachine.Replace("$Domain\","")
    $NewMachineSid = ((get-adcomputer $NewMachineNoDomain).sid).value
    $NewMachineAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $NewMachineSid

    If ($NewMachineAccount -eq $null) {
        write-host "$NewMachine" -NoNewline -foregroundcolor Yellow
        write-host "..." -NoNewline
        write-host "Machine account does not exist!" -ForegroundColor Red
        }
    Else {
        write-host "$NewMachine" -NoNewline
        write-host "..." -NoNewline
        $try1 = $null
        $try1 = New-ProvVM -ADAccountName $NewMachine -ProvisioningSchemeUid $psUID
        If ((($try1).TaskState) -eq "FinishedWithErrors") {write-host "1st failed." -nonewline -foregroundcolor red
        $try2 = $null
        $try2 = New-ProvVM -ADAccountName $NewMachine -ProvisioningSchemeUid $psUID
        }
        If ((($try2).TaskState) -eq "FinishedWithErrors") {write-host "2st failed." -nonewline -foregroundcolor red
        $try3 = $null
        $try3 = New-ProvVM -ADAccountName $NewMachine -ProvisioningSchemeUid $psUID
        }
        If ((($try3).TaskState) -eq "FinishedWithErrors") {write-host "3st failed." -nonewline -foregroundcolor red
        $try4 = $null
        $try4 = New-ProvVM -ADAccountName $NewMachine -ProvisioningSchemeUid $psUID
        }
        If ((($try4).TaskState) -eq "FinishedWithErrors") {write-host "4st failed." -nonewline -foregroundcolor red
        $try5 = $null
        $try5 = New-ProvVM -ADAccountName $NewMachine -ProvisioningSchemeUid $psUID
        }
        If ((($try5).TaskState) -eq "FinishedWithErrors") {Write-host "5th giving up! " -nonewline -ForegroundColor red
        }
        write-host "done!" -foregroundcolor green
    }
    start-sleep -s 2

}
write-host "Resting for 5 seconds..." -ForegroundColor Magenta
write-host ""
start-sleep -s 5 # let things marinate


# add machine to machine-catalog
write-host "# Add machine to machine catalog" -foregroundcolor Cyan
ForEach ($NewMachine in $NewMachines) {

    $NewMachineNoDomain = $NewMachine.Replace("$Domain\","")
    $NewMachineSid = ((get-adcomputer $NewMachineNoDomain).sid).value
    $NewMachineAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $NewMachineSid

    If ($NewMachineAccount -eq $null) {
        write-host "$NewMachine" -NoNewline
        write-host "..." -NoNewline
        write-host "Machine account does not exist!" -ForegroundColor Red
        }
    Else {
        write-host "$NewMachine" -NoNewline
        write-host "..." -NoNewline

            $Null = New-BrokerMachine -CatalogUid $mcUID -MachineName $NewMachine

        write-host "done!" -ForegroundColor green
    }
    start-sleep -s 2

    }
write-host "Resting for 5 seconds..." -ForegroundColor Magenta
write-host ""
start-sleep -s 5 # let things marinate


# add to delivery group, power on
write-host "# Add to delivery group & turn on" -foregroundcolor Cyan
ForEach ($NewMachine in $NewMachines) {

    $NewMachineNoDomain = $NewMachine.Replace("$Domain\","")
    $NewMachineSid = ((get-adcomputer $NewMachineNoDomain).sid).value
    $NewMachineAccount = Get-AcctADAccount -IdentityPoolName $mc -ADAccountSid $NewMachineSid

    If ($NewMachineAccount -eq $null) {
        write-host "$NewMachine" -NoNewline
        write-host "..." -NoNewline
        write-host "Machine account does not exist!" -ForegroundColor Red
        }
    Else {
        write-host "$NewMachine" -NoNewline
        write-host "..." -NoNewline

            $Null = Add-BrokerMachine -MachineName $NewMachineSid -DesktopGroup $dg
            start-sleep -s 2
            $Null = New-BrokerHostingPowerAction -MachineName $NewMachineSid -Action TurnOn

        }
    start-sleep -s 2
    write-host "done!" -ForegroundColor green

    }

write-host ""
pause
