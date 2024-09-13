![image](images/icon-storehouse.png)

# Storehouse
Documentation website using markdown files. This simple deployment for a Windows computer takes you from nothing to up and running in a minute or two.

# Retype
Work engine for producing Storehouse. Information on creating pages, components, images, video and more found here: retype components

# Deploy
|Feature|Name|Note|
|:---|:---|:---|
|Logo|icon-storehouse.png|Copy file to: c:\support\storehouse\site\files|
|Scheduled task|Start Storehouse|Edit Start Storehouse selecting a user or service account that has admin privileges on the machine.|
|Storage|c:\support\storehouse\site|Where to put documents, etc.|
|Wesbite URL|http://localhost:5000 |Should put a cert and configure friendly url in dns.|

# Windows deployment code
[deploy-retype-storehouse.ps1](deploy-retype-storehouse.ps1)
