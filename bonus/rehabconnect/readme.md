# RehabConnect custom launcher
> [!TIP]
> Designed for use with Citrix Virtual Apps & Desktops. Though can work for other delivery methods also.


No matter how many machines you publish the application off of each time a user launches RehabConnect the following will happen:

- Launch message window letting people know app is loading...
- Get file and path information dynamically
- Check if personal folder for RehabConnect exist on machine
- If no: copy files, if: yes skip copy
- Run RehabConnect
- Close message window

# File
Find a unc path or network location to put the files in a folder named something like `RehabConnect`. Edit each file to put in your unc path.

- launcher-rehabconnect.bat
- launcher-rehabconnect.ps1

# Download RehabConnect
[RehabConnect downloader](https://npc-prodoc.udsmr.org/NTST_LCMC/NTST.RehabConnect.Windows/Netsmart.RehabConnect.application)

Put a copy of this app as a subfolder inside `RehabConnect` folder. Name it RehabConnect* or like I do with a date: RehabConnect-20250221. This helps keep tract of knowing the release and download date in production.

# Citrix application
Create an app and use the following settings:

| | |
| :---      | :---       |
| Path to exe | \\server\path\RehabConnect\launcher-rehabconnect.bat |
| Argument | (blank) |
| March | \\server\path\RehabConnect\ |
