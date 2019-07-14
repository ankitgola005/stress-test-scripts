#!bin/bash
su swapoff -a
i=0
mode=$1     # Stress enable = 1, stress disabled = 0
size=$2     # data size to write
count=$3    # Number of times to repeat the stressing
echo $size

while [ $i -le $count ]
do
    if [ $mode -eq 1 ]  # If stressing enabled
    then
        sync
        dd if=/dev/urandom of=/sdcard/tempfile bs=1024 count=$size  # copy data to hdd
        sync
    fi
    
    su rm -r /data/dalvik-cache
    su rm -r /cache/dalvik-cache
    su rm -r /sdcard/tempfile   # Delete written data
    i=$((i+1))
done
