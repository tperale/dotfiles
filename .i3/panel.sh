#!/bin/bash

STD="#ffb5b2af"
BKG="#ff282522"
DBL="#ff4C626D"
LBL="#ff6A7A8F"
GRN="#ff838A60"
MAG="#ff7D6A79"
RED="#ff8C4C4C"
YLW="#ff907245"


clk(){
	date '+%a %d %b %H:%M'
}

work(){
    # SPACE_NUM=$(get_workspace.py);
    SPACE_NUM=" 1";
		case "$SPACE_NUM" in
			" 1")
				WORKSPACE='• ◦ ◦ ◦ ◦ ◦';;
			" 2")
				WORKSPACE='◦ • ◦ ◦ ◦ ◦';;
			" 3")
				WORKSPACE='◦ ◦ • ◦ ◦ ◦';;
			" 4")
				WORKSPACE='◦ ◦ ◦ • ◦ ◦';;
			" 5")
				WORKSPACE='◦ ◦ ◦ ◦ • ◦';;
			" 6")
				WORKSPACE='◦ ◦ ◦ ◦ ◦ •';;
			" 7")
				WORKSPACE='◦ ◦ ◦ ◦ ◦ ◦ •';;
			" 8")
				WORKSPACE='◦ ◦ ◦ ◦ ◦ ◦ ◦ •';;

		esac
	echo "$WORKSPACE"
}


wifi(){
        WID=$(iwconfig | grep wlp2s0 | cut -d: -f 2 | sed s/'"'//g)
	echo "⇅ ${WID// /}"
}

battery(){
	BAT=$(acpi --battery | cut -d, -f 2)
        echo "⭫$BAT"
}

vol(){
	VOL=$(amixer get Master | grep Mono: | cut -d\[ -f 2 | sed s/"] "//)
	echo "⊲ $VOL"
}

mpd(){
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		TTL=$(mpc current --format "%title%")
		echo "♫ $TTL"
	else
		echo "♫ Paused"
	fi
}


while :; do

	echo "%{l}%{B$YLW}  $(work)  %{l}%{r}%{B$RED}  $(vol)  %{B$MAG}  $(wifi)  %{B$LBL}  $(battery)  %{B$DBL}  $(mpd)  %{B$GRN}  ⭧ $(clk)  %{B$BKG}%{r}"

sleep 1s
done

