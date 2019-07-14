#!/bin/sh
NPROC=$(nproc --all)    # Query number of cores
echo $NPROC

mul=$1      # Thread multiplier. Spawn this number of threads per core

# Check whether a number is prime
prime(){
    num=2
    while true
    do
        num=`expr $num + 1`
        div=2
        dlim=`expr $num / 2`
        dlim=`expr $dlim + 1`

        while [ "$div" -lt "$dlim" ]
        do
            rem=`expr $num % $div`
            if [ "$rem" -eq 0 ]
            then
                echo "$num is not prime"
                break
            fi
            div=`expr $div + 1`
        done
        if [ "$div" -eq "$dlim" ]
        then
            echo "$num is prime"
        fi
    done
}

# spawn threads
NPROC=`expr $NPROC \* $mul`
while [ "$NPROC" != 0 ]
do
    prime &
    NPROC=`expr $NPROC - 1`
done
