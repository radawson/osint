#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

opt1="Instalooter (Without Login)"
opt2="Instaloader (Without Login)"
opt3="Instalooter (With Login)"
opt4="Instaloader (With Login)"
socialmenu=$(zenity  --list  --title "Instagram Utilities" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2"  FALSE "$opt3" FALSE "$opt4" --height=400 --width=300) 
case $socialmenu in
$opt1 ) 
handle=$(zenity --entry --title "Instalooter" --text "Enter TARGET Instagram User ID")
mkdir $DOC_PATH/instalooter/$handle/
instalooter user $handle ~/Documents/instalooter/$handle/ -v -m -d -e | zenity --progress --pulsate --no-cancel --auto-close --title="Instalooter" --text="Downloading images from $handle"
xdg-open $DOC_PATH/instalooter/$handle/
exit;;
$opt2)
cd $DOC_PATH/instaloader
handle=$(zenity --entry --title "Instaloader" --text "Enter TARGET Instagram User ID")
instaloader $handle
xdg-open $DOC_PATH/instaloader/$handle/
exit;;
$opt3) 
username=$(zenity --entry --title "Credentials" --text "Enter YOUR Instagram Username")
pass=$(zenity --entry --title "Credentials" --text "Enter YOUR Instagram Password")
handle=$(zenity --entry --title "Instalooter" --text "Enter TARGET Instagram User ID")
mkdir $DOC_PATH/instalooter/$handle/
instalooter logout
instalooter login -u $username -p $pass
instalooter user $handle $DOC_PATH/instalooter/$handle/ -v -m -d -e | zenity --progress --pulsate --no-cancel --auto-close --title="Instalooter" --text="Downloading images from $handle"
xdg-open $DOC_PATH/instalooter/$handle/
exit;;
$opt4) 
username=$(zenity --entry --title "Credentials" --text "Enter YOUR Instagram Username")
pass=$(zenity --entry --title "Credentials" --text "Enter YOUR Instagram Password")
handle=$(zenity --entry --title "Instaloader" --text "Enter TARGET Instagram User ID")
instaloader --login $username --password $pass $handle
xdg-open $DOC_PATH/instaloader/$handle/
exit;;esac
