# Maximum tar compression note
tar -c -I 'xz -9' -f 'sc.tar.xz' 'sc'
tar -c -I 'gzip -9' -f 'sc.tar.gz' 'sc'
