#--- User configured options
$path = "C:\Support\Cloud\client-folders"

Clear-Host
Write-Host "-----Set App Category-----"
Write-Host ""
Write-Host "Reading .txt files in $path"
$ClientFolders = (Get-ChildItem -Path $path).Name
$ClientFolders = $ClientFolders.Replace(".txt","")

#--- Do the magic
Write-Host "Processing..." -ForegroundColor Yellow
ForEach ($ClientFolder in $ClientFolders){

    $Apps = Get-Content "$path\$ClientFolder.txt"
    ForEach ($App in $Apps){
        
        Write-Host "$App " -NoNewline -ForegroundColor Yellow
        Set-BrokerApplication -Name $App -ClientFolder $ClientFolder
        Write-Host "done!" -ForegroundColor Green

    }

}

Write-Host ""
Write-Host "Completed!" -ForegroundColor cyan
write-Host ""
Pause
exit
