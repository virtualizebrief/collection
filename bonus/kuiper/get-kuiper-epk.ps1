# Create epk to registered with Kuiper
function get-current-hyperdrive {

    $verHD = @(Get-ChildItem "C:\Program Files (x86)\Epic\Hyperdrive\100*")
    $verHD = $verHD | Sort-Object -Desc Name
    $currentHD = $verHD[0].Name

    write-host "Hyperdrive : $currentHD"

}

$folder = "\\lcmchealth.org\epic\EpicShare\Kuiper\tools\epk-files"
$machine = hostname
$domain = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain
get-current-hyperdrive
set-location "C:\Program Files (x86)\Epic\Hyperdrive\$currentHD\Bin\Core\win-x86"
.\EnsureCertificates.exe > $folder\$machine@$domain.epk

write-host "Output file: $folder\$machine@$domain.epk"
write-host ""
pause
