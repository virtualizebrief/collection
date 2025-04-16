Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root/WMI | Set-CimInstance -Property @{Enable = $false}
