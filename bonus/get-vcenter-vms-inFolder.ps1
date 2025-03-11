# You config source folder & vcenter(s)
$sourceFolder  = "MyFolder"
$sourceVCs = @(
"myvcenter01.domain.com",
"myvcenter02.domain.com"
)

# Username & password
$vUser     = Read-Host "Enter vCenter username"
$vPassword = Read-Host "Enter vCenter password"  -AsSecureString
$vPasswordPlain =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($vPassword))

# Install powercli if not found
if (-not (Get-Module -ListAvailable -Name VMware.PowerCLI)) {
    if ((Get-PSRepository -Name PSGallery).InstallationPolicy -ne 'Trusted') {Set-PSRepository -Name PSGallery -InstallationPolicy Trusted}
    Install-Module -Name VMware.PowerCLI -Scope CurrentUser -Force -ErrorAction Stop
}

foreach ($sourceVC in $sourceVCs) {
# Get VMs from soure folder
$noShow  = Connect-VIServer -Server $sourceVC -User $vUser -Password $vPasswordPlain -ErrorAction Stop
$vmNames = get-vm -server $sourceVC -location $sourceFolder | sort-object name
$noShow  = Disconnect-VIServer -Server * -Force -Confirm:$false

# Output results on screen
write-host "$sourceVC" -ForegroundColor cyan
write-host "Found VMs in folder $sourceFolder" -ForegroundColor yellow
($vmNames).name
write-host ""
}

pause
