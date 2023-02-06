## [sysbench fileio](https://github.com/akopytov/sysbench) based disk io benchmark with common metrics
Just another simple wrapper over `sysbench fileio` to output a table of common metrics.

### Usage: `iobench.sh <fileNum>/<fileTotalSize>`
`sysbench fileio` will create some files under the current working directory named starts from `test_file.0` to `test_file.<fileNum>` and have a total sum of sizes equal to `<fileTotalSize>`, so the size of each `test_file` is `<fileNum>/<fileTotalSize>`.

`iobench.sh` will invoke `sysbench fileio` to do combinations of some common params and convert the human-readable report in its `stdout` to space separated tuples into `stderr` for any further summary analysis about the performance of block device behind testing [`pwd`](https://en.wikipedia.org/wiki/Pwd).

### Example:
```bash
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

2 files, 524288Kb each, 1024Mb total
Creating files for the test...
Extra file open flags: (none)
Creating file test_file.0
Creating file test_file.1
1073741824 bytes written in 8.90 seconds (115.12 MiB/sec).
running seqrd with block size 4k and 1 threads
running seqwr with block size 4k and 1 threads
running rndrd with block size 4k and 1 threads
running rndwr with block size 4k and 1 threads
running seqrd with block size 1m and 1 threads
running seqwr with block size 1m and 1 threads
running rndrd with block size 1m and 1 threads
running rndwr with block size 1m and 1 threads
running seqrd with block size 4k and 16 threads
running seqwr with block size 4k and 16 threads
running rndrd with block size 4k and 16 threads
running rndwr with block size 4k and 16 threads
running seqrd with block size 1m and 16 threads
running seqwr with block size 1m and 16 threads
running rndrd with block size 1m and 16 threads
running rndwr with block size 1m and 16 threads
sysbench 1.0.20 (using system LuaJIT 2.1.0-beta3)

Removing test files...
blockSize  testMode  threads  rdIOps     wrIOps    rdMiBps  wrMiBps  latMsAvg  latMs95th
4k         seqrd     1        29849.55   0.00      116.60   0.00     0.03      0.00
4k         seqwr     1        0.00       28414.26  0.00     110.99   0.03      0.01
4k         rndrd     1        18872.67   0.00      73.72    0.00     0.05      0.29
4k         rndwr     1        0.00       18904.15  0.00     73.84    0.05      0.01
4k         rndrw     1        11723.98   7815.99   45.80    30.53    0.05      0.28
1m         seqrd     1        1148.89    0.00      1148.89  0.00     0.87      1.21
1m         seqwr     1        0.00       109.84    0.00     109.84   8.92      1.27
1m         rndrd     1        3768.71    0.00      3768.71  0.00     0.26      0.37
1m         rndwr     1        0.00       120.12    0.00     120.12   8.04      0.75
1m         rndrw     1        116.07     77.35     116.07   77.35    4.91      7.98
4k         seqrd     16       40277.35   0.00      157.33   0.00     0.40      0.64
4k         seqwr     16       0.00       29317.30  0.00     114.52   0.53      0.02
4k         rndrd     16       362198.31  0.00      1414.84  0.00     0.04      0.00
4k         rndwr     16       0.00       19311.81  0.00     75.44    0.81      0.01
4k         rndrw     16       25602.92   17067.95  100.01   66.67    0.37      0.30
1m         seqrd     16       322.24     0.00      322.24   0.00     49.56     142.39
1m         seqwr     16       0.00       115.71    0.00     115.71   119.21    601.29
1m         rndrd     16       2542.94    0.00      2542.94  0.00     6.28      39.65
1m         rndwr     16       0.00       129.77    0.00     129.77   118.14    257.95
1m         rndrw     16       189.32     125.68    189.32   125.68   48.13     45.79
```
