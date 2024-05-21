#!/bin/bash

echo $(date +"%Y%m%d_%T") >>  /run/Wireless_Check_Started.log

sleep 240

wired_lan=$(ip -br l | awk '$1 !~ "lo|vir|wl" { print $1}')
lan_status=$(ifconfig $wired_lan | grep 'inet')

if [ -z "$lan_status" ];
then
	echo "No wired network connection"
	echo $wired_lan >>  /run/Wireless_Check_No.log
	echo $lan_status >>  /run/Wireless_Check_No.log
else
	nmcli radio wifi off	
	echo "Wired network connection detected | Turned off wifi"
	echo $wired_lan >>  /run/Wireless_Check_Yes-Off.log
	echo $lan_status >>  /run/Wireless_Check_Yes-Off.log
fi

