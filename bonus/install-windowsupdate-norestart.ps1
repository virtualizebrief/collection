set-location C:\Support\Apps\Powertools\CitrixApp\WindowsUpdate

Clear-Host
Write-Host "Powertools - Windows updates" -ForegroundColor Cyan
Write-Host ""
Write-Host "Enter 1 - for Infrastructure in DC1"
Write-Host "Enter 3 - for Infrastructure in DC3"
$Choice = Read-Host "Please enter a choice"

If ($Choice -eq "1"){
    $computers = Get-Content .\computers-DC1.txt
}

If ($Choice -eq "3"){
    $computers = Get-Content .\computers-DC3.txt
}


If (($Choice -ne "1") -and ($Choice -ne "3")){
    Write-Host "Invalid choice. You didn't enter 1 or 3!" -ForegroundColor Yellow
    Pause
    Exit
}


Clear-Host
Write-Host "Install pending Windows Update for computers"
Write-Host ""
Write-Host "Selected computers" -ForegroundColor Cyan
$computers
Write-Host ""
Write-Host "Press CTRL+C to quit..." -ForegroundColor Yellow
pause
Write-Host ""
Write-Host "Results" -ForegroundColor Cyan
Write-Host "------------------------------"

Foreach ($computer in $computers){

    Write-Host "$computer" -ForegroundColor Yellow

    $osVersion = Invoke-Command -ComputerName $computer -ScriptBlock {(gwmi win32_operatingsystem).caption}

    If (($osVersion -like "*2012*") -or ($osVersion -like "*2016*") -or ($osVersion -like "*2008*")){
        Write-Host "$osVersion - Unsupported OS version!" -ForegroundColor Red
        Write-Host "Must be Windows Server 2019 or greater."}

    Else {
        Invoke-Command -ComputerName $computer -ScriptBlock {Set-NetFirewallProfile -Enabled False}

        Invoke-Command -ComputerName $computer -ScriptBlock {
            if(-not (Get-Module PSWindowsUpdate -ListAvailable)){
                $null = Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
                $null = Install-Module PSWindowsUpdate -Force
            }
    }


    Write-Host "Pending reboot? " -NoNewline -ForegroundColor Green
        Get-WURebootStatus -ComputerName $computer -Silent
        Get-WindowsUpdate -Install -AcceptAll –IgnoreReboot -ComputerName $computer | Format-Table -AutoSize
    }

Write-Host ""

}

Write-Host ""
Write-Host "done!"
pause
exit