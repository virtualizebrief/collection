#-you set these
$userAssignment = "domain\adgroup"
$iconPath = "\\your\path\icons"
$clientFolder = "" #blank if not used
$description = "Cloud link Keywords:CloudLink"
Start-Process $iconPath

#------Name?-----
Add-PsSnapin Citrix*
Clear-Host
Write-Host "-------" -NoNewLine
Write-Host "Citrix PowerTools" -Foreground Cyan -NoNewLine
Write-Host "-------"
Write-Host ""
Write-Host "Create a Website Link in Studio" -ForegroundColor Cyan
Write-Host""
Write-Host "Default Selections" -ForegroundColor Green
Write-Host "Assignment Group: " -NoNewLine
Write-Host "$userAssignment" -ForegroundColor Yellow
Write-Host "Delivery Group: " -NoNewLine
Write-Host "$Delivery" -ForegroundColor Yellow
Write-Host "Catagory: "  -NoNewLine
Write-Host "$clientFolder" -ForegroundColor Yellow
Write-Host "Icon Path: "  -NoNewLine
Write-Host "$iconPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "----------------------------------"
Write-Host ""
$Delivery = Read-Host "Enter delivery group"
$appName = Read-Host "Enter Website Link Name or Q to exit"
If ($appName -eq "q"){exit}

#------Icon?-----
Clear-Host
Write-Host""
Write-Host "-= Create a Website Link in Studio =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Default Selections" -ForegroundColor Green
Write-Host "Assignment Group: " -NoNewLine
Write-Host "$userAssignment" -ForegroundColor Yellow
Write-Host "Delivery Group: " -NoNewLine
Write-Host "$Delivery" -ForegroundColor Yellow
Write-Host "Catagory: "  -NoNewLine
Write-Host "$clientFolder" -ForegroundColor Yellow
Write-Host "Icon Path: "  -NoNewLine
Write-Host "$iconPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Your Selections" -ForegroundColor Green
Write-Host "Link Name: "  -NoNewLine
Write-Host "$appName" -ForegroundColor Yellow
Write-Host ""
Write-Host "----------------------------------"
Write-Host ""
Write-Host "The icon name doesn't need the extension added and only accepts png files" -ForegroundColor Red
$iconName = Read-Host "Enter Icon Name"
$iconPNG = $iconName + ".png"

#------URL?-----
Clear-Host
Write-Host""
Write-Host "-= Create a Website Link in Studio =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Default Selections" -ForegroundColor Green
Write-Host "Assignment Group: " -NoNewLine
Write-Host "$userAssignment" -ForegroundColor Yellow
Write-Host "Delivery Group: " -NoNewLine
Write-Host "$Delivery" -ForegroundColor Yellow
Write-Host "Catagory: "  -NoNewLine
Write-Host "$clientFolder" -ForegroundColor Yellow
Write-Host "Icon Path: "  -NoNewLine
Write-Host "$iconPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Your Selections" -ForegroundColor Green
Write-Host "Link Name: "  -NoNewLine
Write-Host "$appName" -ForegroundColor Yellow
Write-Host "Icon Name: "  -NoNewLine
Write-Host "$iconPNG" -ForegroundColor Yellow
Write-Host ""
Write-Host "----------------------------------"
Write-Host ""
$citrixUrl = Read-Host "Enter URL (ie: https://www.citrix.com)"

#------Confirmation-----
Clear-Host
Write-Host""
Write-Host "-= Create a Website Link in Studio =-" -ForegroundColor Cyan
Write-Host""
Write-Host "Default Selections" -ForegroundColor Green
Write-Host "Assignment Group: " -NoNewLine
Write-Host "$userAssignment" -ForegroundColor Yellow
Write-Host "Delivery Group: " -NoNewLine
Write-Host "$Delivery" -ForegroundColor Yellow
Write-Host "Catagory: "  -NoNewLine
Write-Host "$clientFolder" -ForegroundColor Yellow
Write-Host "Icon Path: "  -NoNewLine
Write-Host "$iconPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Your Selections" -ForegroundColor Green
Write-Host "Link Name: "  -NoNewLine
Write-Host "$appName" -ForegroundColor Yellow
Write-Host "Icon Name: "  -NoNewLine
Write-Host "$iconPNG" -ForegroundColor Yellow
Write-Host "Website URL: "  -NoNewLine
Write-Host "$citrixUrl" -ForegroundColor Yellow
Write-Host ""
Write-Host "----------------------------------"
Write-Host ""
Read-Host -Prompt "Press any key to create the website link or CTRL+C to quit"

#-----Create App--------
$ctxIcon = Get-BrokerIcon -FileName "$iconPath\$iconPNG" -index 0
$brokerIcon = New-BrokerIcon -EncodedIconData $ctxIcon.EncodedIconData
$dg = Get-BrokerDesktopGroup –Name $delivery

New-BrokerApplication –ApplicationType PublishedContent –CommandLineExecutable $citrixURL –Name $appName –DesktopGroup $dg.Uid -IconUid $brokerIcon.Uid -ClientFolder $clientFolder -Description $description -UserFilterEnabled $True
Add-BrokerUser $userAssignment -Application $appName
Pause
