$dgs = (Get-BrokerDesktopGroup).name
$user = "yourdomain\domain users"

forEach ($dg in $dgs){

  Get-BrokerAccessPolicyRule -DesktopGroupName $dg | Set-BrokerAccessPolicyRule -IncludedUsers $user -AllowedUsers Filtered

}

Pause
exit
