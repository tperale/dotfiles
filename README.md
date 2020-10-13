# dotfiles

## Install

### DiplayLink ([wiki](https://wiki.archlinux.org/index.php/DisplayLink))

If your computer is using a DisplayLink docking station make sure to install
the `displaylink` driver from the AUR and `systemctl enable displaylink.service`.

Configure Xorg with the following section to use it with xrandr by creating the 
following file `/usr/share/X11/xorg.conf.d/20-evdidevice.conf`.

```
Section "OutputClass"
	Identifier "DisplayLink"
	MatchDriver "evdi"
	Driver "modesetting"
	Option  "AccelMethod" "none"
EndSection
```

## Key Combination

### i3

| Key Combination                 | Description                                                                                            |
| ------------------------------- | ------------------------------------------------------------------------------------------------------ |
| winkey + return                 | Opens a new terminal.                                                                             |
| winkey + <kbd>d</kbd>           | Launch lighthouse.                                                                  |
| winkey + <kbd>q</kbd>           | Kill focused window.                                                               |
| winkey + <kbd>h</kbd>           | Change focus (left).                                                                |
| winkey + <kbd>j</kbd>           | (down).                                                           |
| winkey + <kbd>k</kbd>           | (up).                                                                  |
| winkey + <kbd>l</kbd>           | (right).               
| winkey + shift + <kbd>h</kbd>   | Move window (left).                                                                |
| winkey + shift + <kbd>j</kbd>   | (down).                                                           |
| winkey + shift + <kbd>k</kbd>   | (up).                                                                  |
| winkey + shift + <kbd>l</kbd>   | (right).   
| winkey + <kbd>b</kbd>           | Split in horizontal orientation.    
| winkey + <kbd>v</kbd>           | Split in vertical orientation.
| winkey + <kbd>f</kbd>           | Fullscreen the current window.
| winkey + <kbd>s</kbd>           | Change layout (stacked).
| winkey + <kbd>w</kbd>           | (tabbed).
| winkey + <kbd>e</kbd>           | (change the split).
| winkey + shift + <kbd>e</kbd>   | Toggle floating window.
| winkey + space                  | Change focus between tiling and floating windows
| winkey + <kbd>1</kbd> - <kbd>0</kbd> | Change workspace.
| winkey + shift + <kbd>1</kbd> - <kbd>0</kbd> | Move currently focused window.
| winkey + <kbd>r</kbd>           | Resize mode.
| winkey + <kbd>PrtScrn</kbd>     | Screenshot.
| winkey + shift + <kbd>↑</kbd>   | Volume UP.
| winkey + shift + <kbd>↓</kbd>   | Volume DOWN.
| winkey + <kbd>x</kbd>           | Change the workspace output (right).
| winkey + <kbd>z</kbd>           | (left).
| winkey + shift + <kbd>-</kbd>   | Make the currently focused window a scratchpad.
| winkey + <kbd>-</kbd>           | Show the first scratchpad window.
| winkey + shift + <kbd>c</kbd>   | Reload config file.
| winkey + shift + <kbd>r</kbd>   | Restart i3.
| winkey + shift + <kbd>e</kbd>   | Exit i3.


### mpv

| Key Combination                 | Description                                                                                            |
| ------------------------------- | ------------------------------------------------------------------------------------------------------ |
| <kbd>h</kbd>           | Go backward (--).                                                                  |
| <kbd>left</kbd>        | Go backward (-).                                                                  |
| <kbd>j</kbd>           | Playlist next.                                                                  |
| <kbd>k</kbd>           | Playlist previous.                                                                  |
| <kbd>l</kbd>           | Go forward (++).                                                                  |
| <kbd>right</kbd>       | Go forward (+).                                                                  |
| <kbd>-</kbd>           | Volume UP.                                                                  |
| <kbd>=</kbd>           | Volume DOWN.                                                                  |
| <kbd>a</kbd>           | Subtitle cycle.                                                                  |
| <kbd>A</kbd>           | Subtitle cycle (backward).                                                                  |
| alt + <kbd>W</kbd>     | Record video.

### vim

| Key Combination                 | Description                                                                                            |
| ------------------------------- | ------------------------------------------------------------------------------------------------------ |
