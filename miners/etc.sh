#!/bin/bash

#Set startup link
ln -s ~/.local/share/applications/EthereumClassic.desktop ~/.config/autostart/startminer.desktop -f

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

#Start ethereum classic mining over Nanopool
~/miners/claymore/ethdcrminer64 -epool etc-eu1.nanopool.org:19999 -ewal $etcAddress.$rigName/$email -epsw x -mode 1 -ftime 10
