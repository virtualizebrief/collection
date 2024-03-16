#-you set
$CustomerId = "customer"
$SecureClientFile = “c:\your\path\secureclient.csv”

#-do the thing and get results
Set-XDCredentials -CustomerId $CustomerId -SecureClientFile $SecureClientFile -ProfileType CloudAPI –StoreAs “default”
Get-XDCredentials -ListProfiles
