#!/bin/sh
setxkbmap -option caps:swapescape &
xset r rate 180 80 &
wallpaper &
slstatus &
xcompmgr  &
exec dwm
