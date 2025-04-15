cls
@echo off
title Citrix Application Launcher
mode 75,15

@echo Real Print Manager
@echo Loading application. This could take a second...

powershell.exe -ExecutionPolicy Bypass -File "\\server\realprint\realprint-manager.ps1"
