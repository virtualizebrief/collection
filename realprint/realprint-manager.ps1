#-Things you can configure

Set-Location "\\your\realprint-manager"
$host.UI.RawUI.WindowTitle = "Real Print Manager"
#$Host.PrivateData.ConsolePaneBackgroundColor= "black"
#$Host.PrivateData.ConsolePaneTextBackgroundColor= "black"
$ErrorActionPreference = 'SilentlyContinue'
$dataBase = "\\your\database\"

$PrintServers = @(
"yourprintserver.domain.com",
"yourprintserver.domain.com",
"yourprintserver.domain.com")

# Show menu function
function Show-Menu
{
    param (
           [string]$Title = 'Real Print'
    )
function Get-Heading {Clear-Host
Write-Host ""
.\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
Write-Host "  If its not real its pass through."
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Endpoint: " -ForegroundColor Cyan -NoNewline
If ($endPoint -eq $null) {Write-Host "" -ForegroundColor Yellow -NoNewLine
Write-Host "[" -NoNewLine
Write-Host "No endpoint selected" -Foreground Red -NoNewLine
Write-Host "]"}
Else {Write-Host "$endPoint" -ForegroundColor Yellow}
#Write-Host "∙ Printers assigned to endpoint ∙" -ForegroundColor Yellow
$isThere = $dataBase + $endPoint + '.txt'
Get-Content $isThere | sort | Get-Unique | Set-Content $isThere
$foundPrinters = Get-Content $isThere
If (-Not $foundPrinters){Write-Host "[" -NoNewLine
Write-Host "No printers added" -foreground red -NoNewLine
Write-Host "]"}
Else {

$trimOutput1 = $foundPrinters -replace '^[^:]+\\'

if ($trimOutput1 -like '*Default*') {
$lastLineNumber = ($foundPrinters  | Measure-Object).count
$removeDefaultLine = $trimOutput1 | Select -Skip ($lastLineNumber -1)
$trimOutput2 = $trimOutput1 | select-string -pattern "Default Printer" -encoding ASCII | select -last 1
$trimOutput3 = $trimOutput2 -replace 'Default Printer: ','' 
$trimOutput4 = $trimOutput3 -replace '^[^:]+\\'
$trimOutput5 = "Default Printer: " + $trimOutput4
$addDefaultLine = $trimOutput5 
$trimOutputDisplay = $trimOutput1.replace($removeDefaultLine,$addDefaultLine)
$trimOutputDisplay}
else {
$trimOutput1}

}}
Get-Heading
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Main Menu" -Foreground Cyan
    Write-Host "--------------------------------------------------------------------"
    Write-Host "  Enter " -NoNewline
    Write-Host " S " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Select endpoint to manage" -ForegroundColor Green
    Write-Host "--------------------------------------------------------------------"
   
    Write-Host "  Enter " -NoNewline
    Write-Host " 1 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Add printer" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 2 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Delete printer" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 3 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Set default printer" -ForegroundColor Green -NoNewLine
    Write-Host " [" -NoNewLine
    Write-Host "printer must be added already" -Foregroundcolor red -NoNewLine
    Write-Host "]"

    Write-Host "  Enter " -NoNewline
    Write-Host " 4 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "List print servers and printers" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 5 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "How to use Real Print Manager?" -ForegroundColor Green
 
    Write-Host "--------------------------------------------------------------------"
    Write-Host "  Enter " -NoNewLine
    Write-Host " Q " -NoNewLine -Foreground yellow
    Write-Host "to quit Real Print Manager"
    Write-Host "" -NoNewline


}


# Run menu function
do
{
     Show-Menu
     $input = Read-Host "  `nPlease make a selection"
     switch ($input)
     {
           '1'  {
                function Get-Heading {Clear-Host
Write-Host ""
.\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
Write-Host "  If its not real its pass through."
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Endpoint: " -ForegroundColor Cyan -NoNewline
If ($endPoint -eq $null) {Write-Host "" -ForegroundColor Yellow -NoNewLine
Write-Host "[" -NoNewLine
Write-Host "No endpoint selected" -Foreground Red -NoNewLine
Write-Host "]"}
Else {Write-Host "$endPoint" -ForegroundColor Yellow}
#Write-Host "∙ Printers assigned to endpoint ∙" -ForegroundColor Yellow
$isThere = $dataBase + $endPoint + '.txt'
Get-Content $isThere | sort | Get-Unique | Set-Content $isThere
$foundPrinters = Get-Content $isThere
If (-Not $foundPrinters){Write-Host "[" -NoNewLine
Write-Host "No printers added" -foreground red -NoNewLine
Write-Host "]"}
Else {

$trimOutput1 = $foundPrinters -replace '^[^:]+\\'

if ($trimOutput1 -like '*Default*') {
$lastLineNumber = ($foundPrinters  | Measure-Object).count
$removeDefaultLine = $trimOutput1 | Select -Skip ($lastLineNumber -1)
$trimOutput2 = $trimOutput1 | select-string -pattern "Default Printer" -encoding ASCII | select -last 1
$trimOutput3 = $trimOutput2 -replace 'Default Printer: ','' 
$trimOutput4 = $trimOutput3 -replace '^[^:]+\\'
$trimOutput5 = "Default Printer: " + $trimOutput4
$addDefaultLine = $trimOutput5 
$trimOutputDisplay = $trimOutput1.replace($removeDefaultLine,$addDefaultLine)
$trimOutputDisplay}
else {
$trimOutput1}


}}
                Get-Heading
                Write-Host ""
                Write-Host ""
                Write-Host "Add printer" -Foreground Cyan
                Write-Host "--------------------------------------------------------------------"
                Write-Host "  Enter the name of the printer you'd like to assign to"
                Write-Host "  This end point. The print server info is not required."
                Write-Host "--------------------------------------------------------------------"
                Write-Host ""
                $addPrinter = Read-Host "Add printer (or R to return to Main Menu)"
                If ($addPrinter -eq 'r') {Write-Host ""
                    Pause
                    Break}
                $addPrinterClean = $addPrinter.split('[')[0] + "*" 
                ForEach ($PrintServer in $PrintServers) {
                    $searchResult = Get-Printer -ComputerName $PrintServer -Name $addPrinterClean
                    If ($searchResult) {$foundPrinter = '\\' + $PrintServer + '\' + $addPrinter}}
                Add-Content -Path $isThere -Value $foundPrinter
                Write-Host ""
                Pause
               
          } '2' {
                function Get-Heading {Clear-Host
Write-Host ""
.\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
Write-Host "  If its not real its pass through."
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Endpoint: " -ForegroundColor Cyan -NoNewline
If ($endPoint -eq $null) {Write-Host "" -ForegroundColor Yellow -NoNewLine
Write-Host "[" -NoNewLine
Write-Host "No endpoint selected" -Foreground Red -NoNewLine
Write-Host "]"}
Else {Write-Host "$endPoint" -ForegroundColor Yellow}
#Write-Host "∙ Printers assigned to endpoint ∙" -ForegroundColor Yellow
$isThere = $dataBase + $endPoint + '.txt'
Get-Content $isThere | sort | Get-Unique | Set-Content $isThere
$foundPrinters = Get-Content $isThere
If (-Not $foundPrinters){Write-Host "[" -NoNewLine
Write-Host "No printers added" -foreground red -NoNewLine
Write-Host "]"}
Else {

$trimOutput1 = $foundPrinters -replace '^[^:]+\\'

if ($trimOutput1 -like '*Default*') {
$lastLineNumber = ($foundPrinters  | Measure-Object).count
$removeDefaultLine = $trimOutput1 | Select -Skip ($lastLineNumber -1)
$trimOutput2 = $trimOutput1 | select-string -pattern "Default Printer" -encoding ASCII | select -last 1
$trimOutput3 = $trimOutput2 -replace 'Default Printer: ','' 
$trimOutput4 = $trimOutput3 -replace '^[^:]+\\'
$trimOutput5 = "Default Printer: " + $trimOutput4
$addDefaultLine = $trimOutput5 
$trimOutputDisplay = $trimOutput1.replace($removeDefaultLine,$addDefaultLine)
$trimOutputDisplay}
else {
$trimOutput1}


}}
                Get-Heading
                Write-Host ""
                Write-Host ""
                Write-Host "Delete printer" -Foreground Cyan
                Write-Host "--------------------------------------------------------------------"
                Write-Host "  You need only enter the printer name. The print"
                Write-Host "  server or full path is not required."
                Write-Host "--------------------------------------------------------------------"
                Write-Host ""
                $deletePrinter = Read-Host "Delete printer (or R to return to Main Menu)"
                If ($deletePrinter -eq 'r') {Write-Host ""
                    Pause
                    Break}
                (get-content $isThere | select-string -pattern $deletePrinter -notmatch) | Set-Content $isThere
                $newList = (get-content $isThere | select-string -pattern $deletePrinter -notmatch)
                If ($newList -eq $null){Clear-Content $isThere}
                Write-Host ""
                Pause

          } '3' {
                function Get-Heading {Clear-Host
Write-Host ""
.\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
Write-Host "  If its not real its pass through."
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Endpoint: " -ForegroundColor Cyan -NoNewline
If ($endPoint -eq $null) {Write-Host "" -ForegroundColor Yellow -NoNewLine
Write-Host "[" -NoNewLine
Write-Host "No endpoint selected" -Foreground Red -NoNewLine
Write-Host "]"}
Else {Write-Host "$endPoint" -ForegroundColor Yellow}
#Write-Host "∙ Printers assigned to endpoint ∙" -ForegroundColor Yellow
$isThere = $dataBase + $endPoint + '.txt'
Get-Content $isThere | sort | Get-Unique | Set-Content $isThere
$foundPrinters = Get-Content $isThere
If (-Not $foundPrinters){Write-Host "[" -NoNewLine
Write-Host "No printers added" -foreground red -NoNewLine
Write-Host "]"}
Else {

$trimOutput1 = $foundPrinters -replace '^[^:]+\\'

if ($trimOutput1 -like '*Default*') {
$lastLineNumber = ($foundPrinters  | Measure-Object).count
$removeDefaultLine = $trimOutput1 | Select -Skip ($lastLineNumber -1)
$trimOutput2 = $trimOutput1 | select-string -pattern "Default Printer" -encoding ASCII | select -last 1
$trimOutput3 = $trimOutput2 -replace 'Default Printer: ','' 
$trimOutput4 = $trimOutput3 -replace '^[^:]+\\'
$trimOutput5 = "Default Printer: " + $trimOutput4
$addDefaultLine = $trimOutput5 
$trimOutputDisplay = $trimOutput1.replace($removeDefaultLine,$addDefaultLine)
$trimOutputDisplay}
else {
$trimOutput1}


}}
                Get-Heading
                Write-Host ""
                Write-Host ""
                Write-Host "Set default printer" -Foreground Cyan
                Write-Host "--------------------------------------------------------------------"
                Write-Host "  You need only enter the printer name. The print"
                Write-Host "  server or full path is not required. If a default"
                Write-Host "  is already set the printer will continue to be"
                Write-Host "  mapped but your new choice will become the default."
                Write-Host "--------------------------------------------------------------------"
                Write-Host ""
                $defaultPrinter = Read-Host "Default printer (or R to return to Main Menu)"
                If ($defaultPrinter -eq 'r') {Write-Host ""
                    Pause
                    Break}              
                $newContent = Get-Content $isThere
                $newContent -replace "Default Printer: ","" | Set-Content $isThere

                $defaultPrinterClean = $defaultPrinter.split('[')[0] + "*" 

                $newDefaultPrinter = get-content $isThere | select-string -pattern $defaultPrinterClean -encoding ASCII | select -last 1
                (get-content $isThere | select-string -pattern $defaultPrinter -notmatch) | Set-Content $isThere
                $addNewDefaultPrinter = 'Default Printer: ' + $newDefaultPrinter
                Add-Content -Path $isThere -Value $addNewDefaultPrinter

                Write-Host ""
                Pause

          } 's' {
                function Get-Heading {Clear-Host
Write-Host ""
.\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
Write-Host "  If its not real its pass through."
Start-Sleep -S 1
Write-Host ""
Write-Host ""
Write-Host "Endpoint: " -ForegroundColor Cyan -NoNewline
If ($endPoint -eq $null) {Write-Host "" -ForegroundColor Yellow -NoNewLine
Write-Host "[" -NoNewLine
Write-Host "No endpoint selected" -Foreground Red -NoNewLine
Write-Host "]"}
Else {Write-Host "$endPoint" -ForegroundColor Yellow}
#Write-Host "∙ Printers assigned to endpoint ∙" -ForegroundColor Yellow
$isThere = $dataBase + $endPoint + '.txt'
Get-Content $isThere | sort | Get-Unique | Set-Content $isThere
$foundPrinters = Get-Content $isThere
If (-Not $foundPrinters){Write-Host "[" -NoNewLine
Write-Host "No printers added" -foreground red -NoNewLine
Write-Host "]"}
Else {

$trimOutput1 = $foundPrinters -replace '^[^:]+\\'

if ($trimOutput1 -like '*Default*') {
$lastLineNumber = ($foundPrinters  | Measure-Object).count
$removeDefaultLine = $trimOutput1 | Select -Skip ($lastLineNumber -1)
$trimOutput2 = $trimOutput1 | select-string -pattern "Default Printer" -encoding ASCII | select -last 1
$trimOutput3 = $trimOutput2 -replace 'Default Printer: ','' 
$trimOutput4 = $trimOutput3 -replace '^[^:]+\\'
$trimOutput5 = "Default Printer: " + $trimOutput4
$addDefaultLine = $trimOutput5 
$trimOutputDisplay = $trimOutput1.replace($removeDefaultLine,$addDefaultLine)
$trimOutputDisplay}
else {
$trimOutput1}


}}
                Get-Heading
                Write-Host ""
                Write-Host "Select endpoint to manage" -Foreground Cyan
                Write-Host "--------------------------------------------------------------------"
                Write-Host "  Enter the name of a different endpoint."
                Write-Host "--------------------------------------------------------------------"
                Write-Host ""
                $endPoint = Read-Host "Endpoint (or R to return to Main Menu)"
                    If ($endPoint -eq 'r') {Write-Host ""
                        Pause
                        Break}              
                    $isThere = $dataBase + $endPoint + '.txt'
                    $isFound = Test-Path -Path $isThere  -PathType Leaf
                    $foundPrinters = Get-Content $isThere

                #-If not found prompt to add endpoint entry
                        If (-not $isFound) {
                        Clear-Host
                        Write-Host ""
                        .\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
                        Write-Host "  If its not real its pass through."
                        Start-Sleep -S 1
                        Write-Host ""
                        Write-Host ""
                        Write-Host "Endpoint:" -ForegroundColor Cyan -NoNewline
                        Write-Host " $endPoint" -ForegroundColor Yellow
                        Write-Host "No record found!" -ForegroundColor Red
                        Write-Host ""
                        $addEndpoint = Read-Host "Would you like to add an entry? (y/n)"
                        If ($addEndpoint -eq 'y') {$createFolder = New-Item $isThere
                               Write-Host ""
                               Write-Host "Entry for $endPoint created!" -ForegroundColor Green
                               Pause}         
                        Else {Write-Host ""
                        $endPoint = $null
                        Pause}
                        }

          } '4' {Clear-Host
                Write-Host ""
                .\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
                Write-Host "  If its not real its pass through."
                Start-Sleep -S 1
                Write-Host ""
                Write-Host ""
                Write-Host "Feature under construction!" -ForegroundColor Red
                Write-Host ""
                Write-Host "Current print servers accessed by Real Print" -ForegroundColor Cyan
                Write-Host "--------------------------------------------------------------------"
                $PrintServers
                Write-Host "--------------------------------------------------------------------"
                Write-Host ""
                Write-Host "Generating list of printservers and printers..." -ForegroundColor Yellow -NoNewLine
                .\PrintServersPrinters.ps1
                <#
                $PrinterResults = $PrintServers | Foreach-Object { get-printer -cn $_  -ErrorAction SilentlyContinue | select @{name='Printer Name';expression={$($_.Name)}}, @{name='Print Server';expression={$($_.ComputerName)}}, @{name='Site';expression={$($_.Location)}}, @{name='Print Driver Installed';expression={$($_.DriverName)}} }
                $PrinterResults | Out-GridView -Title 'Easy Search for all LCMC Printer Info'
                #>
                Write-Host "completed!" -ForegroundColor Green
                Write-Host ""
                Pause   
                
          } '5' {Clear-Host
                Write-Host ""
                .\Convertto-TextASCIIArt.ps1 -Text ' Real Print' -FontColor Yellow
                Write-Host "  If its not real its pass through."
                Start-Sleep -S 1
                Write-Host ""
                Write-Host "Welcome to Real Print Manager" -ForegroundColor Yellow
                Write-Host "Here you can assign printers to endpoints which"
                Write-Host "will result in these printers being mapped to"
                Write-Host "user sessions for Citrix session connected"
                Write-Host "through that endpoint."
                Write-Host ""
                Write-Host "What is an Endpoint?" -ForegroundColor Yellow
                Write-Host "Any computer connecting to a Citrix session."
                Write-Host " • " -NoNewLine
                Write-Host "Windows" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Linux" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "MAC" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "iOS" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Android" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Igel" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Wyse device" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Windows embedded" -ForegroundColor Cyan
                Write-Host " • " -NoNewLine
                Write-Host "Thin client of any kind" -ForegroundColor Cyan
                Write-Host ""
                Write-Host "When does this happen?" -ForegroundColor Yellow
                Write-Host "At each user login or new session for a Citrix"
                Write-Host "session."
                Write-Host ""
                Write-Host "What do you need to know?" -ForegroundColor Yellow
                Write-Host "To start the name of an endpoint. Enter that below"
                Write-Host "to look up what printers are assigned or create an"
                Write-Host "entry for this endpoint to then assign printers."
                Write-Host ""
                Pause                        
                     
               
          } 'm' {
                              
          }
         
     }
}
until ($input -eq 'q')

