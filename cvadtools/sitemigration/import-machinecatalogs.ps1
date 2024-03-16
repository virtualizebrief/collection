#---automatic

$start = (Get-ChildItem -Path C:\your\path\names\).Name
$machineCatalogs = $start.Trim(".csv")

forEach ($machineCatalog in $machineCatalogs){

    $settings = Import-Csv "C:\Support\Cloud\machine-catalogs\names\$machineCatalog.csv"

    $MachinesArePhysical = ($settings).MachinesArePhysical
    if ($MachinesArePhysical -eq "False") {$MachinesArePhysical = 0}
    if ($MachinesArePhysical -eq "True") {$MachinesArePhysical = 1}

        write-host "$machineCatalog" -ForegroundColor yellow -NoNewline

            New-BrokerCatalog -Name $machineCatalog -AllocationType ($settings).AllocationType -PersistUserChanges Discard -ProvisioningType Manual -SessionSupport ($settings).SessionSupport -MachinesArePhysical $MachinesArePhysical 

        write-host " done!" -ForegroundColor green

}
