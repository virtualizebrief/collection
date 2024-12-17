$dns = 'subdomain'
$newip = 'x.x.x.x'
$domain = 'yourdomain.com'

$old = Get-DnsServerResourceRecord -ZoneName $domain -Name $dns
$new = $old.Clone()
$new.RecordData.IPv4Address = [System.Net.IPAddress]::parse($newip)

Get-DnsServerResourceRecord -ZoneName $domain -Name $dns
Set-DnsServerResourceRecord -NewInputObject $new -OldInputObject $old -ZoneName $domain
Get-DnsServerResourceRecord -ZoneName $domain -Name $dns
