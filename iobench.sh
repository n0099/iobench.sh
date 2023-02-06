#!/bin/bash
# set -x

if [ $# -eq 0 ]; then
    echo 'Usage: iobench.sh <fileNum>x<fileTotalSize>
    e.g. (./iobench.sh 2/1G 2>&1 >/dev/tty) | column -t'
    exit
fi

bench() {
    (
        echo -n "$2 $5 $1 "
        sysbench fileio --threads="$1" --file-block-size="$2" --file-total-size="$3" --file-num="$4" --file-test-mode="$5" run \
            | grep -P '^\s+((read|write)s/s|(read|written), MiB/s|avg|95th percentile):\s+\d+\.\d+$' \
            | awk -F: '{print $2}' \
            | xargs # https://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable/12973694#12973694
    ) >&2
}

param=$1
params=(${param//\// }) # https://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash/5257398#5257398
fileNum=${params[0]}
totalSize=${params[1]}
echo blockSize testMode threads rdIOps wrIOps rdMiBps wrMiBps latMsAvg latMs95th >&2
sysbench fileio --file-total-size="$totalSize" --file-num="$fileNum" prepare
for threads in 1 16; do
    for block in 4k 1m; do
        for seqRnd in seq rnd; do
            for readWrite in rd wr; do
                mode="$seqRnd$readWrite";
                echo "running $mode with block size $block and $threads threads";
                bench "$threads" "$block" "$totalSize" "$fileNum" "$mode"
            done
        done
        bench "$threads" "$block" "$totalSize" "$fileNum" rndrw
    done
done
sysbench fileio --file-total-size="$totalSize" --file-num="$fileNum" cleanup
