#!/usr/bin/sh
arch="$(lscpu | awk ' NR==1 { print $2 } ')"
v=0.15.1
echo "$arch"
echo "$v"
cd ~/
curl -fsSo zig-$arch-linux-$v.tar.xz https://ziglang.org/download/$v/zig-$arch-linux-$v.tar.xz
curl -fsSo zig-$arch-linux-$v.tar.xz.minisig https://ziglang.org/download/$v/zig-$arch-linux-$v.tar.xz.minisig
if [ "$(minisign -Vm zig-$arch-linux-$v.tar.xz -P RWSGOq2NVecA2UPNdBUZykf1CCb147pkmdtYxgb3Ti+JO/wCYvhbAb/U | awk ' NR==1 { print $1, $2, $3, $4, $5 }')" = "Signature and comment signature verified" ]; then
    echo "Signature and comment signature verified"
    tar -xf zig-$arch-linux-$v.tar.xz
    rm zig-$arch-linux-$v.tar.xz zig-$arch-linux-$v.tar.xz.minisig
    echo '' >> ~/.bashrc
    echo 'export PATH="$PATH:~/zig-'$arch'-linux-'$v'/"' >> ~/.bashrc
    source ~/.bashrc
else
    echo ""
    echo "==========================================================================="
    echo ""
    echo "Something has gone wrong with zig installation, manually install and verify"
    echo ""
    echo "==========================================================================="
    echo ""
    rm zig-$arch-linux-$v.tar.xz zig-$arch-linux-$v.tar.xz.minisig
fi