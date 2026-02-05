clear-host

$user = 'first.last'

while ($true) {

$locked = (get-aduser -identity $user -properties *).lockedout
$time = Get-Date -Format G
write-host "$time Locked? $locked"

if ($locked -eq 'True'){

    unlock-adaccount -identity $user
    write-host "$time Locked? Fixed!" -foregroundcolor green

    }

start-sleep -s 300

}
