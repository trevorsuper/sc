#!/usr/bin/sh
# Raspberry Pi 5 setup script for 64-bit Desktop
# Create config file

# Configure DNS servers for current active network
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.dns "9.9.9.9 149.112.112.112"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.ignore-auto-dns yes
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.dns "2620:fe::fe 2620:fe::9"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.ignore-auto-dns yes

# DNS Over TLS
cat << EOF | sudo tee /etc/NetworkManager/conf.d/90-dns-over-tls.conf > /dev/null
[connection]
connection.dns-over-tls=2
# 2 yes, 1 opportunistic, 0 no
EOF

sudo systemctl restart NetworkManager

sudo apt remove firefox chromium orca thonny geany dillo lynx emacsen-common -y
sudo apt autoremove -y
sudo apt update && sudo apt upgrade -y
sudo apt install curl minisign rsync -y

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update && sudo apt install brave-browser -y

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium -y

cat << EOF > ~/Desktop/Brave.sh
#!/usr/bin/sh
brave-browser --incognito
EOF
sudo chmod +x ~/Desktop/Brave.sh

curl -sSLo ~/hosts.tar.gz https://github.com/trevorsuper/sc/raw/refs/heads/master/files/hosts.tar.gz
cd ~/
tar -xzf hosts.tar.gz
cat hosts | sudo tee -a /etc/hosts > /dev/null
rm hosts hosts.tar.gz