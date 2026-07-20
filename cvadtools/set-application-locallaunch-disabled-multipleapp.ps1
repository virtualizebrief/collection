<#

    # Get list of applications that have local launch turned on to disable below
    $apps = (get-brokerApplication -LocalLaunchDisabled $false).ApplicationName
    
#>

# Manual list of apps to disable local launch
$apps = @(
"App01"
"App02"
"App03"
"App04"
"App05"
)

foreach ($app in $apps) {
    if (get-brokerapplication -name $app -ErrorAction SilentlyContinue) {
    
        set-brokerApplication -Name $app -LocalLaunchDisabled $true
        write-host "Local launch disabled " -NoNewline -ForegroundColor green
        write-host "$app"

        }
    else {
    
        write-host "notfound " -NoNewline -ForegroundColor Red
        write-host "$app" 
        
        }
}

write-host ""
pause
