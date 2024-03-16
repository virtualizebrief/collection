<#
 Real Print
 Michael Wood
 Created: 2023.06.07
 Updated: 2024.03.13
 This script dynamically updates the printers in a session.  It should be run via script call on Create Desktop and Reconnect.
 
 Order of operations:
 1. Lookup the printers assigned in database
 2. Lookup current printers connected
 3. Remove current connected printers not found in database
 4. Add printers in database not found in connected printers
 5. Set default printer from database

 All operations should be logged.
#>

$runTime = Measure-Command {

#-things you need to set
Set-Location "path to ps1"
$dataBase = "path to flat file database \\something\something"

#-preconfigured settings
$ErrorActionPreference = "SilentlyContinue"; #This will hide errors
$getDate = Get-Date -format "yyyyMMddTHHmmss"
$hostName = hostname
$endPoint = Get-ItemProperty -path "HKLM:\SOFTWARE\Citrix\ICA\Session\1\Connection" -Name "ClientName" | Select-Object "ClientName" | foreach { $_.ClientName }
$endpointFile = $dataBase + $endPoint + '.txt'
$endpointFileExist = Test-Path -Path $endpointFile -PathType Leaf
$getPrinters = get-content $endpointFile
$addPrints = @($getPrinters -replace "Default Printer: ","")
$addPrinters = $addPrints | Get-Unique
$getDefaultPrinter = (get-content $endpointFile | select-string -pattern "Default Printer")
$setDefaultPrinter = $getDefaultPrinter -replace "Default Printer: ",""
$currentPrinters = (Get-WMIObject Win32_Printer | where{$_.Network -eq 'true'}).name
If ($currentPrinters -eq $null){$currentPrinters = "none"}
$user = $env:UserName
$logfile = "C:\Support\RealPrint.log"
$logFileCSV = "C:\Support\RealPrint.csv"

#-Setup log file
Add-Content -Path $LogFile -Value "$GetDate ========================================="
Add-Content -Path $LogFile -Value "$GetDate   Real Print"
Add-Content -Path $LogFile -Value "$GetDate   Release: 2024.03.13"
Add-Content -Path $LogFile -Value "$GetDate ========================================="
Add-Content -Path $LogFile -Value "$GetDate   ...Running User Processes"
Add-Content -Path $LogFile -Value "$GetDate   ...User found: $User"
Add-Content -Path $LogFile -Value "$GetDate   ...Endpoint: $endPoint"
Add-Content -Path $LogFile -Value "$GetDate   ...Citrix Desktop: $hostName"
Add-Content -Path $LogFile -Value "$GetDate"
Add-Content -Path $LogFile -Value "$GetDate   Printer processing..."
Add-Content -Path $LogFile -Value "$GetDate   -------------------------------"
Add-Content -Path $LogFileCSV -Value "$GetDate,Release,Real Print 2023.07.21"
Add-Content -Path $LogFileCSV -Value "$GetDate,Running as,User process"
Add-Content -Path $LogFileCSV -Value "$GetDate,User name,$User"
Add-Content -Path $LogFileCSV -Value "$GetDate,Endpoint,$endPoint"
Add-Content -Path $LogFileCSV -Value "$GetDate,Citrix desktop,$hostName"

#-Header
Clear-Host
Write-Host "----- Real Print ------" -Foreground Cyan
Write-Host ""
Write-Host "Welcome to Real Print Mapper" -Foreground Yellow
Write-Host "The thing that connects your printers."
Write-Host ""
Write-Host "Settings" -Foreground Yellow
Write-Host "Endpoint: $endPoint"
Write-Host "Citrix Desktop: $hostname"
Write-Host "Start time: $getDate"
Write-Host ""
Write-Host "Printer mapping results..." -Foreground Cyan
Write-Host "--------------------------------------------------"
If (-Not $endpointFileExist){Write-Host "Error 420: $endPoint has no database entry!" -Foreground Red
    Write-Host "--------------------------------------------------"
    Write-Host ""
    Pause
    Exit}

#-Delete those current printers not found on add printer list
$realDeletePrinters = Compare-Object -ReferenceObject $currentPrinters -DifferenceObject $addPrinters -IncludeEqual |
 Where-Object {$_.SideIndicator -like "<="} |
  foreach { $_.InputObject }
Foreach ($realDeletePrinter in $realDeletePrinters){
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Add-Content -Path $LogFile -Value "$GetDate   deleting: $realDeletePrinter"
Add-Content -Path $LogFileCSV -Value "$GetDate,Deleting,$realDeletePrinter"
Write-Host "deleting: $realDeletePrinter" -ForegroundColor yellow
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $realDeletePrinter).Delete()}

#-Skipping those current printers found on both lists
$realSkipPrinters = Compare-Object -ReferenceObject $currentPrinters -DifferenceObject $addPrinters -IncludeEqual |
 Where-Object {$_.SideIndicator -like "=="} |
  foreach { $_.InputObject }
Foreach ($realSkipPrinter in $realSkipPrinters){
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Add-Content -Path $LogFile -Value "$GetDate   skipping: $realSkipPrinter"
Add-Content -Path $LogFileCSV -Value "$GetDate,Skipping,$realSkipPrinter"
Write-Host "skipping: $realSkipPrinter" -ForegroundColor yellow}

#-Add printers not found on current list
$realAddPrinters = Compare-Object -ReferenceObject $currentPrinters -DifferenceObject $addPrinters -IncludeEqual |
 Where-Object {$_.SideIndicator -like "=>"} |
  foreach { $_.InputObject }
Foreach ($realAddPrinter in $realAddPrinters){
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Add-Content -Path $LogFile -Value "$GetDate   adding  : $realAddPrinter"
Add-Content -Path $LogFileCSV -Value "$GetDate,Adding,$realAddPrinter"
Write-Host "adding  : $realAddPrinter" -ForegroundColor cyan
([wmiclass]"Win32_Printer").AddPrinterConnection($realAddPrinter)}

#-Set default print if one is set in real print
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : $setDefaultPrinter" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : $setDefaultPrinter"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default is,$setDefaultPrinter"

$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : attempt 1 of 5 to set default" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : attempt 1 of 8 (20 second pause between)"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default set,Attempt 1 of 8 (20 second pause between)"
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $setDefaultPrinter).SetDefaultPrinter()
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Start-Sleep -s 20

$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : attempt 2 of 5 to set default" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : attempt 2 of 8 (20 second pause between)"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default set,Attempt 2 of 8 (20 second pause between)"
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $setDefaultPrinter).SetDefaultPrinter()
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Start-Sleep -s 20

$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : attempt 3 of 5 to set default" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : attempt 3 of 8 (20 second pause between)"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default set,Attempt 3 of 8 (20 second pause between)"
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $setDefaultPrinter).SetDefaultPrinter()
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Start-Sleep -s 20

$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : attempt 4 of 5 to set default" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : attempt 4 of 8 (20 second pause between)"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default set,Attempt 4 of 8 (20 second pause between)"
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $setDefaultPrinter).SetDefaultPrinter()
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Start-Sleep -s 20

$getDate = Get-Date -format "yyyyMMddTHHmmss"
Write-Host "default : attempt 5 of 5 to set default" -ForegroundColor green
Add-Content -Path $LogFile -Value "$GetDate   default : attempt 5 of 8 (20 second pause between)"
Add-Content -Path $LogFileCSV -Value "$GetDate,Default set,Attempt 5 of 8 (20 second pause between)"
$toNull = (gwmi -Class Win32_Printer | ? Name -eq $setDefaultPrinter).SetDefaultPrinter()
$getDate = Get-Date -format "yyyyMMddTHHmmss"
Start-Sleep -s 20

#-Goodbye
Write-Host "-------------------------------"
Write-Host ""
Write-Host "Seconds to complete: " -NoNewline

} | foreach { $_.Seconds }

Add-Content -Path $LogFile -Value "$GetDate   -------------------------------"
Add-Content -Path $LogFile -Value "$GetDate   Seconds to complete work: $runTime"
Add-Content -Path $LogFileCSV -Value "$GetDate,Seconds to complete,$runTime"
Add-Content -Path $LogFileCSV -Value "....."
Add-Content -Path $LogFile -Value "."

Stop-Process -Id $Pid -Force 
