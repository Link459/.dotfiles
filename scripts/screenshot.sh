#! /usr/bin/bash
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

xclip -selection clipboard -t image/png -i /dev/null

scrot ~/Pictures/screenshot_$timestamp.png

xclip -selection clipboard -t image/png -i ~/Pictures/screenshot_$timestamp.png
