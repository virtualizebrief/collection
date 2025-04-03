# Configurable exclusions
$skipDgs =
"skipme01",
"skipme02"

$dgs = (get-brokerdesktopgroup | where-object {$name = $_.Name
 -not ($skipDgs | Where-Object { $name -like $_ })}).name

clear-host
write-host ""
write-host "# Citrix VDA Hyperdrive installs" -ForegroundColor green
get-date
write-host "-------------+-------------------------------------------------" -foregroundcolor yellow
write-host "Hyperdrive   " -nonewline
write-host "|" -ForegroundColor yellow -NoNewline
write-host " Delivery group"
write-host "-------------+-------------------------------------------------" -foregroundcolor yellow

foreach ($dg in $dgs) {

    $machine = (get-brokermachine -DesktopGroupName $dg -ProvisioningType MCS -RegistrationState Registered -PowerState On -MaxRecordCount 10000).DNSName | sort-object | select-object -first 1    
    if ($machine -eq $null){    
    write-host "no machines  " -foregroundcolor darkgray -NoNewline
    }    
    else {    
        if (test-wsman $machine -erroraction SilentlyContinue) {
            invoke-command -ComputerName $machine -ScriptBlock {
                $verHD = @(Get-ChildItem "C:\Program Files (x86)\Epic\Hyperdrive\100*")
                $verHD = $verHD | Sort-Object -Desc Name
                $currentHD = $verHD[0].Name
                if ($currentHD -eq $null) {
                    write-host "no install   " -foregroundcolor gray -nonewline
                    }
                else {
                    write-host "$currentHD " -NoNewline
                    }
            } -ErrorAction SilentlyContinue
        }
        else {
            write-host "no connect   " -foregroundcolor darkgray -NoNewline
        }    
    }
    write-host "| " -foregroundcolor yellow -NoNewline
    write-host "$dg" -ForegroundColor cyan
}
write-host "-------------+-------------------------------------------------" -foregroundcolor yellow
write-host ""
pause
