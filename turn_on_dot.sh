#!/usr/bin/sh
sudo sh -c 'echo "[connection]
connection.dns-over-tls=2
# 2 yes, 1 opportunistic, 0 no" > /etc/NetworkManager/conf.d/90-dns-over-tls.conf'

sudo systemctl restart NetworkManager
