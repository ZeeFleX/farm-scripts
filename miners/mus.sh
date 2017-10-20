#!/bin/bash

ln -s ~/.local/share/applications/Musicoin.desktop ~/.config/autostart/startminer.desktop -f

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
	nvidia-settings -a [gpu:$i]/GPUGraphicsClockOffset[3]=${ethashCore[$i]}
	nvidia-settings -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=${ethashMemory[$i]}
done

#Watchdog
gnome-terminal -e "./miners/watchdog.sh"

#Start musicoin mining over mus.mole-pool.net and bittrex
~/miners/claymore/ethdcrminer64 -mode 1 -allcoins 1 -epool 109.70.186.58:3003 -ewal $musAddress -eworker $rigName -epsw x
