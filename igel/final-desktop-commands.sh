#!/bin/bash
mkdir /run/logs
echo \ >> /run/logs/final-dcommand-2024.05.29q
echo "Final Desktop Custom Commands"\ >> /run/logs/final-dcommand-2024.05.29q
echo "Igel Profile: OS11 Imprivata thin client - Custom commands"\ >> /run/logs/final-dcommand-2024.05.29q
echo "Author: Michael Wood"\ >> /run/logs/final-dcommand-2024.05.29q
echo $(date +"%Y%m%d_%T")\ >> /run/logs/final-dcommand-2024.05.29q
echo \ >> /run/logs/final-dcommand-2024.05.29q
echo " 1. check Imprivata if PIE"\ >> /run/logs/final-dcommand-2024.05.29q
echo " 2. turn off Wifi radio if LAN network up"\ >> /run/logs/final-dcommand-2024.05.29q
echo " 3. Workspace idle timeout after 4 hours if not running"\ >> /run/logs/final-dcommand-2024.05.29q
echo \ >> /run/logs/final-dcommand-2024.05.29q

for (( ; ; ))
do

sleep 420

# check Imprivata if PIE
if [ ! -f /run/logs/imprivata-finished ]
    then
    echo $(date +"%Y%m%d_%T")\n >> /run/logs/imprivata-started
        if [ -a /.imprivata_data/runtime/offline/Agent/FirstDomain.txt ]
            then
                echo $(date +"%Y%m%d_%T")\n >>  /run/logs/imprivata-installed
                echo $(date +"%Y%m%d_%T")\n >> /run/logs/imprivata-finished
            else
                echo $(date +"%Y%m%d_%T")\n >>  /run/logs/imprivata-missing
                ImprivataBootstrap -w
                ImprivataBootstrap
                echo $(date +"%Y%m%d_%T")\n >> /run/logs/imprivata-finished
                reboot
        fi
    else
    ls # do nothing really
fi


# Turn off Wifi radio if LAN network up 
if [ ! -f /run/logs/lanstatus-finished ]
    then
    echo $(date +"%Y%m%d_%T") >>  /run/logs/lanstatus-started
    wired_lan=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
    lan_status=$(ifconfig $wired_lan | grep 'inet')
        if [ -z "$lan_status" ];
            then
            echo "No wired network connection"
            echo $wired_lan >>  /run/logs/lanstatus-down
            echo $lan_status >>  /run/logs/lanstatus-down
            echo $(date +"%Y%m%d_%T")\n >> /run/logs/lanstatus-finished
        else
            nmcli radio wifi off
            echo "Wired network connection detected | Turned off wifi"
            echo $wired_lan >>  /run/logs/lanstatus-up
            echo $lan_status >>  /run/logs/lanstatus-up
            echo $(date +"%Y%m%d_%T")\n >> /run/logs/lanstatus-finished
        fi
    else
    ls # do nothing really
fi


# Workspace idle timeout after 4 hours if not running
echo $(date +"%Y%m%d_%T")\n >> /run/logs/workspace-started
RUNNING=$(pgrep -u user wfica_orig)
if [ $RUNNING -gt 0 ]
    then
	    echo $(date +"%Y%m%d_%T")\n >> /run/logs/workspace-running
	    rm ./run/logs/workspace-notrunning
    else
	    echo $(date +"%Y%m%d_%T")\n >> /run/logs/workspace-notrunning
fi

TIME=$(wc -l < /run/logs/workspace-notrunning)
if [ $TIME = 35 ]
    then reboot
    else echo $TIME
fi

done &
#EOF


