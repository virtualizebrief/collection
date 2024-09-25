# settings you configure. enter a delivery controller per site.

$sites = @(
"deliverycontroller-site1.domain.com",
"deliverycontroller-site2.domain.com")

# ad group to check

clear-host
write-host "Powertools" -ForegroundColor cyan
write-host "Checking ad group entitlments" -ForegroundColor yellow
write-host ""
$adgroup = read-host "Enter ad group to check"

clear-host

write-host "Powertools" -ForegroundColor cyan
write-host "Checking ad group entitlments" -ForegroundColor yellow
write-host "For: " -nonewline
write-host "$adgroup" -ForegroundColor green
write-host ""

foreach ($site in $sites) {

$name = (get-brokersite -AdminAddress $site).name

write-host "# $name" -ForegroundColor Cyan
write-host "---" -ForegroundColor yellow

    (get-brokerapplication -adminaddress $site -maxrecord 9999 | where-object AssociatedUserFullNames -match $adgroup).Name | Sort-Object

write-host "---" -ForegroundColor yellow
write-host ""

}
