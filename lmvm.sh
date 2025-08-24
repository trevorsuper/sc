#!/usr/bin/sh
sudo apt remove yt-dlp hypnotix firefox firefox-locale-en mintchat thunderbird \
 thunderbird-locale-en libimobiledevice-utils ifuse usbmuxd ideviceinstaller \
 blueman bluetooth bluez-cups bluez-obexd bluez
curl -fsS https://dl.brave.com/install.sh | sh
sudo apt autoremove -y && sudo apt update && sudo apt upgrade && sudo reboot