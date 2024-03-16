$machineCatalogs = (Get-BrokerCatalog).name
forEach ($machineCatalog in $machineCatalogs){

get-brokercatalog -name $machineCatalog |
 select-object -property name,
   sessionsupport,
    allocationtype,
       machinesarephysical | export-csv \\ctx-dir-1\c$\Support\Cloud\machine-catalogs\names\$machineCatalog.csv -Force

}
