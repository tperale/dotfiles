#!/bin/env bash

function search_xdg() {
    for app in $(ls $LOCATION | grep $1)
    do
        # Get name and desc, etc
        NAME=$(cat $LOCATION$app | grep "Name=" | sed -n '1p' | sed 's/Name=//') # NAME
        COMMENT=$(cat $LOCATION$app | grep "Comment=" | sed -n '1p' | sed 's/Comment=//') # DESCRIPTION
        $(cat $LOCATION$app | grep "Terminal=true" | sed -n '1p' | sed 's/Terminal=//') # EXEC
        if (($?)); then # If it find true it mean the app should be exec in a terminal.
            EXEC=$TERMINAL
        fi
        EXEC=$EXEC$(cat $LOCATION$app | grep "Exec=" | sed -n '1p' | sed 's/Exec=//')
        if [ ${#COMMENT} ]; then
            printf "{$NAME|$EXEC|%%C$COMMENT %%}\n"
        fi
    done
}

EXEC=""
RES=""
INFO=""
LOCATION="/usr/share/applications/"
TERMINAL="terminator -e "
for args in $*
do
    case args in
        --location)
           LOCATION="$args"
            ;;
        *) INFO="$args"
            ;;
    esac
done

search_xdg $INFO
