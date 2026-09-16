<#

set-app-adgroups
 1. Get list of all Citrix apps
 2. Create AD Group (without spaces)
 3. Add AD Group to Citrix app
 
There is a 5 minute rest, without sometimes the AD Group
will not show to Citrx fast enough to add to app. 

#>

# Settings
$ou = "OU=Citrix,DC=MyDomain,DC=com"
$label = "CTX-"
$apps = (Get-BrokerApplication).Name

# Create AD Groups
foreach ($app in $apps) {
 
        $appNoSpace = $app.Replace(" ", "") # remove spaces
        $adGroup = $label + $appNoSpace # add CTX- infront

    write-host "Created AD Group " -NoNewLine
    write-host "$adGroup" -ForegroundColor yellow -NoNewline
    write-host "..." -NoNewline

        New-ADGroup -Name $adGroup -Path $ou -GroupCategory Security -GroupScope Global
    
    write-host "done!" -ForegroundColor green
}

# Rest so AD can catch up
write-host ""
write-host "Resting for 5 minutes..."
write-host ""
start-sleep -s 300

# Add AD Group to Citrix app
foreach ($app in $apps) {

    write-host "Add AD Group to app " -NoNewLine
    write-host "$app" -ForegroundColor yellow -NoNewline
    write-host "..." -NoNewline
    
        $appNoSpace = $app.Replace(" ", "") # remove spaces
        $adGroup = $label + $appNoSpace # add CTX- infront
        Add-BrokerUser -Application $app -Name $adGroup
    
    write-host "done!" -ForegroundColor green
}
