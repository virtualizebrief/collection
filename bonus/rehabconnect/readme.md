[![Watch the video](https://github.com/virtualizebrief/collection/blob/main/bonus/rehabconnect/vb-rehabconnect-customlauncher-thumbnail.png?raw=true)](https://www.youtube.com/watch?v=cnCXPuFStSc)
Click to watch video on how to setup.

# RehabConnect custom launcher
> [!TIP]
> Designed for use with Citrix Virtual Apps & Desktops. Though can work for other delivery methods: create a shortcut off the .bat file and launch from anywhere.


Each time a user launches RehabConnect the following will happen:

- Launch message window letting people know app is loading
- Get file & path information dynamically
- Check if personal folder for RehabConnect exist on machine
- If no: copy files, if: yes skip copy
- Run RehabConnect & close message window

# Launcher files
Find unc path or network location for files in a folder named `RehabConnect`. 

- launcher-rehabconnect.bat
- launcher-rehabconnect.ps1

Edit bat file to put your path. Edit ps1 `# You configure these` settings.

# Download RehabConnect
[RehabConnect downloader](https://npc-prodoc.udsmr.org/NTST_LCMC/NTST.RehabConnect.Windows/Netsmart.RehabConnect.application)

Place a copy of app as subfolder inside `RehabConnect` folder. Name it RehabConnect* or how I do with a date: RehabConnect-20250221. This helps keep tract of knowing the release and download date in use.

# Citrix application
Create an app and use the following settings:

| Setting | Value |
| :---      | :---       |
| Path to exe | \\server\path\RehabConnect\launcher-rehabconnect.bat |
| Argument | (blank) |
| March | \\server\path\RehabConnect\ |

