clear-host

# get all machine catalog names
$mcs = (get-brokercatalog).catalogname
pause

foreach ($mc in $mcs){

    # get list of machines in machine catalog that do not have a delivery group assigned
    $vdaNoDGs = (get-brokermachine -CatalogName $mc -maxrecordcount 9999 | Where-Object {$_.DesktopGroupName -eq $null}).HostedMachineName
    
    # get name of delivery group from first machine reporting one. since they all use the same one this can be trusted
    $dg = (get-brokermachine -CatalogName $mc -maxrecordcount 9999  | Where-Object {$_.DesktopGroupName -ne $null}).DesktopGroupName | select-object -first 1
    
    # for each machine not assigned delivery group add to the delivery group found by machine in machine catalog from above
    foreach ($vdaNoDG in $vdaNoDGs){

        # if delivery group is not found for any machines don't attempt to add, cause nothing to add to
        if ($dg -eq $null){write-host "$mc has no machines assigned to delivery group!" -foreground red}
        
        # add to delivery group
        else {add-brokermachine -machinename vanclinic\$vdaNoDg -DesktopGroup $dg}

    }

}