#!/bin/bash

#Reading config file
. ~/miners/config.cfg

#FanControl

if(($enableFanControl))
then
    #Fan controller

    for i in ${cards[@]}
    do
	let fanSpeedArray[$i]=60
    done
fi

criticalOffset=5

while true
do
    for i in ${cards[@]}
    do
	temp=$(echo $passwd | sudo -S ~/miners/tools/wolfamdctrl -i $i --show-temp | grep -oE [0-9]+)
	step=$(($temp-$targetTemp))
	fanSpeedArray[$i]=$((${fanSpeedArray[$i]} + $step))
	if((${fanSpeedArray[$i]}>100)) || ((${fanSpeedArray[$i]}<30))
	then
	    if((${fanSpeedArray[$i]}>100))
	    then
		let fanSpeedArray[$i]=100
		targetFan=100
	    else
		let fanSpeedArray[$i]=30
	    fi
	fi
	echo ${fanSpeedArray[$i]}
	targetFan=${fanSpeedArray[$i]}
	if(($(($temp-$targetTemp))>$criticalOffset))
	then
	    targetFan=100
	fi
	echo "Card $i: Fan: $targetFan Temp: $temp"
	echo $passwd | sudo -S ~/miners/tools/wolfamdctrl -i $i --set-fanspeed $targetFan
    done
    sleep 5
done
fi