#!/bin/sh
swapoff -a
i=0
mem=$(cat /proc/meminfo | grep MemTotal)
echo $mem
while true
do
    dd if=/dev/zero of=/dev/shm/fill bs=1k count=8182k
    echo $i
    i=$((i+1))
done
