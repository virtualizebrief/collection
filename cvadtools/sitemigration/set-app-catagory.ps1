#--- User configured options
Clear-Host
Write-Host "-----Set App Category-----"
Write-Host ""
    $Apps = Get-Content .\apps.txt
    $Category = Read-Host "Enter Category"
Write-Host ""


#--- Do the magic
Write-Host "Processing..." -ForegroundColor Yellow -NoNewline
ForEach ($App in $Apps){

    Write-Host "$App " -NoNewline -ForegroundColor Yellow
    Set-BrokerApplication -Name $App -ClientFolder $Category
    Write-Host "done!" -NoNewline -ForegroundColor Green

}

Write-Host "Done!" -ForegroundColor Green
write-Host ""

Pause
exit
