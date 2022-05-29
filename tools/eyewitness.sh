#!/usr/bin/env bash
# V1.1.0

opt1="Single URL"
opt2="Multiple URLs (File)"
eyewitness=$(zenity  --list  --title "EyeWitness" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" --height=400 --width=300)
case $eyewitness in
$opt1 )
domain=$(zenity --entry --title "EyeWitness" --text "Enter Target URL")
cd ~/Downloads/Programs/EyeWitness/Python
./EyeWitness.py --web --single "$domain" -d ~/Documents/EyeWitness/
exit;;
$opt2 ) 
eyewitness_file=$(zenity --file-selection --title "URL List" --text "Select File of URLs")
cd ~/Downloads/Programs/EyeWitness/Python
./EyeWitness.py --web -f "$eyewitness_file" -d ~/Documents/EyeWitness/ 
exit;;esac
