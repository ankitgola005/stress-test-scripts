#!bin/bash
su swapoff -a
i=0
mode=$1     # Stress enabled = 1,
size=$2     # Data size to be written every for every stress test
count=$3    #Number of times to run the test

while [ $i -le $count ]
do
    if [ $mode -eq 1 ]
    then
        dd if=/dev/urandom of=/data/local/tmp/ramTest/tempfile bs=256 count=$size   # Write data
    fi
    i=$((i+1))
done
