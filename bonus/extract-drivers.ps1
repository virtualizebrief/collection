# Define the destination folder for extracted drivers
$destinationPath = "C:\Support\Drivers"
New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null

# Get all installed drivers
$drivers = Get-WindowsDriver -Online

foreach ($driver in $drivers) {
    # Get the driver folder path from OriginalFileName
    $infPath = $driver.OriginalFileName
    if ($infPath -and (Test-Path $infPath)) {
        # Get the parent folder of the .inf file
        $driverFolder = Split-Path $infPath -Parent
        $driverName = $driver.Driver
        $providerName = $driver.ProviderName -replace '[<>:"/\\|?*]', '_' # Clean provider name for folder

        # Create a subfolder in the destination for this driver
        $driverDestPath = Join-Path $destinationPath "$providerName\$driverName"
        New-Item -ItemType Directory -Path $driverDestPath -Force | Out-Null

        # Copy all files in the driver folder to the destination
        Copy-Item -Path "$driverFolder\*" -Destination $driverDestPath -Recurse -Force
        Write-Host "Extracted driver: $driverName from $providerName to $driverDestPath"
    }
    else {
        Write-Warning "Driver path not found for: $driverName"
    }
}

Write-Host "Driver extraction completed. Files saved to $destinationPath"
