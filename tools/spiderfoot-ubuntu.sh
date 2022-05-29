#!/usr/bin/env bash
cd ~/Downloads/Programs/spiderfoot
python3 ./sf.py -l 127.0.0.1:5001 & 
sleep 2
firefox  http://127.0.0.1:5001
