#!/bin/bash
echo $(date +"%Y%m%d_%T")\n >> /run/Imprivata_BootCheck_Start.log

sleep 300

if [ -a /.imprivata_data/runtime/offline/Agent/FirstDomain.txt ]
then
	echo $(date +"%Y%m%d_%T")\n >>  /run/Imprivata_BootCheck_FileYes.log
else
	echo $(date +"%Y%m%d_%T")\n >>  /run/Imprivata_BootCheck_FileNo.log
	ImprivataBootstrap -w
	reboot
fi

#EOF
