#!/bin/bash

ln -s ~/.local/share/applications/xmr.desktop ~/.config/autostart/startminer.desktop -f

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
	nvidia-settings -a [gpu:$i]/GPUGraphicsClockOffset[3]=${xmrCore[$i]}
	nvidia-settings -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=${xmrMemory[$i]}
done

#Watchdog
gnome-terminal -e "./miners/watchdog.sh"

#Start monero mining
~/miners/xmr-stak/bin/xmr-stak -O xmr-eu1.nanopool.org:14433 -u $xmrPaymentID.$rigName/$email --currency monero7 -i 0 -p "" -r $rigName -i 3333
