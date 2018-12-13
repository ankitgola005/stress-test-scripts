#!/bin/sh
swapoff -a
i=0
mem=$(cat /proc/meminfo | grep MemTotal)
memActive=$1
count=$3
echo $mem

while [ $i -le $count ]
do
    if [$memActive eq 1]
    then
        dd if=/dev/zero of=/dev/shm/fill bs=1k count=1024k
    fi
    #echo $i
    i=$((i+1))
done
