#!/bin/bash

ln -s ~/.local/share/applications/Ethereum.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg


#Overclocking
for i in ${cards[@]}
do
    echo $passwd | sudo -S ~/miners/tools/wolfamdctrl -i $i --mem-state 2 --mvdd ${memVoltage} --vddci ${memVoltage} --set-max-power ${maxPowerLimit} --core-clock ${coreClock} --core-state 7 --core-vddc-off ${coreVoltageOffset}
done


