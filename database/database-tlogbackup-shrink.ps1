<#

Quick way to shrink transaction logs on MS SQL Server.

- Checks if backup file exist, if yes delete
- Performs transaction log backup
- Performs a shrink transaction log bucket size

#>

$getDate = Get-Date -format "yyyyMMdd-hhmmss"
$logFile = "c:\support\log\database-tlogbackup-shrink-$getDate.log"

function database-tlogbackup-shrink() {

# Install-Module -Name SqlServer # if doesn't exist
Import-Module SQLPS -Force

clear-host
$sqlServer = hostname
# $dbs = "CitrixBlueSite"

$dbs = @(
"db1",
"db2"
)

foreach ($db in $dbs) {

    write-host "Processing $db..." -ForegroundColor yellow -nonewline
        If (Test-Path 'C:\Support\Backup\tlog.bak' -PathType Leaf) {Remove-Item -Path 'C:\Support\Backup\tlog.bak' -Force}   
        Backup-SqlDatabase -ServerInstance $sqlServer -Database $db -BackupAction Log -BackupFile 'C:\Support\Backup\tlog.bak' 
    write-host "done!" -foregroundcolor green 

    write-host "Resting before shrinking..." -ForegroundColor cyan -nonewline
    start-sleep -s 10
    Invoke-Sqlcmd -ServerInstance $sqlServer -QueryTimeout 0 -Query "DBCC SHRINKDATABASE('$db')"
    write-host "done!" -foregroundcolor green 
    write-host ""

}

}

database-tlogbackup-shrink | Out-File -FilePath $logFile
database-tlogbackup-shrink | Out-File -FilePath $logFile
