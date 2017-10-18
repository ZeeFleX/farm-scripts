#!/bin/bash

#Reading config file
. ~/miners/config.cfg

if((enableFanControl))
then
#Fan controller

for i in ${gpus[@]}
do
    nvidia-settings -a [gpu:$i]/GPUFanControlState=1
    fanSpeedArray[$i]=60
    tempArray[$i]=$(nvidia-smi |  grep -A1 "[[:space:]]$i  GeForce" | grep "C    " | cut -c 9- | cut -c -2)
done

criticalOffset=5

while true
do

    for i in ${gpus[@]}
    do
	temp=$(nvidia-smi |  grep -A1 "[[:space:]]$i  GeForce" | grep "C    " | cut -c 9- | cut -c -2)
	step=$temp-$targetTemp
	if(($temp > $targetTemp))
	then
	    if((${fanSpeedArray[$i] < 100})) && (($temp>=${tempArray[$i]}))
	    then
		if(( $((${fanSpeedArray[$i]}+$step)) <= 100 && $temp <= $(($targetTemp+$criticalOffset))))
		then
		    let fanSpeedArray[$i]=${fanSpeedArray[$i]}+$temp-$targetTemp
		else
		    let fanSpeedArray[$i]=100
		fi
	    fi
	    nvidia-settings -a [fan:$i]/GPUTargetFanSpeed=${fanSpeedArray[$i]}
	elif(($temp < $targetTemp))
	then
	    if((${fanSpeedArray[$i]} > 20)) && (($temp<=${tempArray[$i]}))
	    then
		if(( $((${fanSpeedArray[$i]}+$step)) >= 20 ))
		then
		    let fanSpeedArray[$i]=${fanSpeedArray[$i]}-$(($targetTemp-$temp))
		else
		    let fanSpeedArray[$i]=20
		fi
	    fi
	    nvidia-settings -a [fan:$i]/GPUTargetFanSpeed=${fanSpeedArray[$i]}
	else
	    let fanSpeedArray[$i]=$((${fanSpeedArray[$i]}+1))
	    nvidia-settings -a [fan:$i]/GPUTargetFanSpeed=${fanSpeedArray[$i]}
	fi
	let tempArray[$i]=$temp
    done

    sleep 1
done
fi