#!/bin/bash

ln -s ~/.local/share/applications/Ethereum.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg


#Overclocking
for i in ${cards[@]}
do
    echo $passwd | sudo -S ~/miners/tools/wolfamdctrl -i $i -m w --mem-state 2 --mem-clock ${memClocks[$i]}
    echo "Card $i Overclocked to ${memClocks[$i]}"
done


