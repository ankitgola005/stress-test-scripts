#!bin/bash
su swapoff -a
i=0
#size=`expr $1 \* 1073741824`
mode=$1
size=$2
count=$3
#echo $size

while [ $i -le $count ]
do
    #echo $i
    #sync
    if [ $mode -eq 1 ]
    then
        dd if=/dev/urandom of=/data/local/tmp/ramTest/tempfile bs=256 count=$size
    fi
    #sync
    i=$((i+1))
    #su rm -r /data/dalvic-cache
    #su rm -r /cache/dalvic-cache
    #su rm -r /data/local/tmp/ramTest/tempfile
done

