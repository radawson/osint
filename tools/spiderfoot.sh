#!/usr/bin/env bash
spiderfoot -l 127.0.0.1:5001 & 
sleep 2
firefox  http://127.0.0.1:5001
