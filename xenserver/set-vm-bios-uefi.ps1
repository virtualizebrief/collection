<#

Set bios to UEFI for XenServer VM. I've heard you need to do this before first powring the VM on but might work still

#>

# connect to xenserver
$xenServer = "xen01.domain.com"
$xenSDK = "\\XenServer-SDK\XenServerPowerShell\PowerShell_51\XenServerPSModule"
$modulePath = "C:\Program Files\WindowsPowerShell\Modules"
$HVMBootParams = @{ "firmware" = "uefi";"order" = "dc"}
    Import-Module -Name $xenSDK
    Connect-XenServer -Server $XenServer -UserName root -SetDefaultSession -NoWarnCertificates

# set bios to uefi
clear-host
write-host "Change bios to UEFI" -ForegroundColor Cyan
    $vmName = read-host "Enter VM name"
write-host "Before update" -ForegroundColor yellow
    get-xenvm -name $vmName | select HVM_boot_params

# do thing
write-host "After update" -ForegroundColor green
    set-xenvm -name $vmName -HVMBootParams $HVMBootParams
    get-xenvm -name $vmName | select HVM_boot_params

pause
