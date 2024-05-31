#!/bin/bash

# Variables
USERNAME="myname"
PASSWORD="mypassword"

# Sleep for 20 secs
sleep 20

# Type the username
xdotool type "$USERNAME"

# Press Tab to move to the next input field
xdotool key Tab

# Type the password
xdotool type "$PASSWORD"

# Press Enter to submit the form
xdotool key Return

# Exit the script