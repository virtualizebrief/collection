Add-PSSnapin Citrix*

Clear-Host
Write-Host ""
Write-Host "Citrix Sessions with Application Not Running..." -ForegroundColor Yellow
Get-BrokerSession -MaxRecordCount 1000 -AppState NoApps | Select BrokeringUserName,DesktopGroupName,LaunchedViaPublishedName,AppState
Write-Host "-----------------                 ----------------                  ------------------------                                 --------"

Write-Host ""
Write-Host ""
Write-Host "Results..." -ForegroundColor Yellow -NoNewLine
Write-Host "Session count: " -ForegroundColor Green -NoNewLine
(Get-BrokerSession -MaxRecordCount 1000 -AppState NoApps).count

Write-Host ""
Write-Host "Would you like to logoff all of these sessions?" -ForegroundColor Yellow
$Answer = Read-Host "Type yes or q to quit"

If ($Answer -eq "Yes"){
#-actually does something
Get-BrokerSession -AppState NoApps | Stop-BrokerSession
Write-Host ""
Write-Host "Processing..." -ForegroundColor Yellow -NoNewLine
Write-Host "Done!" -ForegroundColor Green
Write-Host ""
}

Write-Host ""
pause
