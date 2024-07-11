$ListofVMs=get-BrokerDesktop -DesktopGroupName “Remote PC Access”
ForEach($VM in $ListofVMs)
{
$Split=$VM.MachineName.Split(‘\’)
$HostName=$Split[1]
Set-BrokerPrivateDesktop -MachineName $VM.MachineName -PublishedName $HostName
}