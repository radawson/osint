#!/usr/bin/env bash
opt1="Amass"
opt2="Sublist3r"
opt3="Photon"
opt4="TheHarvester"
timestamp=$(date +%Y-%m-%d:%H:%M)
domainmenu=$(zenity  --list  --title "Domain Tool" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" --height=400 --width=300) 
case $domainmenu in
$opt1 ) 
domain=$(zenity --entry --title "Amass" --text "Enter target domain name")
mkdir ~/Documents/Amass/
amass intel -whois -ip -src -d $domain  -o ~/Documents/Amass/$timestamp-$domain.1.txt 
amass enum -src -brute -d $domain -o ~/Documents/Amass/$timestamp-$domain.2.txt -d $domain
nautilus ~/Documents/Amass/
exit;;
$opt2 ) 
domain=$(zenity --entry --title "Sublist3r" --text "Enter target domain name")
mkdir ~/Documents/Sublist3r/
cd ~/Downloads/Programs/Sublist3r
python3 sublist3r.py -d $domain -o ~/Documents/Sublist3r/sublist3r_$domain.txt
exit;;
$opt3 ) n
domain=$(zenity --entry --title "Photon" --text "Enter target domain name")
mkdir ~/Documents/Photon/
cd ~/Downloads/Programs/Photon/
python3 photon.py -u $domain -l 3 -t 100 -o ~/Documents/Photon/$timestamp-$domain
nautilus ~/Documents/Photon/$timestamp-$domain
exit;;
$opt4 ) 
domain=$(zenity --entry --title "TheHarvester" --text "Enter target domain name")
mkdir ~/Documents/theHarvester/
cd ~/Downloads/Programs/theHarvester/
python3 theHarvester.py -d $domain -b baidu,bing,duckduckgo,google,yahoo,virustotal -f ~/Documents/theHarvester/$timestamp-$domain.html
firefox ~/Documents/theHarvester/$timestamp-$domain.html	
exit;;esac
