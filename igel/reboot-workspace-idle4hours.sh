#!/bin/bash
for (( ; ; ))
do

sleep 120
RUNNING=$(pgrep -u user wfica_orig)

if [ $RUNNING -gt 0 ]
then
	echo $(date +"%Y%m%d_%T")\n >> /run/CitrixWorkspace_Yes.log
	rm ./run/CitrixWorkspace_No.log
else
	echo $(date +"%Y%m%d_%T")\n >> /run/CitrixWorkspace_No.log
fi

TIME=$(wc -l < /run/CitrixWorkspace_No.log)
if [ $TIME = 120 ]; then reboot ; else echo $TIME ;fi

done &

#EOF