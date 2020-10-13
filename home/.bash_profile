#
# ~/.bash_profile
#

if [ -z "${PATH-}" ]; then
	export PATH=/usr/local/bin:/usr/bin:/bin;
fi

if [ -d "$HOME/.config/bin" ] ; then
	export PATH="$PATH:$HOME/.config/bin";
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
	startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
