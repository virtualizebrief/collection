$db1 = 'machine01'
$db2 = 'machine02'

Set-DbatoolsInsecureConnection
$primaryReplica    = Get-DbaAgReplica -SqlInstance $db1 | where-object {$_.role -eq 'primary'}
$secondaryReplica = Get-DbaAgReplica -SqlInstance $db2 | where-object {$_.role -eq 'secondary'} 
$LoginsOnPrimarys   = (Get-DbaLogin -SqlInstance $db1).name
$LoginsOnSecondarys = (Get-DbaLogin -SqlInstance $db2).name
     
foreach ($LoginsOnPrimary in $LoginsOnPrimarys) {

    $found = (compare-object $LoginsOnPrimary $LoginsOnSecondarys -IncludeEqual | where-object {$_.SideIndicator -eq '=='}).InputObject
    if ($found -eq $null) {

        write-host "$LoginsOnPrimary being added to $secondaryReplica" -ForegroundColor yellow -NoNewline
        Copy-DbaLogin -Source $primaryReplica -Destination $secondaryReplica -Login $LoginsOnPrimary -force
        write-host " done!" -ForegroundColor green
    
    }   

} 
