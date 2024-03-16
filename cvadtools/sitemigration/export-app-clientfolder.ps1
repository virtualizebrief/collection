Clear-Host
$Path = Read-Host "Enter path to export client folder lists"
$ClientFolders = (Get-BrokerApplication).ClientFolder
$ClientFolders = $ClientFolders | select -Unique

ForEach ($ClientFolder in $ClientFolders){
    $apps = (Get-BrokerApplication -ClientFolder $ClientFolder).PublishedName
    ForEach ($app in $apps){
        Add-Content -Path $Path\$ClientFolder.txt -Value $app   
    }   
}
