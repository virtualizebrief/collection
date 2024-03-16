clear-host
write-host "Export all machine catalog list of machines" -ForegroundColor Cyan
write-host ""

$machineCatalogs = (Get-BrokerCatalog).name
$csv = \\your\path\machine-catalogs\$machineCatalog.csv

forEach ($machineCatalog in $machineCatalogs) {

  Get-BrokerMachine -CatalogName $machineCatalog -MaxRecordCount 5000 |
  Select-Object -Property MachineName,HostedMachineId,HostingServerName | Export-Csv $csv -Force

}

write-host "done!"
pause
exit
