$db1 = 'machine01'
$db2 = 'machine02'

$primaryReplica =    Get-DbaAgReplica -ComputerName $db1
$secondaryReplicas = Get-DbaAgReplica -ComputerName $db2
     
$LoginsOnPrimary = (Get-DbaLogin -SqlInstance $db1.Name)
     
$secondaryReplicas | ForEach-Object {
        
    $LoginsOnSecondary = (Get-DbaLogin -SqlInstance $_.Name)
     
    $diff = $LoginsOnPrimary | Where-Object Name -notin ($LoginsOnSecondary.Name)
    if($diff) {
        Copy-DbaLogin -Source $primaryReplica.Name -Destination $_.Name -Login $diff.Nane
    }   
} 
