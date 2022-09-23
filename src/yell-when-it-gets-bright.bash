#!/bin/bash

ALERT_THROTTLE=0

fswatch -0 images/ | while read -d "" event
do 
    if [ -e "$event" ]
    then
        LIGHT_LEVEL_FLOAT=`convert "$event" -colorspace gray -format "%[fx:100*mean]" info:`
        LIGHT_LEVEL_INT=`printf %.0f "$LIGHT_LEVEL_FLOAT"`
        echo $LIGHT_LEVEL_INT
        if [ $LIGHT_LEVEL_INT -gt 40 ]
        then
            if [ $ALERT_THROTTLE -eq 0 ]
            then
                ALERT_THROTTLE=1
                afplay ahhhh.mp3
                echo "YELL"
            fi
        else
            ALERT_THROTTLE=0
        fi
        rm "$event"
    fi
done

