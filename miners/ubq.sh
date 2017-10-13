#!/bin/bash

ln -s ~/.local/share/applications/Ubiq.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg

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

#Start ubiq mining over ubiq.mole-pool.net and bittrex
~/miners/claymore/ethdcrminer64 -mode 1 -allcoins 1 -epool 109.70.186.58:5005 -ewal $ubqAddress -eworker $rigName -epsw x
