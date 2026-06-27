#!/usr/bin/sh
curl -sSLo ~/hosts.tar.gz https://github.com/trevorsuper/sc/raw/refs/heads/master/files/hosts.tar.gz
cd ~/
expected_checksum="ae77a2eaeecf74ad26bb32a96df976659e52d048193dac41d18854de9af0db43"
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

