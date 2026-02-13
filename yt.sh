#!/usr/bin/sh
# yt-dlp in a for loop
for i
do
	./yt-dlp_linux -f "140" $i
done
