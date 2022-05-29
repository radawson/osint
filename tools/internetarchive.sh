#!/usr/bin/env bash
# v1.1.0
DOC_PATH=$(cat config | grep DOC_PATH | cut -c 10-)

url=$(zenity --entry --title "Internet Archive Tool" --text "Enter target URL")

mkdir $DOC_PATH/waybackpy/$url
cd $DOC_PATH/waybackpy/$url
waybackpy --url "$url" --known_urls
waybackpy --url "$url" --oldest >> $url.txt
waybackpy --url "$url" --newest >> $url.txt
waybackpy --url "$url" --near --year 2010 >> $url.txt
waybackpy --url "$url" --near --year 2011 >> $url.txt
waybackpy --url "$url" --near --year 2012 >> $url.txt
waybackpy --url "$url" --near --year 2013 >> $url.txt
waybackpy --url "$url" --near --year 2014 >> $url.txt
waybackpy --url "$url" --near --year 2015 >> $url.txt
waybackpy --url "$url" --near --year 2016 >> $url.txt
waybackpy --url "$url" --near --year 2017 >> $url.txt
waybackpy --url "$url" --near --year 2018 >> $url.txt
waybackpy --url "$url" --near --year 2019 >> $url.txt
waybackpy --url "$url" --near --year 2020 >> $url.txt
waybackpy --url "$url" --near --year 2021 >> $url.txt
sort -u -i $url.txt -o $url.sorted.txt
webscreenshot -r chrome -q 100 -i $url.sorted.txt -w 1 &
waybackpy --url "$url" --get oldest > oldest.html
waybackpy --url "$url" --get newest > newest.html
xdg-open $DOC_PATH/waybackpy/$url >/dev/null
exit
