#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

cd ~/Downloads/Programs/Elasticsearch/
ip=$(zenity --entry --title "IP Address" --text "Enter target IP address")
index=$(zenity --entry --title "Index" --text "Enter target index" )
fields=$(zenity --entry --title "Fields" --text "Enter desired data fields (separated by space)")
python3 crawl.py $ip 9200 $index $fields > ~/Documents/Elasticsearch/$ip.txt
xdg-open $DOC_PATH/Elasticsearch/
exit
