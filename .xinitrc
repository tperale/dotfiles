#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -option caps:escape
redshift &
compton --config ~/.config/compton/compton.conf

mpd &
if [ pidof mpdscribble -ne 0 ]; then
     mpdscribble &
fi
