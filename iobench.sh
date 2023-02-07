#!/bin/bash

usage() {
    echo 'Usage: iobench.sh [-v] <fileNum>/<fileTotalSize>
    e.g. ./iobench.sh 2/1G 2> >((sed -u 1q; sort -k2.5,2.6 -k3,3 -k1hr,1) | column -t)'
    exit 1
}
# https://stackoverflow.com/questions/16483119/an-example-of-how-to-use-getopts-in-bash/16496491#16496491
while getopts "v" o; do
    case "${o}" in
        v)
            export VERBOSE=1;;
        *)
            usage;;
    esac
done
shift $((OPTIND-1))

bench() {
    [[ $VERBOSE = 1 ]] && echo
    echo "running $5 with block size $2 and $1 threads";
    [[ $VERBOSE = 1 ]] && echo
    (
        echo -n "$2 $5 $1 "
        (
            sysbench fileio --threads="$1" --file-block-size="$2" --file-total-size="$3" --file-num="$4" --file-test-mode="$5" run \
            | tee "$([[ $VERBOSE = 1 ]] && echo /dev/fd/2 || echo /dev/null)" # https://stackoverflow.com/questions/3953645/ternary-operator-in-bash/3953666#3953666
        ) \
            | grep -P '^\s+((read|write)s/s|(read|written), MiB/s|avg|95th percentile):\s+\d+\.\d+$' \
            | awk -F: '{print $2}' \
            | xargs # https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable/12973694#12973694
    ) 3>&2 2>&1 1>&3 # https://stackoverflow.com/questions/13299317/io-redirection-swapping-stdout-and-stderr/13299397#13299397
}
prepare() {
    [[ $VERBOSE = 1 ]] && echo
    echo "prepare $1 files with a total size of $2";
    [[ $VERBOSE = 1 ]] && echo
    sysbench fileio --file-total-size="$2" --file-num="$1" prepare
}

param=$1
params=(${param//\// }) # https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash/5257398#5257398
fileNum=${params[0]}
totalSize=${params[1]}
device=$(df -P "$(pwd)" | awk 'END{print $1}')
echo testing the file system "$device" behind "$(pwd)"

prepare "$fileNum" "$totalSize"
echo blockSize testMode threads rdIOps wrIOps rdMiBps wrMiBps latMsAvg latMs95th >&2
for threads in 1 16; do
    for block in 4k 1m; do
        for seqRnd in rnd seq; do
            for readWrite in rd wr; do
                mode="$seqRnd$readWrite";
                bench "$threads" "$block" "$totalSize" "$fileNum" "$mode"
            done
        done
        prepare "$fileNum" "$totalSize" # https://github.com/akopytov/sysbench/issues/385
        bench "$threads" "$block" "$totalSize" "$fileNum" rndrw
    done
done
sysbench fileio --file-total-size="$totalSize" --file-num="$fileNum" cleanup
