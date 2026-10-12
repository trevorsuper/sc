#!/usr/bin/sh
./yt-dlp_linux -x --audio-format mp3 -o "%(autonumber)d.%(ext)s" "$1"
