#------apply custom settings

reg import \\server\path\putty-text-connections\custom-settings.reg
$User = $env:UserName
Set-Location "C:\Program Files\PuTTY"

#------start ssh session

start-process .\putty.exe -ArgumentList "-load `"MyENV`""
