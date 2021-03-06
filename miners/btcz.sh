#!/bin/bash

ln -s ~/.local/share/applications/BitcoinZ.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg

cardsStr=$(nvidia-smi | grep -B1 "Default" | grep -oE "|[[:space:]]*[0-9]*[[:space:]]*GeForce" | grep -oE "[0-9]*")
gpus=(${cardsStr})

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

#Start zcash mining over Nanopool
~/miners/ewbf/miner --server mining.miningspeed.com --user $btczAddress.$rigName --pass x --port 3072 --api 0.0.0.0:42000 --fee 0 --pec
