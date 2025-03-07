<#

Date: 2025.03.07
Author: Michael Wood

# Get Citrix Director / Monitor Session Failures
Deduplicates entries by username (which Director does not)

#>

# Collect session info
Clear-Host
$site = (get-brokersite).name
$when = [DateTime]::Now - [TimeSpan]::FromMinutes(60)
$results = "no results..."
$results = Get-BrokerConnectionLog -MaxRecordCount 1000000 -Filter {BrokeringTime -gt $when -and ConnectionFailureReason -ne 'None' -and ConnectionFailureReason -ne $null} | 
 Where-Object ConnectionFailureReason -ne none | 
  Select-Object BrokeringUserUPN,MachineDNSName,ConnectionFailureReason,BrokeringTime |
   Sort-Object -Unique BrokeringUserUPN |
    format-table
$count = ($results | select BrokeringUserUPN | measure).count
$sessions = (Get-BrokerSession -SessionState Active -MaxRecordCount 100000).count

# Output results on screen
write-host "---------------------------------------"
write-host "Citrix Monitor" -foregroundcolor cyan
write-host "Results are deduplicated by username" -ForegroundColor yellow -nonewline
get-date
write-host "Site: $site"
write-host "---------------------------------------"
write-host "Statistics" -foregroundcolor cyan
write-host "- Unique User Failures: " -nonewline
write-host "$count" -foregroundcolor red
write-host "- Sessions Connected  : " -nonewline 
write-host "$sessions" -foregroundcolor green
write-host "---------------------------------------"
$results
pause---------"
$results
pause
