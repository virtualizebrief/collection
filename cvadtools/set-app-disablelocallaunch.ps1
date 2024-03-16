#------thing-----

Clear-Host
Write-Host "------- " -NoNewLine
Write-Host "Citrix PowerTools" -NoNewLine
Write-Host " -------"
Write-Host ""
Write-Host "Get application setting for local launch" -ForegroundColor Cyan
Write-Host ""
$app = Read-Host "Enter application name"
Write-Host ""


Clear-Host
Write-Host "------- " -NoNewLine
Write-Host "Citrix PowerTools" -NoNewLine
Write-Host " -------"
Write-Host ""
Write-Host "Get application setting for local launch" -ForegroundColor Cyan
Write-Host ""
Write-Host "Selected application: " -NoNewLine
Write-Host "$app" -ForegroundColor Yellow
Write-Host "Is local launch disabled? " -NoNewLine -ForegroundColor Yellow
(get-brokerApplication -Name $app).LocalLaunchDisabled
Write-Host ""

Write-Host "Menu"
Write-Host "---------------------------------------------------------"
write-Host "Enter 1 to enable local launch"
Write-Host "Enter 2 to disable local launch"
Write-Host "Enter L to get a list of all disabled local launch apps"
Write-Host "---------------------------------------------------------"
Write-Host ""
$choice = Read-Host "Choice (or enter q to quit)"
Write-Host ""

If ($choice -eq "1"){
    set-brokerApplication -Name $app -LocalLaunchDisabled $false
    Write-Host "$app local launch disabled: " -ForegroundColor Yellow -NoNewLine
    (get-brokerApplication -Name $app).LocalLaunchDisabled
    Write-Host ""
    Write-Host "Good bye!"
    Exit
}

If ($choice -eq "2"){
    set-brokerApplication -Name $app -LocalLaunchDisabled $true
    Write-Host "$app local launch disabled: " -ForegroundColor Yellow -NoNewLine
    (get-brokerApplication -Name $app).LocalLaunchDisabled
    Write-Host ""
    Write-Host "Good bye!"
    Exit
}

If ($choice -eq "l"){
Clear-Host
Write-Host "------- " -NoNewLine
Write-Host "Citrix PowerTools" -NoNewLine
Write-Host " -------"
Write-Host ""
Write-Host "List of apps with local launch disabled" -ForegroundColor Cyan
(get-brokerApplication -LocalLaunchDisabled $true).ApplicationName
Write-Host ""
Write-Host "Good bye!"
Exit
}

If ($choice -eq "q"){Exit}
