$properties = @(
    @{n='TimeStamp';e={$_.TimeCreated}},
    @{n='User';e={$_.Properties[6].Value}},
    @{n='Reason/Application';e={$_.Properties[0].Value}},
    @{n='Action';e={$_.Properties[4].Value}}
)
Get-WinEvent -FilterHashTable @{LogName='System'; ID=1074} | 
Select $properties | Sort-Object "$_.TimeCreated"
