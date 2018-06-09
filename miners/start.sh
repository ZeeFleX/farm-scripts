#!/bin/bash

#Reading config file
. ~/miners/config.cfg

case "$autostart" in
    "1")
	case "$overclocking" in
	    "1")
		~/miners/overclock.sh
	    ;;
	esac
	case "$downvolt" in
	    "1")
		~/miners/downvolt.sh
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


