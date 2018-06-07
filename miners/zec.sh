#!/bin/bash

#Reading config file
. ~/miners/config.cfg

#Start ZEC mining
case "$zecPool" in
    "0")
    ~/miners/claymore_zcash/zecminer64 -zpool ssl://zec-eu1.nanopool.org:6633 -zwal $zecAddress.$rigName/$email -zpsw z -wd 0 -ftime 1
    ;;
esac



