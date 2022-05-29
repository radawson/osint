#!/usr/bin/env bash
# v1.1.0
opt1="Best Quality"
opt2="Maximum 720p"
opt3="Export YT Comments"
opt4="Export YT Playlist"
opt5="Export YT Info"
timestamp=$(date +%Y-%m-%d:%H:%M)
videodownloadmenu=$(zenity  --list  --title "Video Downloader" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" FALSE "$opt5" --height=400 --width=300) 
case $videodownloadmenu in
$opt1 ) 
url=$(zenity --entry --title "Best Quality" --text "Enter target URL")
youtube-dl "$url" -o ~/Videos/Youtube-DL/"$timestamp%(title)s.%(ext)s" -i --all-subs | zenity --progress --pulsate --no-cancel --auto-close --title="Video Downloader" --text="Video being saved to ~/Videos/Youtube-DL/"
xdg-open ~/Videos/
exit;;
$opt2 ) 
url=$(zenity --entry --title "Maximum 720p" --text "Enter target URL")
youtube-dl "$url" -o ~/Videos/Youtube-DL/"$timestamp%(title)s.%(ext)s" -i -f 'bestvideo[height<=720]+bestaudio' --all-subs | zenity --progress --pulsate --no-cancel --auto-close --title="Video Downloader" --text="Video being saved to ~/Videos/Youtube-DL/"
xdg-open ~/Videos/
exit;;
$opt3 ) 
url=$(zenity --entry --title "Export YT Comments" --text "Enter Video ID")
yttool -c "https://www.youtube.com/watch?v=$url" > ~/Videos/Youtube-DL/"$url-comments.txt" | zenity --progress --pulsate --no-cancel --auto-close --title="Comment Exporter" --text="Comments being saved to ~/Videos/Youtube-DL/"
xdg-open ~/Videos/
exit;;
$opt4 ) 
url=$(zenity --entry --title "Export YT Playlist" --text "Enter Playlist ID")
yttool -l "https://www.youtube.com/playlist?list=$url" > ~/Videos/Youtube-DL/"$url-playlist.txt" | zenity --progress --pulsate --no-cancel --auto-close --title="Playlist Exporter" --text="Playlist being saved to ~/Videos/Youtube-DL/"
xdg-open ~/Videos/
exit;;
$opt5 ) 
url=$(zenity --entry --title "Export YT Info" --text "Enter Video ID")
yttool -i "https://www.youtube.com/watch?v=$url" > ~/Videos/Youtube-DL/"$url-info.txt" | zenity --progress --pulsate --no-cancel --auto-close --title="Info Exporter" --text="Info being saved to ~/Videos/Youtube-DL/"
xdg-open ~/Videos/
exit;; esac
