#-you configure these settings
$site1dc = "site1controller"
$site2dc = "site2controller"
$maxSessions = "1400" #your-license-count

#-welcome
clear-host
Write-host ""
write-host "Powertools" -ForegroundColor cyan
write-host " Citrix license count for concurrent users"
write-host " note: does not include Citrix cloud site" -foregroundcolor yellow
write-host " Available concurrrent license count: $maxSessions" -ForegroundColor green
write-host " $time"
write-host ""
write-host "Results" -foregroundcolor Cyan

#-do the thing
$site1name = (Get-BrokerSite -AdminAddress $site1dc).name
$site1 = ((Get-BrokerSession -AdminAddress $site1dc -MaxRecordCount 10000).BrokeringUserName  | Sort-Object | Get-Unique).count
$site1Users = (Get-BrokerSession -AdminAddress $site1dc -MaxRecordCount 10000).BrokeringUserName  | Sort-Object | Get-Unique
$site2name = (Get-BrokerSite -AdminAddress $site2dc).name
$site2 = ((Get-BrokerSession -AdminAddress $site2dc -MaxRecordCount 10000).BrokeringUserName  | Sort-Object | Get-Unique).count
$site2Users = (Get-BrokerSession -AdminAddress $site2dc -MaxRecordCount 10000).BrokeringUserName  | Sort-Object | Get-Unique

$UniqueUsers = $site1Users + $site2Users
$trueUniqueUsers = ($UniqueUsers | Sort-Object | Get-Unique).count
$time = get-date

If ($trueUniqueUsers -gt $maxSessions){$warning = "red"}
If ($trueUniqueUsers -eq $maxSessions){$warning = "yellow"}
If ($trueUniqueUsers -lt $maxSessions){$warning = "green"}

#-results
write-host " * $site1name site: $site1"
write-host " * $site2name site: $site2"
write-host " Total concurrent users: " -nonewline
write-host "$trueUniqueUsers" -ForegroundColor $warning
write-host ""
pause
write-host ""
write-host ""
