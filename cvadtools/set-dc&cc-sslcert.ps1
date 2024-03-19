Write-Host "Configure SSL for Citrix Delivery Controller or Cloud Connector..."
Pause

#-Clear existing thing
netsh http delete sslcert ipport=0.0.0.0:443

#-Settings
$fqdnName = [System.Net.Dns]::GetHostByName((hostname)).HostName
$cnEntry = "CN=ctxcloudconnector"
# $cnEntry = "CN=" + $fqdnName
$citrixBroker = (WmiObject -Class Win32_Product | Where-Object Name -match 'Citrix Broker Service').IdentifyingNumber
$thumbPrint = (Get-ChildItem -Path Cert:LocalMachine\MY | Where-Object {$_.Subject -like "$cnEntry*"}).Thumbprint

#-Apply cert for delivery controller or cloud connector
netsh http add sslcert ipport=0.0.0.0:443 certhash=$thumbPrint appid="$citrixBroker"

#-Results
netsh http show ssl