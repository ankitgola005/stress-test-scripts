#!bin/shell
swapoff -a
i=0
while true
do
    echo $i
    sync
    dd if=/dev/zero of=/tempfile bs=1M count=4096k
    sync
    /sbim/sysctl -w vm.drop_caches=3
    dd if=tempfile of=/dev/null bs=1M count=4096k
    i=$((i+1))
done

