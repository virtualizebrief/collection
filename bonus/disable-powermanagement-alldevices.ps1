<#

Removes check mark for allowing power management of devices on windows endpoints. They never sleep.

#>

# Dynamic power devices
$powerMgmts = Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root/WMI

# All USB devices
$UsbDevices = Get-CimInstance -ClassName Win32_PnPEntity -Filter 'PNPClass = "USB"'

$powerMgmts | ForEach-Object {
    # Get the power management instance for this device, if there is one
    $powerMgmt | Where-Object InstanceName -Like "*$($_.PNPDeviceID)*"
} | Set-CimInstance -Property @{Enable = $false}

# Results
Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root/WMI
