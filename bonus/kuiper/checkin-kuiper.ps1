$satExist = test-path -path "C:\Program Files (x86)\Epic\Satellite"

if (!($satExist)) {

    write-host "Satellite not installed!"  -foregroundcolor red
    write-host ""
    write-host "Have a great day." -foregroundcolor green
    pause

}

else {
# Get current install Satellite and Hyperdrive versions
function get-current-installs {

    $verSat = @(Get-ChildItem "C:\Program Files (x86)\Epic\Satellite")
    $verSat = $verSat | Sort-Object -Desc Name
    $currentSat = $verSat[0].Name

    $verHD = @(Get-ChildItem "C:\Program Files (x86)\Epic\Hyperdrive\100*")
    $verHD = $verHD | Sort-Object -Desc Name
    $currentHD = $verHD[0].Name

    write-host "Satellite: $currentSat"
    write-host "Hyperdrive: $currentHD"

}

# Do the good thing or notify Satellite is needed
function updates-from-kuiper {
 
    $files = @(Get-ChildItem "C:\Program Files (x86)\Epic\Satellite")
    $files = $files | Sort-Object -Desc Name
    $executablePath = $files[0].FullName + "\Satellite.exe"
 
    if (Test-Path $executablePath -PathType Leaf) {
        Start-Process $executablePath -ArgumentList "/f /nps" -Wait
        }
    else {
        Write-Host "Satellite is not installed!" -ForegroundColor yellow
        Write-Host "Installing now..."
        New-Item -ItemType "directory" -Path "c:\support\install\" -Force
        copy-item $satInstall -Destination "c:\support\install\" -Force
        start-process "c:\support\install\SatelliteSetup.exe" -ArgumentList "/F" -wait -NoNewWindow
        pause
    }

}

# Run thrice incase Satellite needs updating too
clear-host
Write-host "Satellite & Kuiper update applier" -foregroundcolor yellow
$machine = hostname
write-host "Machine: $machine"
write-host ""
write-host "# Before running updates" -ForegroundColor cyan
    get-current-installs
    updates-from-kuiper
    updates-from-kuiper
    updates-from-kuiper
write-host ""
write-host "# After running updates" -ForegroundColor cyan
get-current-installs

# Good bye
write-host ""
write-host "Done. Have a great day!" -foregroundcolor green
pause
}
