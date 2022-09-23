#!/bin/bash


ffmpeg -f avfoundation -i "1:0" -vf fps=5 -y images/%04d.png
