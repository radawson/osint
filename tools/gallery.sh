#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

url=$(zenity --entry --title "Gallery Tool" --text "Enter target URL")
cd $DOC_PATH/gallery-dl
gallery-dl "$url"
xdg-open $DOC_PATH/gallery-dl/
exit
