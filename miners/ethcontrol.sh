#!/bin/bash

#Reading config file
. ~/miners/config.cfg

#Start zencash mining over zenmine.pro and bittrex
~/ethcontrol/EthControl -accessToken $accessToken -rigName $rigName
