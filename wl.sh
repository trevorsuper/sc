#!/usr/bin/sh
./yt-dlp_linux -x --audio-format mp3 -o "%(autonumber)d.%(ext)s" "$1"
ffmpeg -f concat -safe 0 -i list.txt -c copy 'wl.mp3'
