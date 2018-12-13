#!bin/bash
su swapoff -a
i=0
#size=`expr $1 \* 1073741824`
mode=$1
size=$2
count=$3
echo $size

while [ $i -le $count ]
do

    #echo $i
    if [ $mode -eq 1 ]
    then
        sync
        dd if=/dev/urandom of=/sdcard/tempfile bs=1024 count=$size
        sync
    fi
    su rm -r /data/dalvik-cache
    su rm -r /cache/dalvik-cache
    su rm -r /sdcard/tempfile
    i=$((i+1))
done
