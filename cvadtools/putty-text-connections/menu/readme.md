# Menu for Putty Text Connections

Provide a menu with ssh connections. Multiple can be launched and manage from a single pain of glass.

![image](https://github.com/virtualizebrief/collection/blob/main/cvadtools/putty-text-connections/putty-text-connections01.png)

## Citrix application publishing

- Path to executable: `C:\Windows\System32\conhost.exe`
- Command line argument: `--headless powershell.exe -file \\server\path\putty-text-connections\start-menu.ps1`
- Working director: {empty}

## Setup custom registry settings

- file: custom-settings.reg

In Putty make all the connections you'd like. Make sure to accept the cert warnings (so users don't have to). Then export the following registry key as the file name custom-settings.reg:

- `HKEY_CURRENT_USER\Software\SimonTatham\PuTTY`

## Menu system: start-menu.ps1

Customize the menu to your liking maching each ssh connection with a nice name and explanation.

## Conclusion

When running production.ps1 for each lauch users will apply these custom settings to their putty session and be able to select any given connection and be prompted for their user name and password. No one needs to know the server names, ip address, port or anything about how to use ssh.
