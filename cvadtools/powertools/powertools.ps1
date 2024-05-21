$User = $env:UserName


# Show menu function
function Show-Menu
{
    param (
           [string]$Title = 'Powertools'
    )
Clear-Host
Write-Host "# PowerTools" -Foreground Cyan
Write-Host "List of powerful Citrix tools to accomplish great things." -ForegroundColor Yellow
Write-Host "Edition: Service Desk Console" -ForegroundColor Green
Write-Host "User: $User"
Write-Host ""
Write-Host ""

    Write-Host "# Main Menu" -Foreground Cyan
    Write-Host "---+-------------------+----------------------------------------------"
    Write-Host " √ | Tool              | Description"
    Write-Host "---+-------------------+----------------------------------------------"
   
    Write-Host " 1 " -NoNewline -ForegroundColor Yellow
    Write-Host "| " -NoNewline
    Write-Host "Session Manger" -NoNewLine -ForegroundColor Green
    write-host "    | " -NoNewLine
    write-host "See & fix busted Citrix sessions for a user" -ForegroundColor Yellow

    Write-Host " 2 " -NoNewline -ForegroundColor Yellow
    Write-Host "| " -NoNewline
    Write-Host "Profile Reset" -NoNewLine -ForegroundColor Green
    write-host "     | " -NoNewLine
    write-host "Clear user data for Citrix WEM" -ForegroundColor Yellow

    Write-Host " 3 " -NoNewline -ForegroundColor Yellow
    Write-Host "| " -NoNewline
    Write-Host "Remote PC Access" -NoNewLine -ForegroundColor Green
    write-host "  | " -NoNewLine
    write-host "Citrix VDA on endpoint for remote connection" -ForegroundColor Yellow

    Write-Host " 4 " -NoNewline -ForegroundColor Yellow
    Write-Host "| " -NoNewline
    Write-Host "Entitlements" -NoNewLine -ForegroundColor Green
    write-host "      | " -NoNewLine
    write-host "Get list of apps assigned to ad group" -ForegroundColor Yellow

    Write-Host "---+-------------------+----------------------------------------------"

}


# Run menu function
do
{
     Show-Menu
     $input = Read-Host "  `nPlease make a selection (or 'q' to quit)"
     switch ($input)
     {
           '1'  {Clear-Host
                Clear-Host
                Write-Host "# PowerTools" -Foreground Cyan
                Write-Host "List of powerful Citrix tools to accomplish great things." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Loading." -NoNewline
                Start-Sleep -S 1
                Write-Host "."-NoNewline
                PowerShell -File ".\sessionmanager-support.ps1"

          } '2' {Clear-Host
                Clear-Host
                Write-Host "# PowerTools" -Foreground Cyan
                Write-Host "List of powerful Citrix tools to accomplish great things." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Loading." -NoNewline
                Start-Sleep -S 1
                Write-Host "."-NoNewline
                PowerShell -File ".\reset-citrixprofile.ps1"

          } '3' {Clear-Host
                Clear-Host
                Write-Host "# PowerTools" -Foreground Cyan
                Write-Host "List of powerful Citrix tools to accomplish great things." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Loading." -NoNewline
                Start-Sleep -S 1
                Write-Host "."-NoNewline
                PowerShell -File ".\install-remotepc.ps1"

          } '4' {Clear-Host
                Clear-Host
                Write-Host "# PowerTools" -Foreground Cyan
                Write-Host "List of powerful Citrix tools to accomplish great things." -ForegroundColor Yellow
                Write-Host ""
                Write-Host "Loading." -NoNewline
                Start-Sleep -S 1
                Write-Host "."-NoNewline
                PowerShell -File ".\get-entitlements-adgroup.ps1"
                            
          } 'S' {
                Get-Job
                pause
                               
          }
         
     }
}
until ($input -eq 'q')