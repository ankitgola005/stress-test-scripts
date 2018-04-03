#!/bin/sh
NPROC=$(nproc --all)
echo $NPROC

#re='^[0-9]+$'
#if ! [[ $NPROC =~ $re ]] ; then
#    NPROC=4
#fi
#
#if [ $# -eq 0 ]
#then
#    mul=4
#fi
#
#if ! [[ $1 =~ $re ]] ; then
#    mul=4
#fi

mul=$1

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

NPROC=`expr $NPROC \* $mul`
while [ "$NPROC" != 0 ]
do
    prime &
    NPROC=`expr $NPROC - 1`
done
