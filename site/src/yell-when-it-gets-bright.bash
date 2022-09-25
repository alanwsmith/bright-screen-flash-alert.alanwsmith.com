#!/bin/bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

ffmpeg -f avfoundation \
    -hide_banner \
    -loglevel panic \
    -i "1:0" \
    -vf "fps=5,scale=100:-2" \
    -y "images/%04d.png" &

THROTTLE=0

# fswatch -l 0.1 -m poll_monitor -0 images/ | while read -d "" event
fswatch -l 0.1 -0 images/ | while read -d "" event
do 
    if [ -e "$event" ]
    then
        BRIGHT_F=`convert "$event" \
            -colorspace gray \
            -format "%[fx:100*mean]" \
            info:`
        BRIGHT_I=`printf %.0f "$BRIGHT_F"`
        echo -n "$BRIGHT_I "
        if [ $BRIGHT_I -gt 40 ]
        then
             if [ $THROTTLE -eq 0 ]
             then
                 THROTTLE=1
                 afplay ahhhh.mp3 &
                 echo "YELL"
             fi
         else
             THROTTLE=0
         fi
         rm "$event"
    fi
done

wait 

