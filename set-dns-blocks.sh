#!/usr/bin/sh
curl -sSLo ~/hosts.tar.gz https://github.com/trevorsuper/sc/raw/refs/heads/master/files/hosts.tar.gz
cd ~/
expected_checksum="f73ef8cb0ba3d00bcff28e3de4eb8048c522439cff1d035adee5c1b31e3b62f8"
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

