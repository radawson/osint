#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

opt1="Reddit Search (Active)"
opt2="Subreddit Download (Active)"
opt3="Redditsfinder (Deleted)"
redditmenu=$(zenity  --list  --title "Reddit Tool" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" --height=400 --width=300) 
case $redditmenu in
$opt1 ) 

cd ~/Downloads/Programs/bulk-downloader-for-reddit
python3 script.py --directory ~/Documents/Reddit/
xdg-open $DOC_PATH/reddit/ >/dev/null
exit;;
$opt2 ) 
url=$(zenity --entry --title "Subreddit Download (Active)" --text "Enter Subreddit")
cd ~/Downloads/Programs/bulk-downloader-for-reddit
python3 script.py --subreddit "$url" --directory ~/Documents/Reddit/$url/
xdg-open $DOC_PATH/reddit/$url >/dev/null
exit;;
$opt3 ) 
url=$(zenity --entry --title "Redditsfinder (Deleted)" --text "Enter Reddit Username")
mkdir ~/Documents/Reddit/
cd $DOC_PATH/reddit/
redditsfinder "$url" | zenity --progress --pulsate --no-cancel --auto-close --title="Redditsfinder" --text="Data being saved"
xdg-open $DOC_PATH/reddit/users/$url >/dev/null
exit;;esac
