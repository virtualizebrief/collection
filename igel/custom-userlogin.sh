#!/bin/bash
USERNAME="myname"
PASSWORD="mypassword"

sleep 20

DISPLAY=:0 xdotool type "$USERNAME"
DISPLAY=:0 xdotool key Tab
DISPLAY=:0 xdotool type "$PASSWORD"
DISPLAY=:0 xdotool key Return 
#EOF
