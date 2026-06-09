#------apply custom settings

reg import \\server\path\putty-text-connections\custom-settings.reg
$User = $env:UserName
Set-Location "C:\Program Files\PuTTY"


#------run Putty Text Connections

Clear-Host

# Show menu function
function Show-Menu
{
    param (
           [string]$Title = 'AddSoftware'
    )
Clear-Host
Write-Host "-------" -NoNewLine
Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
Write-Host "-------"
Write-Host ""
Write-Host "User: $User"
Write-Host "Question or request? " -NoNewline
Write-Host "first.last@email.com"
Write-Host "Enter a number to connect to a text environment" -ForegroundColor Yellow
Write-Host ""
Write-Host "Main Menu" -Foreground Cyan
    Write-Host "----------------------------------------------------------"
   
    Write-Host "  Enter " -NoNewline
    Write-Host " 1 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Production" -ForegroundColor Cyan -NoNewLine
    Write-Host " warning this is production!" -ForegroundColor Red

    Write-Host "  Enter " -NoNewline
    Write-Host " 2 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "POC" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 3 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "TST" -ForegroundColor Green

    Write-Host "----------------------------------------------------------"

    Write-Host "  Enter " -NoNewline
    Write-Host " 4 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "REL" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 5 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "RELVAL" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 6 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "RPT" -ForegroundColor Green
    
    Write-Host "  Enter " -NoNewline
    Write-Host " 7 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "SUP" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 8 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "SUP2" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host " 9 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "TST2" -ForegroundColor Green

    Write-Host "  Enter " -NoNewline
    Write-Host "10 " -NoNewline -ForegroundColor Yellow
    Write-Host "for: " -NoNewline
    Write-Host "Training " -ForegroundColor Yellow -NoNewLine
    Write-Host "ACE1 ACE2 ACE3 ACE4 ACE5 ACE6" -ForegroundColor Green
    Write-Host "                " -NoNewLine
    Write-Host "CRE DEMO EXAM MST PLY PLY2 PREP REF"  -ForegroundColor Green

    Write-Host "----------------------------------------------------------"
    Write-Host "  Enter " -NoNewLine
    Write-Host "Q " -NoNewLine -Foreground yellow
    Write-Host "to quit Putty Text Connections"
    Write-Host "" -NoNewline

}


# Run menu function
do
{
     Show-Menu
     $input = Read-Host "  `nPlease make a selection"
     switch ($input)
     {
           '1'  {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow
                Write-Host ""
                Write-Host "!WARNING!" -ForegroundColor Red
                Write-Host "You are about to connect to production." -ForegroundColor Red
                Write-Host ""
                $warn = Read-Host "Continue? (y/n)"
                If ($warn -eq "y"){Start-Process .\putty.exe -ArgumentList "-load `"Production`""}
               
          } '2' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load `"POC`""

          } '3' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load `"TST`""

          } '4' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load REL"

          } '5' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load RELVAL"

          } '6' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load RPT"

          } '7' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load SUP"

          } '8' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load SUP2"

          } '9' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load TST2"

          } '10' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load Training"

          } '10' {Clear-Host
                Clear-Host
                Write-Host "-------" -NoNewLine
                Write-Host "Putty Text Connections" -Foreground Cyan -NoNewLine
                Write-Host "-------"
                Write-Host ""
                Write-Host "Loading." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Sleep -S 1
                Write-Host "." -ForegroundColor yellow -NoNewline
                Start-Process .\putty.exe -ArgumentList "-load Training"
               
          } 'S' {
                Clear-Host
                Optional Secret Menu
                               
          }
         
     }
}
until ($input -eq 'q')
