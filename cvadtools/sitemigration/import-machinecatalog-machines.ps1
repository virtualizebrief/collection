clear-host
write-host "Import list of machines to machine catalog" -ForegroundColor Cyan
write-host ""

#----ask
$machineCatalog = read-host "enter machine catalog"
write-host ""

#----setup
$catalogUid = (Get-BrokerCatalog -Name $machineCatalog).Uid
Import-Csv "c:\support\cloud\machine-catalogs\machines\$machineCatalog.csv" | ForEach-Object {

$hypervisorConnectionUid = (Get-BrokerHypervisorConnection -Name $($_.HostingServerName)).Uid

write-host "$($_.MachineName)" -ForegroundColor yellow -NoNewline
New-BrokerMachine -CatalogUid $catalogUid -MachineName $($_.MachineName) -HostedMachineId $($_.HostedMachineId) -HypervisorConnectionUid $hypervisorConnectionUid
write-host " done!" -ForegroundColor green

}

move-item -path "c:\support\cloud\machine-catalogs\machines\$machineCatalog.csv" -Destination "C:\Support\Cloud\machine-catalogs\machines\_processed"

write-host ""
write-host "all machines added. good bye!" -ForegroundColor green
pause
exit
