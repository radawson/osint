#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

opt1="Extract Metadata"
opt2="Clean Metadata"
exifdata=$(zenity  --list  --title "Metadata Utilities" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" --height=400 --width=300)
case $exifdata in
$opt1 )
zenity --info --text "The next window will prompt for a target folder of media" --title "Exiftool"
sleep 1
exiftool_folder=$(zenity --file-selection --directory --title "Exiftool")
exiftool /$exiftool_folder/* -csv > /$exiftool_folder/MetadataReport.csv
xdg-open $exiftool_folder
zenity --info --text="Report saved in your Documents folder." --title="Metadata Cleaning"
exit;;
$opt2 )
zenity --info --text="Select a file to clean" --width=200 --title="Metadata Cleaning"
sleep 1
data_file=$(zenity --file-selection --title "Metadata Cleaning")
mat2 "$data_file"
xdg-open $data_file
zenity --info --text "A clean copy has been saved next to the original." --title="Metadata Cleaning"
exit;;esac
