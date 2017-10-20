#!/bin/bash

#Reading config file
. ~/miners/config.cfg

echo "Watchdog started. Timeout to start: $wdTimeout seconds. Signal level: $wdSignalUtilization%"

counter=()

cardsStr=$(nvidia-smi | grep -B1 "Default" | grep -oE "|[[:space:]]*[0-9]*[[:space:]]*GeForce" | grep -oE "[0-9]*")
gpus=(${cardsStr})


for i in ${gpus[@]}
do
	counter[$i]=0
done

sleep $wdTimeout

while true
do

    for i in ${gpus[@]}
    do
	utilization=$(nvidia-smi |  grep -A1 "[[:space:]]$i  GeForce" | grep -oE "[0-9]*%[[:space:]]*Default" | grep -oE "[0-9]*")

	if [ -z "$utilization" ] || (($utilization < $wdSignalUtilization))
	then
		((counter[$i]++))
	else
		counter[$i]=0
	fi
	
	if((${counter[$i]} >= 3))
	then
		echo $(date +"%y-%m-%d %T") - Cработал watchdog >> ~/miners/logs/watchdog.txt
		echo "Reboot"		
		reboot
	fi	

    done
	echo "All is well!"

    sleep $wdInterval
done
