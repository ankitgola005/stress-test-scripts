#!bin/bash
su swapoff -a
i=0
#size=`expr $1 \* 1073741824`
size=1073741824
echo $size

while true
do
    echo $i
    sync
    su
    dd if=/dev/urandom of=/data/local/tmp/ramTest/tempfile bs=1024 count=$size
    sync
    su rm -r /data/dalvic-cache
    su rm -r /cache/dalvic-cache
    su rm -r /data/local/tmp/ramTest/tempfile
    i=$((i+1))
done

