#-----options need to configure
$templateMd = "\\pathtofile\notinsite\golden-images.template"
$processingMd = "\\pathtofile\notinsite\golden-images.processing"
$productionMd = "\\pathtofile\site\golden-images.md"

#------start doing soemthing

$blue = "deliverycontroller.domain.com"
$date = get-date -format "yyyy.MM.dd @ hh:mm tt"
copy-item $templateMd $processingMd -force

$MachineCatalogs = (Get-ProvScheme -AdminAddress $site).ProvisioningSchemeName

Foreach ($MachineCatalog in $MachineCatalogs) {

$MasterVM = (Get-ProvScheme -AdminAddress $site -ProvisioningSchemeName $MachineCatalog | Select MasterImageVM,@{n='MasterVM';e={$_.MasterImageVM -replace 'XDHyp:\\HostingUnits\\[^\\]+\\([^\\]+)\.vm\\.*$' , '$1' }}).MasterVM
$Snapshot = (Get-ProvScheme -AdminAddress $site -ProvisioningSchemeName $MachineCatalog | Select Snapshot,@{n='Snap';e={$_.MasterImageVM -replace '^.*\\([^\\]+)\.snapshot$' , '$1' }}).Snap

$MachineCatalog
$MasterVM
$Snapshot

# create markdown entry
    $entry = "`n " + $MachineCatalog + " | " + $MasterVM + " | " + $Snapshot
    $entry = $entry + "end of Golden Image report"

# add to report
    ((Get-Content -path $processingMd -Raw) -replace 'end of Golden Image report', $entry) | Set-Content -Path $processingMd
    start-sleep -s 1
    write-host "done" -foregroundcolor green

}

((Get-Content -path $processingMd -Raw) -replace 'end of Golden Image report', '

[!badge variant="success" icon=":thumbsup:" text="End of Golden Image report"]') | Set-Content -Path $processingMd
start-sleep -s 2
((Get-Content -path $processingMd -Raw) -replace 'replaceDate', $Date) | Set-Content -Path $processingMd

# put processing file into production
copy-item $processingMd $productionMd -force

# EOF
