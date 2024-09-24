#!/bin/bash

REBOOTTIME1="03:00"
REBOOTTIME2="11:00"
REBOOTTIME3="19:00"
echo "Reboot at $REBOOTTIME1 then $REBOOTTIME2 then $REBOOTTIME3"\ >> /run/Reboot_AtTime.log

for (( ; ; ))
do

RUNNING=$(date +"%R")

if [ $RUNNING == $REBOOTTIME1 ]
then
	sleep 56
	echo ""
	echo "Current time $RUNNING"
	echo "Reboot times $REBOOTTIME1 then $REBOOTTIME2 then $REBOOTTIME3"
	echo "Time to reboot! Goodbye."
	echo $(date +"%Y%m%d_%T")\ >> /run/Reboot_AtTime.log
	echo ""
	reboot

if [ $RUNNING == $REBOOTTIME2 ]
then
	sleep 56
	echo ""
	echo "Current time $RUNNING"
	echo "Reboot times $REBOOTTIME1 then $REBOOTTIME2 then $REBOOTTIME3"
	echo "Time to reboot! Goodbye."
	echo $(date +"%Y%m%d_%T")\ >> /run/Reboot_AtTime.log
	echo ""
	reboot

if [ $RUNNING == $REBOOTTIME3 ]
then
	sleep 56
	echo ""
	echo "Current time $RUNNING"
	echo "Reboot times $REBOOTTIME1 then $REBOOTTIME2 then $REBOOTTIME3"
	echo "Time to reboot! Goodbye."
	echo $(date +"%Y%m%d_%T")\ >> /run/Reboot_AtTime.log
	echo ""
	reboot

else
	sleep 56
	echo ""
	echo "Current time $RUNNING"
	echo "Reboot times $REBOOTTIME1 then $REBOOTTIME2 then $REBOOTTIME3"
	echo "Not time for reboot."
	echo $(date +"%Y%m%d_%T")\ >> /run/Reboot_AtTime.log
	echo ""
fi

done &

#EOF
