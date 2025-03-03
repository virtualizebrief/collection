# You config | Source & destination vCenter info
$sourceVC      = "source.domain.com"
$sourceFolder  = "sourceFolder"
$destVC        = "dest.domain.com"
$destFolder    = "destFolder"
$destDatastore = "destDatastore"
$destCluster   = "destCluster"

# Username & password
$vUser     = Read-Host "Enter vCenter username"
$vPassword = Read-Host "Enter vCenter password"  -AsSecureString
$vPasswordPlain =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($vPassword))

# Get VMs from soure folder & destination settings
if (-not (Get-Module -ListAvailable -Name VMware.PowerCLI)) {
    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {Set-PSRepository -Name PSGallery -InstallationPolicy Trusted}
    Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force -ErrorAction Stop
}
$noShow  = Connect-VIServer -Server $sourceVC -User $vUser -Password $vPasswordPlain -ErrorAction Stop
$vmNames = get-vm -server $sourceVC -location $sourceFolder | sort-object name
$noShow  = Disconnect-VIServer -Server * -Force -Confirm:$false

# Output list of VMs to copy
clear-host
write-host "# List of VMs to copy" -ForegroundColor Cyan
write-host "---------------------"
($vmNames).name
write-host ""
pause
write-host ""
write-host "# Results" -ForegroundColor Cyan
write-host "---------------------"

# Copy VMs
$date = Get-Date -format "yyyyMMdd"
foreach ($vmName in $vmNames) {

    # Source vCenter things
    $noShow   = Connect-VIServer -Server $sourceVC -User $vUser -Password $vPasswordPlain -ErrorAction Stop   
    $vm       = Get-VM -Name $vmName
    # $noShow = Disconnect-VIServer -Server * -Force -Confirm:$false
   
    # Destination vCenter things
    $noShow         = Connect-VIServer -Server $destVC -User $vUser -Password $vPasswordPlain -ErrorAction Stop
    $destDS         = Get-Datastore -Name $destDatastore -ErrorAction Stop
    $destClusterObj = Get-Cluster -Name $destCluster -ErrorAction Stop
    $destHost       = Get-VMHost -Location $destClusterObj | get-random
    
    # Clone the VM to the destination
    $lineNumber = (($vmNames).name | select-string $vm).LineNumber
    if ($lineNumber -lt "10") {$lineNumber = "0" + $lineNumber}
    $totalVMs = ($vmNames).count
    Write-Host "$lineNumber/$totalVMs " -NoNewline
    write-host "$vm" -ForegroundColor Yellow -NoNewline
    write-host " to " -NoNewline
    write-host "$destVC" -ForegroundColor Yellow -NoNewline
    write-host "..." -NoNewline
    $measureTime = measure-command {
         $newVM  = New-VM -VM $vm `
                   -Name ($vmName + "_" + $date) `
                   -VMHost $destHost `
                   -Datastore $destDS -ErrorAction SilentlyContinue
    }
    $vmState = Get-VM -Name $vm.Name
    while (!($vmState.PowerState -eq "PoweredOff")) {
        Start-Sleep -Seconds 5
        $vmState = Get-VM -Name $vm.Name
    }
    $noShow = Move-VM -VM ($vmName + "_" + $date) -InventoryLocation $destFolder
    $noShow = Disconnect-VIServer -Server * -Force -Confirm:$false
    $hour = ($measuretime).hours
    $minute = ($measuretime).minutes
    Write-Host "done! " -ForegroundColor Green -NoNewline
    write-host "$hour`:$minute [Hours:Minutes]"

}

# Good-bye
write-host ""
pause
