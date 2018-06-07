#!/bin/bash

ln -s ~/.local/share/applications/Ethereum.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg

case "$autostart" in
    "1")
	case "$overclocking" in
	    "1")
		~/miners/overclock.sh
	    ;;
	esac
	case "$ethMonitoring" in
	    "0")
		case "$coin" in
		    "0")
			~/miners/eth.sh
		    ;;
		    "1")
			~/miners/zec.sh
		    ;;
		esac
	    ;;
	    "1")
	    echo "ETH Monitoring starting"
		~/miners/tools/EthControl --accessToken=$ethMonitoringToken --rigName=$rigName
	    ;;
	esac
    ;;
esac


