#------------------Display Banner-------------------------
Clear-Host
Write-Host "-------" -NoNewLine
Write-Host "Citrix Power Tools" -Foreground Cyan -NoNewLine
Write-Host "-------"
Write-Host ""
Write-Host "User Stop and Hide Session" -ForegroundColor Cyan
Write-Host""
Write-Host "Why would you want to do this?" -ForegroundColor Yellow
Write-Host "Sometimes a user session will become stuck. Each time"
Write-Host "the user launches the same thing it goes back to this"
Write-Host "broken session or bad connection."
Write-Host""
Write-Host "What will this do for the user?" -ForegroundColor Yellow
Write-Host "This action will disconnect, logoff, and then hide the"
Write-Host "user session. Even if the logoff fails to complete the"
Write-Host "session being hidden will allow the user to connect anew"
Write-Host "to the same thing on a new working session connection."
Write-Host""
Write-Host "Trouble or questions for the StoreFront Team?"
Write-Host "Feel free to contact us anytime: "
Write-Host""

Write-Host "Ready to give this a try?" -Foregroundcolor Cyan
$UserNumber = Read-Host "Enter User Number (ie: 008789) or Q to exit"
If ($UserNumber -eq "q"){exit}
Add-PSSnapin Citrix*

<# can be enabled if desired
Log File
$Logfile = "\\yoour\path\file.csv"
New-Item $Logfile -ItemType File -Force #Not needed if file already exist.
Set-Content $Logfile 'HelpDesk Person, End User, VDA, Date, Time'
#>

Clear-Host
Write-Host""
Write-Host "-= Stop & Hide User Session =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Current session(s) for $UserNumber" -ForegroundColor Yellow
Write-Host "----------------------------------------"
$User = "vanclinic\" + $UserNumber
$Session = Get-BrokerSession -username $User | Select-Object LaunchedViaPublishedName,BrokeringUserName,HostedMachineName,SessionState,Hidden | Format-List
$Session
If ($Session -eq $Null) {Write-Host "No sessions found for $UserNumber!" -ForegroundColor Red
Write-Host "----------------------------------------"
Write-Host ""
Write-Host "Good-bye my friend!" -ForegroundColor Cyan
Write-Host "Stop & Hide User Session will now exit" -ForegroundColor Yellow
Pause
Exit}
Write-Host "----------------------------------------"
Write-Host ""

Write-Host "Want to " -ForegroundColor Cyan -NoNewLine
Write-Host "Stop & Hide" -ForegroundColor Red -NoNewline
Write-Host " one of these sessions?" -ForegroundColor Cyan
$VDA = Read-Host "Enter VDA or Hosted Machine Name"
Get-BrokerSession -UserName $User -HostedMachineName $VDA | Stop-BrokerSession
Get-BrokerSession -Username $User -HostedMachineName $VDA | Set-BrokerSession -hidden $true
Write-Host ""

#-Update Log File
$TimeNow = Get-Date -Format HH:mm:ss
$DateNow = Get-Date -Format yyyy-MM-dd

$userinfo = (net user $env:USERNAME /domain | Select-String "Full Name") -replace "\s\s+"," " -split " " -replace ",","."
$userinfo = $userinfo[2] + $userinfo[3] + $userinfo[4] + $userinfo[5]

$sessionuser = (net user $UserNumber /domain | Select-String "Full Name") -replace "\s\s+"," " -split " " -replace ",","."
$sessionuser = $sessionuser[2] + $sessionuser[3] + $sessionuser[4] + $sessionuser[5]


$NewLine = "{0},{1},{2},{3},{4},{5}" -f $userinfo,$sessionuser,$UserNumber,$VDA,$DateNow,$TimeNow
$NewLine | add-content -path $Logfile

Clear-Host
Write-Host""
Write-Host "-= Stop & Hide User Session =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Which session was selected to be hidden?" -Foregroundcolor yellow
Write-Host "Selected User: $UserNumber"
Write-Host "Selected VDA: $VDA"
Write-Host ""
Start-Sleep -S 3
Write-Host "Immediate results" -ForegroundColor Cyan
Write-Host "Notice the session now marked " -NoNewline -ForegroundColor Yellow
Write-Host "Hidden:True" -ForegroundColor Green
Write-Host "----------------------------------------"
$Session = Get-BrokerSession -username $User | Select-Object LaunchedViaPublishedName,BrokeringUserName,HostedMachineName,SessionState,Hidden | Format-List
$Session
If ($Session -eq $Null) {Write-Host "No session found for $UserNumber!" -ForegroundColor Red}
Write-Host "----------------------------------------"
Write-Host ""
Write-Host "Pausing for 30 seconds to get updated results" -ForegroundColor Cyan
Write-Host "Processing."  -ForegroundColor Yellow -NoNewline
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2
Write-Host "." -ForegroundColor Yellow -NoNewline
Start-Sleep -S 2

Clear-Host
Write-Host""
Write-Host "-= Stop & Hide User Session =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Which session was selected to be hidden?" -Foregroundcolor yellow
Write-Host "Selected User: $UserNumber"
Write-Host "Selected VDA: $VDA"
Write-Host ""
Write-Host "After 30 seconds results" -ForegroundColor Cyan
Write-Host "The hidden session should now be gone if logoff was successful."
Write-Host "If it was not successful thats OK, this user still can not return"
Write-Host "to the hidden session and they are clear to connect again to a new"
Write-Host "thing."
Write-Host "----------------------------------------"
$Session = Get-BrokerSession -username $User | Select-Object LaunchedViaPublishedName,BrokeringUserName,HostedMachineName,SessionState,Hidden | Format-List
$Session
If ($Session -eq $Null) {Write-Host "No session found for $UserNumber!" -ForegroundColor Red}
Write-Host "----------------------------------------"

Write-Host ""
Write-Host "Good-bye my friend!" -ForegroundColor Cyan
Write-Host ""
Write-Host "Stop & Hide User Session will now exit"  -ForegroundColor Yellow
pause
exit
