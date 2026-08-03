#------apply custom settings

$User = $env:UserName
Set-Location "\\server\support\kuipermenu"


#------run

Clear-Host

# Show menu function
function Show-Menu
{
    param (
           [string]$Title = 'Kuiper Menu'
    )
Clear-Host
Write-Host "# Kuiper Menu" -Foreground Cyan
Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
Write-Host ""
Write-Host "- User: $User"
Write-Host "- Question? " -NoNewline
Write-Host "michael.wood@mydomain.com"
write-host ""
Write-Host "Enter a number to do thing" -ForegroundColor Yellow
Write-Host ""
Write-Host "Main Menu" -Foreground Cyan
    Write-Host "----------------------------------------------------------"
   
    Write-Host "  Enter " -NoNewline
    Write-Host "1 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Kuiper checkin" -ForegroundColor yellow

    Write-Host "  Enter " -NoNewline
    Write-Host "2 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Satellite install" -NoNewLine -ForegroundColor green
    Write-Host " Non Production" -ForegroundColor yellow

    Write-Host "  Enter " -NoNewline
    Write-Host "3 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Satellite install" -NoNewLine -ForegroundColor green
    Write-Host " Production" -ForegroundColor yellow

    Write-Host "  Enter " -NoNewline
    Write-Host "4 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Satellite install" -NoNewLine -ForegroundColor green
    Write-Host " Trackboard" -ForegroundColor yellow

    Write-Host "  Enter " -NoNewline
    Write-Host "5 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Satellite install" -NoNewLine -ForegroundColor green
    Write-Host " Willow Ambulatory" -ForegroundColor yellow

    Write-Host "  Enter " -NoNewline
    Write-Host "6 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Satellite uninstall" -ForegroundColor red

    Write-Host "----------------------------------------------------------"
    Write-Host "  Enter " -NoNewLine
    Write-Host "Q " -NoNewLine -Foreground yellow
    Write-Host "to quit " -nonewline
    write-host "Kuiper Menu" -ForegroundColor cyan
    Write-Host "" -NoNewline


}


# Run menu function
do
{
     Show-Menu
     $input = Read-Host "  `nPlease make a selection"
     switch ($input)
     {
           '1' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\checkin-kuiper.ps1

          } '2' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\install-satellite-nonproduction.ps1

          } '3' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\install-satellite-production.ps1

          } '4' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\install-satellite-trackboard.ps1

          } '5' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\install-satellite-willow.ps1

          } '6' {Clear-Host
                Clear-Host
                Write-Host "# Kuiper Menu" -Foreground Cyan
                Write-Host "!Warning must run powershell as admin" -ForegroundColor Red
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                & .\tasks\uninstall-satellite.ps1
               
          } 'S' {
                Clear-Host
                               
          }
         
     }
}
until ($input -eq 'q')
