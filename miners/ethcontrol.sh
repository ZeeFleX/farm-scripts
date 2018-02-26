#!/bin/bash

#Reading config file
. /home/farm4/miners/config.cfg

#Start ethereum mining
echo $rigName
echo $accessToken
/home/farm4/ethcontrol/EthControl -accessToken $accessToken -rigName $rigName
