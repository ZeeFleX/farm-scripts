#!/bin/bash

ln -s ~/.local/share/applications/ZCashClassic.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg

#Setting powerlimits

echo "123321" | sudo -S nvidia-smi -pl $powerLimit

#Overclocking
for i in ${gpus[@]}
do
	nvidia-settings -a [gpu:$i]/GPUPowerMizerMode=1
	nvidia-settings -a [gpu:$i]/GPUGraphicsClockOffset[3]=${equihashCore[$i]}
	nvidia-settings -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=${equihashMemory[$i]}
done

#Watchdog
gnome-terminal -e "./miners/watchdog.sh"

#Start zcash classic mining over miningspeed.com and bittrex
~/miners/ewbf/miner --server mining.miningspeed.com --user $zclAddress.$rigName --pass x --port 3052 --api 0.0.0.0:42000 --fee 0
