set-location C:\Support\Apps\Powertools\CitrixApp\WindowsUpdate
$computers = Get-Content .\computers.txt

Clear-Host
Write-Host "Restart computers. 10 minutes between each restart."
Write-Host ""
Write-Host "Selected computers" -ForegroundColor Cyan
$computers
Write-Host "Enter to continue or CTRL+C to quit" -ForegroundColor Yellow
Read-Host
Write-Host "Results"

Foreach ($computer in $computers){

    Write-Host "Sent restart to: " -ForegroundColor Cyan -NoNewLine
    Write-Host "$computer" -ForegroundColor Yellow
    Get-Date

        Restart-Computer -ComputerName $computer -Force -Wait

    Write-Host ""

Start-Sleep -s 600

}

Write-Host ""
Write-Host "done!"
pause
exit

