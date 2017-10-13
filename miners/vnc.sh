#!/bin/bash

export DISPLAY=:0
xrandr --fb 1280x1024

echo "123321" | sudo -S x11vnc -auth /var/run/lightdm/root/:0 -noxrecord -noxfixes -noxdamage -xkb -nowcr -repeat -rfbauth /home/farm4/.vnc/passwd  -forever -bg -rfbport 5900 -scale 1280x1024 -o /var/log/x11vnc.log -shared

