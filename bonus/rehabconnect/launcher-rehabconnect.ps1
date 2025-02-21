# You configure these
$sourceRoot = "\\server\path\"
$destinationRoot = "c:\vda\apps\"
$exe = "\Netsmart.RehabConnect.exe"

# Get file and path then copy if doesn't exist
$currentRelease = ((get-childitem -path $sourceRoot -directory | where-object Name -like "RehabConnect*")).name
$sourcePath = $sourceRoot + $currentRelease
$destinationPath = $destinationRoot + $Env:UserName + "\" + $currentRelease
$executableFile = $destinationPath + $exe

if (!(Test-Path -Path $destinationPath -PathType Container)) {
    Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse
}

# Run app
Start-Process $executableFile -WorkingDirectory $destinationPath

# Good-bye
Stop-Process -Id $Pid -Force
 -Id $Pid -Force
