## [sysbench fileio](https://github.com/akopytov/sysbench) based disk io benchmark with common metrics

## Usage: `iobench.sh <fileNum>/<fileTotalSize>`
`sysbench fileio` will create some files under the current working directory named starts from `test_file.0` to `test_file.<fileNum>` and have a total sum of sizes equal to `<fileTotalSize>`, so each file will have a size of `<fileNum>/<fileTotalSize>`.
`iobench.sh` will invoke `sysbench fileio` to do combinations of some common params and convert the human-readable report in its `stdout` to space separated tuples into `stderr` for any further summary analysis about the performance of block device behind testing [`pwd`](https://en.wikipedia.org/wiki/Pwd).

## Example
```bash
[/mnt]$ (./iobench.sh 2/1G 2>&1 >/dev/tty) | column -t
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Extending existing file test_file.1
939524096 bytes written in 7.73 seconds (115.88 MiB/sec).
running seqrd with block size 4k and 1 threads
running seqrd with block size 4k and 16 threads
running seqwr with block size 4k and 1 threads
running seqwr with block size 4k and 16 threads
running rndrd with block size 4k and 1 threads
running rndrd with block size 4k and 16 threads
running rndwr with block size 4k and 1 threads
running rndwr with block size 4k and 16 threads
running seqrd with block size 1m and 1 threads
running seqrd with block size 1m and 16 threads
running seqwr with block size 1m and 1 threads
running seqwr with block size 1m and 16 threads
running rndrd with block size 1m and 1 threads
running rndrd with block size 1m and 16 threads
running rndwr with block size 1m and 1 threads
running rndwr with block size 1m and 16 threads
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Removing test files...
blockSize  testMode  threads  rdIOps    wrIOps    rdMiBps  wrMiBps  latMsAvg  latMs95th
4k         seqrd     1        29923.57  0.00      116.89   0.00     0.03      0.00
4k         seqrd     16       35907.38  0.00      140.26   0.00     0.44      0.53
4k         seqwr     1        0.00      28229.16  0.00     110.27   0.03      0.01
4k         seqwr     16       0.00      29365.91  0.00     114.71   0.53      0.02
4k         rndrd     1        12517.33  0.00      48.90    0.00     0.08      0.36
4k         rndrd     16       52201.73  0.00      203.91   0.00     0.31      0.58
4k         rndwr     1        0.00      19021.70  0.00     74.30    0.05      0.01
4k         rndwr     16       0.00      19395.98  0.00     75.77    0.81      0.01
4k         rndrw     16       20299.72  13532.52  79.30    52.86    0.46      0.80
1m         seqrd     1        360.71    0.00      360.71   0.00     2.77      23.52
1m         seqrd     16       361.46    0.00      361.46   0.00     44.04     153.02
1m         seqwr     1        0.00      106.50    0.00     106.50   9.21      4.57
1m         seqwr     16       0.00      115.81    0.00     115.81   122.97    707.07
1m         rndrd     1        1045.49   0.00      1045.49  0.00     0.95      1.76
1m         rndrd     16       1836.27   0.00      1836.27  0.00     8.70      48.34
1m         rndwr     1        0.00      122.96    0.00     122.96   7.68      0.74
1m         rndwr     16       0.00      126.91    0.00     126.91   118.47    262.64
1m         rndrw     16       123.42    82.19     123.42   82.19    73.21     231.53
```
