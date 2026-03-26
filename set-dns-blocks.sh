#!/usr/bin/sh
curl -sSLo ~/hosts.tar.gz https://github.com/trevorsuper/sc/raw/refs/heads/master/files/hosts.tar.gz
cd ~/
expected_checksum="63b4c0050f20d7cf22be69ef3629f2cc5a8adc833675208e10f5cbae3b63f4b0"
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

