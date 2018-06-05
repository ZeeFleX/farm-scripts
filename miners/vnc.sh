#!/bin/bash

. ~/miners/config.cfg

export DISPLAY=:0
xrandr --fb 1280x1024

echo $passwd | sudo -S x11vnc -auth /var/run/lightdm/root/:0 -noxrecord -noxfixes -noxdamage -xkb -nowcr -repeat -rfbauth /home/farmer/.vnc/passwd  -forever -bg -rfbport 5900 -scale 1280x1024 -o /var/log/x11vnc.log -shared

