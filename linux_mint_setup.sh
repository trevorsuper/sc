#!/usr/bin/sh
# Linux Mint Setup Script
# Configure DNS servers for current active network
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.dns "9.9.9.9 149.112.112.112"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.ignore-auto-dns yes
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.dns "2620:fe::fe 2620:fe::9"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.ignore-auto-dns yes

# Enable DNS Over TLS
cat << EOF | sudo tee /etc/NetworkManager/conf.d/90-dns-over-tls.conf > /dev/null
[connection]
connection.dns-over-tls=2
# 2 yes, 1 opportunistic, 0 no
EOF

sudo systemctl restart NetworkManager

sleep 5 # seconds

# Package Preferences
sudo apt remove firefox chromium orca emacsen-common thunderbird thunderbird-locale-en \
 firefox-locale-en yt-dlp hypnotix mintchat libimobiledevice-utils ifuse usbmuxd ideviceinstaller \
 blueman bluetooth bluez-cups bluez-obexd bluez -y
sudo apt autoremove -y
sudo apt update && sudo apt upgrade -y
sudo apt install git curl rsync -y

# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update && sudo apt install brave-browser -y

# Codium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium -y

# DNS Blocks
curl -sSLo ~/hosts.tar.gz https://github.com/trevorsuper/sc/raw/refs/heads/master/files/hosts.tar.gz
cd ~/
expected_checksum="f30ce02555f850f8f4599addc4de84a7805a423f8e0e55286e05f4ddded336b3"
if [ "$(sha256sum ~/hosts.tar.gz | awk '{ print $1 }')" = "$expected_checksum" ]; then
    echo "hosts.tar.gz checksum is valid"
    tar -xzf hosts.tar.gz
    cat hosts | sudo tee -a /etc/hosts > /dev/null
    rm hosts hosts.tar.gz
else
    echo ""
    echo "==========================================================================="
    echo ""
    echo "hosts.tar.gz checksum is not valid"
    echo ""
    echo "==========================================================================="
    echo ""
    rm hosts.tar.gz
fi

