#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

opt1="Amass"
opt2="Sublist3r"
opt3="Photon"
opt4="TheHarvester"
timestamp=$(date +%Y-%m-%d:%H:%M)
domainmenu=$(zenity  --list  --title "Domain Tool" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" FALSE "$opt4" --height=400 --width=300) 
case $domainmenu in
$opt1 ) 
domain=$(zenity --entry --title "Amass" --text "Enter target domain name")
amass intel -whois -ip -src -d $domain  -o $DOC_PATH/Amass/$timestamp-$domain.1.txt 
amass enum -src -brute -d $domain -o $DOC_PATH/Amass/$timestamp-$domain.2.txt -d $domain
xdg-open $DOC_PATH/Amass/
exit;;
$opt2 ) 
domain=$(zenity --entry --title "Sublist3r" --text "Enter target domain name")
cd ~/Downloads/Programs/Sublist3r
python3 sublist3r.py -d $domain -o $DOC_PATH/Sublist3r/sublist3r_$domain.txt
exit;;
$opt3 ) n
domain=$(zenity --entry --title "Photon" --text "Enter target domain name")
photon -u $domain -l 3 -t 100 -o $DOC_PATH/Photon/$timestamp-$domain
xdg-open $DOC_PATH/Photon/$timestamp-$domain
exit;;
$opt4 ) 
domain=$(zenity --entry --title "TheHarvester" --text "Enter target domain name")
theHarvester -d $domain -b baidu,bing,duckduckgo,google,yahoo,virustotal -f $DOC_PATH/theHarvester/$timestamp-$domain.html
firefox $DOC_PATH/theHarvester/$timestamp-$domain.html	
exit;;esac
