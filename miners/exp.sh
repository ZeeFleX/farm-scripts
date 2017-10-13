#!/bin/bash

ln -s ~/.local/share/applications/Expanse.desktop ~/.config/autostart/startminer.desktop -f

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

#Start expanse mining over dwarfpool
~/miners/claymore/ethdcrminer64 -epool exp-eu.dwarfpool.com:8018 -ewal $expAddress -eworker $rigName -epsw x -mode 1 -ftime 10 -allcoins 1 -allpools 1
