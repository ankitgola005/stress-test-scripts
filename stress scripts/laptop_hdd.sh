#!bin/shell
swapoff -a
i=0
mode=$1
size=$2
count=$3
echo $size

while [ $i -le $count ]
do
    if [ $mode -eq 1 ]
    then
        sync
        dd if=/dev/zero of=/tempfile bs=1M count=4096k
        /sbim/sysctl -w vm.drop_caches=3
        sync
    fi
    #dd if=tempfile of=/dev/null bs=1M count=4096k
    i=$((i+1))
done

