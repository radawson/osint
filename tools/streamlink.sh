#!/usr/bin/env bash
# v1.1.0

opt1="Display Live Stream"
opt2="Record Live Stream"
opt3="Play and Record Live Stream"
opt4="Convert Stream to MP4"
streammenu=$(zenity  --list  --title "Video Stream Tool" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" --height=400 --width=300) 
case $streammenu in
$opt1 ) 
url=$(zenity --entry --title "Display Live Stream" --text "Enter target URL")
streamlink $url best
exit;;
$opt2 ) 
url=$(zenity --entry --title "Record Live Stream" --text "Enter target URL")
cd ~/Videos
streamlink $url best -o streamdata | zenity --progress --pulsate --auto-close --title="Record Live Stream" --text="Raw Video being saved to ~/Videos/"
xdg-open ~/Videos/
exit;;
$opt3 ) 
url=$(zenity --entry --title "Play and Record Live Stream" --text "Enter target URL")
cd ~/Videos
streamlink $url best -r streamdata | zenity --progress --pulsate --auto-close --title="View/Record Live Stream" --text="Raw Video being saved to ~/Videos/"
xdg-open ~/Videos/
exit;;
$opt4 ) 
zenity --info --text="The next window will prompt you for a target stream file." --title="Stream Converter"
file=$(zenity --file-selection --title "Video Stream")
ffmpeg -i $file -c copy ~/Videos/stream.mp4
xdg-open ~/Videos/
exit;;esac
