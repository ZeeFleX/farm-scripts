#!/bin/bash

#Reading config file
. ~/miners/config.cfg

#Start mining
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

#Start ETH mining
case "$ethPool" in
    "0")
    ~/miners/claymore/ethdcrminer64 -epool eth-eu1.nanopool.org:9999 -ewal $ethAddress/$rigName/$email -mode 1 -wd 0
    ;;
    "1")
    ~/miners/claymore/ethdcrminer64 -epool eu1.ethpool.org:3333 -ewal $ethAddress.$rigName -mode 1 -wd 0
    ;;
esac



