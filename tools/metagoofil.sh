#!/usr/bin/env bash
# v1.1.0

DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)
opt1="Metagoofil-Only"
opt2="Metagoofil+Exiftool"
domainmenu=$(zenity  --list  --title "Choose Tool" --radiolist  --column "" --column "" TRUE "$opt1" FALSE "$opt2" --height=400 --width=300) 
case $domainmenu in
$opt1 ) 
domain=$(zenity --entry --title "Metagoofil-Only" --text "Enter target domain name")

mkdir $DOC_PATH/metagoofil/"$domain"_docs
mkdir $DOC_PATH/metagoofil/"$domain"_results
python3 ~/Downloads/Programs/metagoofil/metagoofil.py -d $domain -w -t pdf,doc,xls,ppt,docx,xlsx,pptx -o $DOC_PATH/metagoofil/"$domain"_docs
xdg-open $DOC_PATH/metagoofil/
exit;;
$opt2 ) 
domain=$(zenity --entry --title "Metagoofil+Exiftool" --text "Enter target domain name")

mkdir $DOC_PATH/metagoofil/"$domain"_docs
mkdir $DOC_PATH/metagoofil/"$domain"_results
python3 ~/Downloads/Programs/metagoofil/metagoofil.py -d $domain -w -t pdf,doc,xls,ppt,docx,xlsx,pptx -o $DOC_PATH/metagoofil/"$domain"_docs
cd $DOC_PATH/metagoofil/"$domain"_docs
exiftool * -csv > $DOC_PATH/metagoofil/"$domain"_results/Report.csv
xdg-open $DOC_PATH/metagoofil
exit;;esac
