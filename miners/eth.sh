#!/bin/bash

ln -s ~/.local/share/applications/Ethereum.desktop ~/.config/autostart/startminer.desktop -f

#Reading config file
. ~/miners/config.cfg


#Start mining
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

~/miners/claymore/ethdcrminer64 -epool eth-eu1.nanopool.org:9999 -ewal $ethAddress/$rigName/$email -mode 1 -wd 0

