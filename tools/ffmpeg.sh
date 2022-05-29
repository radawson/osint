#!/usr/bin/env bash
# v1.1.0

zenity --info --text="The next window will prompt you for a target media file. Click "Cancel" if entering a stream URL." --title="Video Utilities" --width=200
ffmpeg_file=$(zenity --file-selection --title "Video Utilities")
timestamp=$(date +%Y-%m-%d:%H:%M)
opt1="Play a video"
opt2="Convert a video to mp4"
opt3="Extract video frames"
opt4="Shorten a video (Low Activity)"
opt5="Shorten a video (High Activity)"
opt6="Extract audio"
opt7="Rotate video"
opt8="Download a video stream"
ffmpeg=$(zenity  --list  --title "Video Utilities" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" FALSE "$opt5" FALSE "$opt6" FALSE "$opt7" FALSE "$opt8" --height=400 --width=300)
case $ffmpeg in
$opt1 )
ffplay "$ffmpeg_file"
exit;;
$opt2 )
ffmpeg -i "$ffmpeg_file" -vcodec mpeg4 -strict -2 ~/Videos/$timestamp.mp4 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Converting Video to mp4"
xdg-open ~/Videos/
exit;;
$opt3 )
mkdir ~/Videos/$timestamp-frames
ffmpeg -y -i "$ffmpeg_file" -an -r 10 ~/Videos/$timestamp-frames/img%03d.bmp | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Extracting Frames"
xdg-open ~/Videos/
exit;;
$opt4 )
ffmpeg -i "$ffmpeg_file" -strict -2 -vf "select=gt(scene\,0.003),setpts=N/(25*TB)" ~/Videos/$timestamp-low.mp4 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Shortening video (Low Activity)"
xdg-open ~/Videos/
exit;;
$opt5 )
ffmpeg -i "$ffmpeg_file" -strict -2 -vf "select=gt(scene\,0.005),setpts=N/(25*TB)" ~/Videos/$timestamp-high.mp4 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Shortening video (High Activity)"
xdg-open ~/Videos/
exit;;
$opt6 )
ffmpeg -i "$ffmpeg_file" -vn -ac 2 -ar 44100 -ab 320k -f mp3 ~/Videos/$timestamp.mp3 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Extracting Audio"
xdg-open ~/Videos/
exit;;
$opt7 )
ffmpeg -i "$ffmpeg_file" -vf transpose=0 ~/Videos/$timestamp.mp4 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Rotating Video"
xdg-open ~/Videos/
exit;;
$opt8 )
url=$(zenity --entry --title "Video Stream Download" --text "Enter URL Stream")
ffmpeg -i "$url" -c copy ~/Videos/$timestamp-STREAM.mp4 | zenity --progress --pulsate --no-cancel --auto-close --title="ffmpeg" --text="Saving Stream"
xdg-opens ~/Videos/
exit;;esac
