#!/bin/env bash

function search_xdg() {
    RES=""
    for app in $(ls $LOCATION | grep $1)
    do

        NAME=$(echo $app | awk -F. '{ print $1 }')

        # Get name and desc, etc
        COMMENT=$(cat $LOCATION$app | grep "GenericName=" | awk -F= '{ print $2 }')
        DESC=$(cat $LOCATION$app | grep "Comment=" | awk -F= '{ print $2 }')

        EXEC=""
        $(cat $LOCATION$app | grep "Terminal=true" | sed -n '1p' | sed 's/Terminal=//') # EXEC
        if (($?)); then # If it find true it mean the app should be exec in a terminal.
            EXEC=$TERMINAL
        fi
        EXEC=${EXEC}$(cat $LOCATION$app | grep "Exec=" | awk -F= '{ print $2 }' | awk '{ print $1 }')


        RES=${RES}"{${NAME}|${EXEC}|"
        if [ ${#COMMENT} ]; then
            RES="${RES}%C${COMMENT}%%L"
        fi
        if [ ${#DESC} ]; then
            RES="${RES}%C${DESC}%"
        fi
        RES=${RES}"}"
    done

    echo "${RES}"
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
