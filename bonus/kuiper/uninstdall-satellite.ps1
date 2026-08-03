$ver = (Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object DisplayName -like "Epic Satellite").DisplayVersion
$exe = "C:\Program Files (x86)\Epic\Satellite\" + $ver + "\Satellite.exe"
$arg = "/x /d"

start-process $exe -ArgumentList $arg
