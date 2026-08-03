$ak = ""
$pk = ""
$dir = "\\lcmchealth.org\epic\EpicShare\Kuiper\files\install\"
$exe = "SatelliteSetup.exe"
$arg = "/I C:\ /H kuiper.lcmchealth.org /IT NP /AK $ak /PK $pk"

write-host ""
write-host ""
write-host "Now installing Satellite | Production"
write-host "if box comes up hit: yes."
write-host ""

start-process ($dir + $exe) -ArgumentList $arg

write-host ""
write-host "completed!"
write-host ""

pause
