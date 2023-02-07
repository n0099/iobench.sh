## [sysbench fileio](https://github.com/akopytov/sysbench) based disk io benchmark with common metrics
Just another simple wrapper over `sysbench fileio` to output a table of common metrics.

### Usage: `iobench.sh [-t] <fileNum>/<fileTotalSize>`
`sysbench fileio` will create some files under the current working directory named starts from `test_file.0` to `test_file.<fileNum>` and have a total sum of sizes equal to `<fileTotalSize>`, so the size of each `test_file` is `<fileNum>/<fileTotalSize>`.

`iobench.sh` will invoke `sysbench fileio` to do combinations of some common params and convert the human-readable report in its `stdout` to space separated tuples into `stderr` for any further summary analysis about the performance of the file system and its block device behind testing [`pwd`](https://en.wikipedia.org/wiki/Pwd).

### Example:
```bash
$ ./iobench.sh 2/1G 2> >((sed -u 1q; sort -k2.5,2.6 -k1h,1 -k3,3) | column -t)
testing the file system /dev/sdb1 behind /mnt
prepare 2 files with a total size of 1G
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
1073741824 bytes written in 8.93 seconds (114.70 MiB/sec).
running rndrd with block size 4k and 1 threads
running rndwr with block size 4k and 1 threads
running seqrd with block size 4k and 1 threads
running seqwr with block size 4k and 1 threads
prepare 2 files with a total size of 1G
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Reusing existing file test_file.0
Reusing existing file test_file.1
No bytes written.
running rndrw with block size 4k and 1 threads
running rndrd with block size 1m and 1 threads
running rndwr with block size 1m and 1 threads
running seqrd with block size 1m and 1 threads
running seqwr with block size 1m and 1 threads
prepare 2 files with a total size of 1G
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Reusing existing file test_file.0
Reusing existing file test_file.1
No bytes written.
running rndrw with block size 1m and 1 threads
running rndrd with block size 4k and 16 threads
running rndwr with block size 4k and 16 threads
running seqrd with block size 4k and 16 threads
running seqwr with block size 4k and 16 threads
prepare 2 files with a total size of 1G
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Reusing existing file test_file.0
Reusing existing file test_file.1
No bytes written.
running rndrw with block size 4k and 16 threads
running rndrd with block size 1m and 16 threads
running rndwr with block size 1m and 16 threads
running seqrd with block size 1m and 16 threads
running seqwr with block size 1m and 16 threads
prepare 2 files with a total size of 1G
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Reusing existing file test_file.0
Reusing existing file test_file.1
No bytes written.
running rndrw with block size 1m and 16 threads
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Removing test files...
blockSize  testMode  threads  rdIOps      wrIOps    rdMiBps   wrMiBps  latMsAvg  latMs95th
4k         rndrd     1        1008748.32  0.00      3940.42   0.00     0.00      0.00
4k         seqrd     1        1431434.07  0.00      5591.54   0.00     0.00      0.00
4k         rndrd     16       1352502.73  0.00      5283.21   0.00     0.01      0.00
4k         seqrd     16       1704782.16  0.00      6659.31   0.00     0.01      0.00
64k        rndrd     1        118493.54   0.00      7405.85   0.00     0.01      0.01
64k        seqrd     1        160453.34   0.00      10028.33  0.00     0.01      0.01
64k        rndrd     16       248927.40   0.00      15557.96  0.00     0.06      0.01
64k        seqrd     16       264553.16   0.00      16534.57  0.00     0.06      0.01
4k         rndrw     1        13615.73    9077.15   53.19     35.46    0.04      0.00
4k         rndrw     16       13704.99    9136.66   53.54     35.69    0.69      0.00
64k        rndrw     1        4659.53     3106.35   291.22    194.15   0.13      0.02
64k        rndrw     16       4668.42     3112.28   291.78    194.52   2.02      0.03
4k         rndwr     1        0.00        9090.29   0.00      35.51    0.11      0.00
4k         seqwr     1        0.00        49497.10  0.00      193.35   0.02      0.00
4k         rndwr     16       0.00        9178.70   0.00      35.85    1.71      0.00
4k         seqwr     16       0.00        43639.89  0.00      170.47   0.36      0.01
64k        rndwr     1        0.00        3179.90   0.00      198.74   0.31      0.03
64k        seqwr     1        0.00        3189.06   0.00      199.32   0.31      0.04
64k        rndwr     16       0.00        3232.92   0.00      202.06   4.85      0.03
64k        seqwr     16       0.00        3201.00   0.00      200.06   4.90      0.09
```
