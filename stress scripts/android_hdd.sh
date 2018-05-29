#!bin/bash
su swapoff -a
i=0
size=`expr $1 \* 1073741824`
echo $size

while true
do
    echo $i
    sync
    dd if=/dev/urandom of=/sdcard/tempfile bs=1024 count=$size
    sync
    su rm -r /data/dalvik-cache
    su rm -r /cache/dalvik-cache
    su rm -r /sdcard/tempfile
    i=$((i+1))
done

