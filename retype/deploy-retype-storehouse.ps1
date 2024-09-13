# install chocolatey, nodejs, retype
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install nodejs.install -y -f
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv
npm install retypeapp --global

# create retype files and folder structure
if (!(Test-Path -Path c:\support)){new-item -path c:\support -itemtype director}
if (!(Test-Path -Path c:\support\storehouse)){new-item -path c:\support\storehouse -itemtype director}
if (!(Test-Path -Path c:\support\storehouse\site)){new-item -path c:\support\storehouse\site -itemtype director}
if (!(Test-Path -Path c:\support\storehouse\site\files)){new-item -path c:\support\storehouse\site\files -itemtype director}

new-item -path c:\support\storehouse\start-storehouse.ps1 -ItemType File -Force
set-content -path c:\support\storehouse\start-storehouse.ps1 -Value "retype start c:\support\storehouse\site"

new-item -path c:\support\storehouse\site\readme.md -ItemType File -Force
set-content -path c:\support\storehouse\site\readme.md -Value '---
icon: home
label: Home
---

<!-- # ![](/files/banner-storehouse2.png) -->

!!!success
:partying_face: New and improved [!button size="xs" text="v2.0"]
!!!
 Welcome

Place to find documentations on topics. Now with improved features!

- Global and menu search
- Replaced bookstack with retype
- Bookmarks page [!badge icon="info" text="Learn more"](bookmarks.md)

 Support

Do you have a technical support question, found a defect, or would like to make a feature request? Please create an issue and we will investigate right away.

We &hearts; feedback.

[!button icon="mail" text="Contact"](contact.md)

'

new-item -path c:\support\storehouse\site\retype.yml -ItemType File -Force
set-content -path c:\support\storehouse\site\retype.yml -Value '

 # -

poweredByRetype: true         # Set to false to remove "Powered by Retype"
                              # A Retype Pro license is required
                              # See: https://retype.com/pro

# -

input: C:\Support\storehouse\site                      # Local path from this retype.yml file to the
                              # root of your project content files
                              # See also: output

# -

output: C:\Support\storehouse\.storehouse               # Custom path to the output directory
                              # See also: input

# -

# url: example.com              # The base URL of your website
# url: docs.example.com         # Can also be a sub-domain
# url: example.com/docs         # Can also include a sub-folder path
# url: https://example.com/docs # Can also include a protocol

# -

branding:
  title: Storehouse # Your custom website title; keep it short
  logo: /files/icon-storehouse.png             # Path to a logo file
  logoDark: /files/icon-storehouse.png    # Path to a logo file to use in dark mode
  # logoAlign: right            # Align the logo to the right or the left
  label: v2.0                 # Optional label
                              # To remove the label, remove this config
  colors:
    label:                    # Label colors
      text: "#ffffff"         # Custom color for the label text
      background: "#375A8F"   # Custom color for the label background

# -

links:                        # Custom links to add to the top bar
                              # See also: footer.links
  - text: Bookmarks                # The text to use for the link
    link: bookmarks.md # Link to an internal file or external URL
    icon: bookmark
    # target: blank

  - text: Issues                # The text to use for the link
    link: issues.md # Link to an internal file or external URL
    icon: comment-discussion
    target: blank

  - text: Contact                # The text to use for the link
    link: contact.md # Link to an internal file or external URL
    icon: mail

# -

footer:
  copyright: "Made with &hearts; by Virtualize Brief" # A custom copyright statement
  links:                      # A list of links to include in the footer
                              # See also: links
    # - text: Learn more           # The text to use for the link
    #   link: https://virtualizebrief.com    # Point to an internal file or external URL

# -

cache:
  # busting: query              # Cache busting strategy
                              # Options: none | path | query (default)

# -

cname: example.com            # The CNAME file value
                              # or, false to not create a CNAME file

# -

edit:
  repo: ""                    # The URL to source files for this project
  base: ""                    # Optional base path to a directory within repo
  branch: ""                  # Point to a custom branch within the repo
  label: "Edit this page"     # A custom label for the generated link

# -

editor:                       # Configure the page live editor functionality
                              # that is only available during `retype start`
  enabled: false               # false to disable and hide the live editor

# -

exclude:                      # Files or folders to exclude from the build
                              # See also: include
  - "*_temp/"                 # Wildcards are valid
  - "/src/temp.md"            # Exclude a specific file

# -

favicon: /files/icon-storehouse.png   # Path to a custom favicon, or
                              # just put a favicon.ico in your project root

# -

generator:
  recase: all                 # `none` to not recase any file or folder names
                              # By default, all generated file and folder names
                              # are generated in all lowercase

# -

include:                      # Files or folders to include in the build
                              # See also: exclude
  - "*.py"                    # Wildcards are valid

# -

integrations:
  googleAnalytics:
    id: ""                    # Your Google Analytics measurement id
  googleTagManager:
    id: ""                    # Your Google Tag Manager measurement id
  gravatar:
    enabled: true             # false to disable using Gravatar images
    default: mp               # What Gravatar profile image to use
  plausible:                  # Plausible.io integration
    domain: domain1.com,domain2.com # Your plausible domain(s)
    host: plausible.example.com     # Custom Plausible host name

# -

markdown:                     # Markdown configuration options
  lineBreaks: soft            # Switch between `soft` and `hard` line breaks

# -

meta:
  title: " | Storehouse"         # Appended to the <title> element on all pages

# -

search:                       # Custom configuration of the website search
  hotkeys:
    - "/"                     # Keyboard key to set focus in the search field
                              # Default is "k"
  maxResults: 20              # Max number of search results to render
  minChars: 2                 # Min characters required to trigger a search
  mode: full                  # The search index creation mode
                              # Options include: full | partial | basic
  noResultsFoundMsg: "No results" # Message when no results are found
  placeholder: Search         # Placeholder text used in the input field

# -

serve:
  host: localhost             # Serve the website from this host location
  # host: 127.0.0.1:5005        # Custom port also supported
  port: 5000                  # Custom port configured separately from host
  watch:
    mode: disk              # Where to host files from during retype watch
                              # Options include: memory (default) | disk
    polling: true             # How Retype will listen for file changes
                              # Options: false (default) | true | number
    validation: optimal       # How thorough Retype is looking for file changes
                              # Options: fast | full | optimal (default)

# -

start:
  open: false                 # Do not automatically open web browser on start

# -

snippets:                     # Custom code snippets configuration
                              # See: https://retype.com/components/code-snippet
  lineNumbers:                # Language shortcodes to enable line numbering on
    - js
    - none                    # `none` to disable line-numbering on snippets

# -

templating:
  enabled: true               # Enable or disable the Retype content templating
  liquid: false               # Is Liquid syntax {% ... %} enabled?
                              # If true, Retype is incompatible with the
                              # GitBook style of component configuration

'

# create schedule task to run storehouse at machine startup
$Trigger = New-ScheduledTaskTrigger -AtStartup
$User = "NT AUTHORITY\SYSTEM" # Specify the account to run the script
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-command `"retype start c:\support\storehouse\site`""
Register-ScheduledTask -TaskName "Start Storehouse" -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force

# start storehouse and launch browser to see success
start-job -ScriptBlock {retype start c:\support\storehouse\site}
start-sleep -s 6
start-process "http://localhost:5000/"
