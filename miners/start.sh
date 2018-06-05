#!/bin/bash

ln -s ~/.local/share/applications/Ethereum.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg

case "$coin" in
    "0")
	~/miners/eth.sh
    ;;
    "1")
	~/miners/zec.sh
    ;;
esac 


