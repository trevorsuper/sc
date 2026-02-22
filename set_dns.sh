#!/usr/bin/sh
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.dns "9.9.9.9 149.112.112.112"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv4.ignore-auto-dns yes
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.dns "2620:fe::fe 2620:fe::9"
nmcli connection modify "$(nmcli --terse --field NAME connection show --active | head -n1)" ipv6.ignore-auto-dns yes

cat << EOF | sudo tee /etc/NetworkManager/conf.d/90-dns-over-tls.conf > /dev/null
[connection]
connection.dns-over-tls=2
# 2 yes, 1 opportunistic, 0 no
EOF

sudo systemctl restart NetworkManager