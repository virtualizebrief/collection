$TrueLists = "Get list from somewhere"
$userinfo = "Your name, any name, or get-name"
 
$JSONBody = [PSCustomObject][Ordered]@{
    "@type" = "MessageCard"
    "@context" = "<http://schema.org/extensions>"
    "themeColor" = '0078D7'
    "title" = "Citrix Machines Busted"
    "text" = "`n
    $TrueLists
     
    Have a great rest of your day!
 
    $userinfo
    Citrix Greatness Team
    Email: team@company.com
    `n"
    }
 
$TeamMessageBody = ConvertTo-Json $JSONBody
 
$parameters = @{
    "URI" = "..."
    "Method" = 'POST'
    "Body" = $TeamMessageBody
    "ContentType" = 'application/json'
    }
 
Invoke-RestMethod @parameters