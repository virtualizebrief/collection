$machine = "machine-name"

Function Get-RebootHistory {

    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]  $ComputerName = $machine,

        [int]       $DaysFromToday = 365,

        [int]       $MaxEvents = 9999
    )

    BEGIN {}

    PROCESS {
        foreach ($Computer in $ComputerName) {
            try {
                $Computer = $Computer.ToUpper()
                $EventList = Get-WinEvent -ComputerName $Computer -FilterHashtable @{
                    Logname = 'system'
                    Id = '1074', '6008'
                    StartTime = (Get-Date).AddDays(-$DaysFromToday)
                } -MaxEvents $MaxEvents -ErrorAction Stop


                foreach ($Event in $EventList) {
                    if ($Event.Id -eq 1074) {
                        [PSCustomObject]@{
                            TimeStamp    = $Event.TimeCreated
                            ComputerName = $Computer
                            UserName     = $Event.Properties.value[6]
                            ShutdownType = $Event.Properties.value[4]
                        }
                    }

                    if ($Event.Id -eq 6008) {
                        [PSCustomObject]@{
                            TimeStamp    = $Event.TimeCreated
                            ComputerName = $Computer
                            UserName     = $null
                            ShutdownType = 'unexpected shutdown'
                        }
                    }

                }

            } catch {
                Write-Error $_.Exception.Message

            }
        }
    }

    END {}
}

Get-RebootHistory
