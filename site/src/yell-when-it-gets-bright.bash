#!/bin/bash

SCREEN=1
BRIGHTNESS=40
AUDIO_FILE="ahhhh.mp3"
THROTTLE=0

mkdir -p screen-images

trap "trap - SIGTERM && kill -- -$$" \
    SIGINT SIGTERM EXIT

ffmpeg -f avfoundation \
    -hide_banner \
    -loglevel panic \
    -i "$SCREEN:0" \
    -vf "fps=5,scale=100:-2" \
    -y "screen-images/%04d.png" &

fswatch -l 0.1 -0 "screen-images/" | \
    while read -d "" event
do 
    if [ -f "$event" ]
    then
        BRIGHT_F=`convert "$event" \
            -colorspace gray \
            -format "%[fx:100*mean]" \
            info:`
        BRIGHT_I=`printf %.0f "$BRIGHT_F"`
        echo -n "$BRIGHT_I "
        if [ $BRIGHT_I -gt $BRIGHTNESS ]
        then
             if [ $THROTTLE -eq 0 ]
             then
                 THROTTLE=1
                 afplay "$AUDIO_FILE" &
                 echo "YELL"
             fi
         else
             THROTTLE=0
         fi
         rm "$event"
    fi
done
wait 
