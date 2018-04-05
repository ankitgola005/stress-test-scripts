#!bin/bash
su swapoff -a
i=0
size=`expr $1 \* 1048576`
echo $size

while true
do
    echo $i
    sync
    dd if=/dev/zero of=/sdcard/tempfile bs=1M count=$size
    sync
    su rm -r /data/dalvik-cache
    su rm -r /cache/dalvik-cache
    su rm -r /sdcard/tempfile
    i=$((i+1))
done

