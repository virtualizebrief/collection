Clear-Host

$site = (Get-BrokerSite).name

Write-Host "Get & Set Delivery Group AllowReconnectInMaintenanceMode" -ForegroundColor Cyan
Write-Host "Site: $site" -Foregroundcolor Yellow
Write-Host ""
Write-Host "Current setting for all Delivery Groups" -ForegroundColor Cyan -NoNewLine
Get-BrokerDesktopGroup | Select-Object Name,AllowReconnectInMaintenanceMode | Out-Host

$dg = read-host "Enter Delivery Group to change (or 'q' to quit)"
If ($dg -eq "q"){Write-Host ""
exit}
Write-Host "Allow Reconnect in Maintenance Mode: " -ForegroundColor Yellow -NoNewLine 
$allow = (Get-BrokerDesktopGroup -Name $dg).AllowReconnectInMaintenanceMode
Write-Host "$allow" -ForegroundColor Green
Write-Host ""

If ($allow -eq 'true'){
    
    Write-Host "Would you like to turn this off?"
    $choice = Read-Host "yes/no?"
    Write-Host ""

    If ($choice -eq 'yes'){
    
        Set-BrokerDesktopGroup -Name $dg -AllowReconnectInMaintenanceMode $false
        Write-Host "Results" -Foregroundcolor Cyan
        Write-Host "Delivery Group: $dg"
        Write-Host "Allow Reconnect in Maintenance Mode: " -ForegroundColor Yellow -NoNewLine 
        $check = (Get-BrokerDesktopGroup -Name $dg).AllowReconnectInMaintenanceMode
        Write-Host "$check" -ForegroundColor Green
        Write-Host ""
        pause
        exit
    
    }
    If ($choice -eq 'no'){
    
        Write-Host ""
        pause
        exit
    
    }

}

Else{

    Write-Host "Would you like to turn this on?"
    $choice = Read-Host "yes/no?"
    Write-Host ""

    If ($choice -eq 'yes'){
    
        Set-BrokerDesktopGroup -Name $dg -AllowReconnectInMaintenanceMode $true
        Write-Host "Results" -Foregroundcolor Cyan
        Write-Host "Delivery Group: $dg"
        Write-Host "Allow Reconnect in Maintenance Mode: " -ForegroundColor Yellow -NoNewLine 
        $check = (Get-BrokerDesktopGroup -Name $dg).AllowReconnectInMaintenanceMode
        Write-Host "$check" -ForegroundColor Green
        Write-Host ""
        pause
        exit
    
    }
    If ($choice -eq 'no'){
    
        Write-Host ""
        pause
        exit
    
    }


}


<# Scratch pad

Get-BrokerDesktopGroup -filer  | Select-Object Name,SessionSupport,AllowReconnectInMaintenanceMode | Out-Host

#>