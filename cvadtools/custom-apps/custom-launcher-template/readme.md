# How to create Citrix app launch with custom settings

## Create powershell file

```
# start application
Start-Process "C:\Support\App\Runme.exe" -wait

# End me
tsdiscon
start-sleep -s 5
logoff
start-sleep -s 5
Stop-Process -Id $Pid -Force
```

## Create Citrix app
- Path to executable file: C:\Windows\System32\conhost.exe
- Command line argument: --headless powershell.exe -file \\server\folder\myapp.ps1

