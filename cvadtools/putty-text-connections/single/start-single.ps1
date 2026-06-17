#------apply custom settings
reg import \\server\path\putty-text-connections\custom-settings.reg

#------start ssh session
start-process "C:\Program Files\PuTTY\putty.exe" -ArgumentList "-load `"MyENV`""
