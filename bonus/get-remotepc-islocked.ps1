Clear-host

$device = read-host "Enter computername"
write-host ""
write-Host "$device " -NoNewline -ForegroundColor Cyan

invoke-command -ComputerName $device -ScriptBlock {


$process = (get-process -name logonui).id

    if ($process -ne $null)
    {write-host "screen is locked"}
    else 
    {write-host "it's not locked"}

}