###########################################################################################################################################################
#
#                                                             Get device launch application
#                                                                  Michael Wood 2021
#                                                                 updated: 2025.04.16
#
#  This app will check to see if any of the following credit card readers are attached to the computer:
#  - Verifone
#  - IDTech SREDKey
#  - Ingenico IPP350 / Com Port
#  - Ingenico IPP350 / HID USB
#
#  If one of these is found the following actions will be take:
#  1. Close existing Trusted Commerce App if already open (to ensure the newly launched app connects to the right card reader).
#  2. Open new Trusted Commerce App.
#  3. Log file is created in c:\support\file.log
#
#  If no credit card reader is found no:
#  1. Trusted Commerce App is closed (if its open)
#
###########################################################################################################################################################

function ipa5 {

    Write-Host "IPA5 | Verifone P200" -ForegroundColor Green
    Stop-Process -Name TCIPA.AppManager
    Stop-Process -Name TCIPA.DAL
    Set-Location "C:\TrustCommerce\TCIPADAL\launcher"
    Start-Process "C:\TrustCommerce\TCIPADAL\launcher\TCIPA.AppManager.exe"

}

function ipa4 {

    Write-Host "IPA4 | Ingenico IPP350 / Com Port & HID USB or IDTech SREDKey" -ForegroundColor Green
    Stop-Process -Name TCIPAAppManager
    Stop-Process -Name TCIPADAL
    Set-Location "C:\TrustCommerce\TCIPADAL"
    Start-Process "C:\TrustCommerce\TCIPADAL\TCIPAAppManager.exe"

}

Clear-Host
Write-Host      "Checking for Credit Card Reader..." -ForegroundColor Yellow
$GetDate        = Get-Date -format "yyyyMMddThhmm"
$Logfile        = "C:\Support\device-creditcard.log"
Sleep 5
$data           = (get-wmiobject -Class win32_pnpentity)
$deviceIPA5     = ($data -match 'VID_11CA&PID_0300')
$deviceIPA4     = ($data -match 'VID_0ACD&PID_26') -or ($data -match 'VID_0B00&PID_0060') -or ($data -match 'VID_0B00&PID_0072')

# IPA5 | Verifone P200
If ($deviceVerifone)
  {

    ipa5
    Add-Content -Path $LogFile -Value "$GetDate - Verifone Found!"
  
  }

# IPA4 | Ingenico IPP350 / Com Port & HID USB or IDTech SREDKey
ElseIf ($deviceIPA4)
  {

    ipa4
    Add-Content -Path $LogFile -Value "$GetDate - IDTech SREDKey Found!"
  
  }

# No credit card reader
Else
{

    Write-Host "No Credit Card Reader Found!" -ForegroundColor Red
    Stop-Process -Name TCIPAAppManager
    Stop-Process -Name TCIPADAL
    Add-Content -Path $LogFile -Value "$GetDate - No Credit Card Reader Found!"

}

Stop-Process -Id $Pid -Force
