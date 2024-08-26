<#

Quick way to shrink transaction logs on MS SQL Server.

- Checks if backup file exist, if yes delete
- Performs transaction log backup
- Performs a shrink transaction log bucket size

#>

# Variables
$sqlServer = "db-server"
$backupFile = "C:\Support\Backup\tlog.bak"
$dbs = @(
"database1",
"database2",
"database3")

# Perform the work againest each database
foreach ($db in $dbs) {
write-host "Processing $db..."

    If (Test-Path $backupFile -PathType Leaf) {Remove-Item -Path $backupFile -Force}   
    Backup-SqlDatabase -ServerInstance $sqlServer -Database $db -BackupAction Log -BackupFile $backupFile -Verbose 
    Invoke-Sqlcmd -ServerInstance $sqlServer -Query "DBCC SHRINKDATABASE('$db')" -Verbose

}
