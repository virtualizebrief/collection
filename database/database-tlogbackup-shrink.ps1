# Install-Module -Name SqlServer # if doesn't exist
Import-Module SQLPS -Force

clear-host
$sqlServer = "ctx-database02"
$db = $null

$dbs = @(
"CitrixBlueLogging",
"CitrixBlueMonitoring",
"CitrixBlueSite",
"CitrixSessionRecording",
"CitrixSessionRecordingCloud",
"CitrixSessionRecordingLogging",
"CitrixSessionRecordingLoggingCloud",
"CitrixWEM",
"IgelUMS")

foreach ($db in $dbs) {

write-host "Processing $db..."

    If (Test-Path 'C:\Support\Backup\tlog.bak' -PathType Leaf) {Remove-Item -Path 'C:\Support\Backup\tlog.bak' -Force}   
    Backup-SqlDatabase -ServerInstance $sqlServer -Database $db -BackupAction Log -BackupFile 'C:\Support\Backup\tlog.bak' -Verbose 
    Invoke-Sqlcmd -ServerInstance $sqlServer -Query "DBCC SHRINKDATABASE('$db')" -Verbose

}
