#!/bin/bash

ffmpeg -f avfoundation -i "1:0" -vf "fps=2,scale=400:-2" -y images/%04d.png
