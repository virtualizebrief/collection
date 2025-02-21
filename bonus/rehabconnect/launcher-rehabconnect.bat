cls
@echo off
title Citrix Application Launcher
mode 75,15

@echo RehabConnect
@echo Loading application. This could take a minute...

powershell.exe -ExecutionPolicy Bypass -File "\\server\path\RehabConnect\launcher-rehabconnect.ps1"
