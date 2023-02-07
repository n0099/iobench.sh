## [sysbench fileio](https://github.com/akopytov/sysbench) based disk io benchmark with common metrics
Just another simple wrapper over `sysbench fileio` to output a table of common metrics.

### Usage: `iobench.sh [-t] <fileNum>/<fileTotalSize>`
`sysbench fileio` will create some files under the current working directory named starts from `test_file.0` to `test_file.<fileNum>` and have a total sum of sizes equal to `<fileTotalSize>`, so the size of each `test_file` is `<fileNum>/<fileTotalSize>`.

`iobench.sh` will invoke `sysbench fileio` to do combinations of some common params and convert the human-readable report in its `stdout` to space separated tuples into `stderr` for any further summary analysis about the performance of the file system and its block device behind testing [`pwd`](https://en.wikipedia.org/wiki/Pwd).

### Example:
```bash
$ ./iobench.sh 2/1G 2> >((sed -u 1q; sort -k2.5,2.6 -k3,3 -k1hr,1) | column -t)
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
blockSize  testMode  threads  rdIOps     wrIOps    rdMiBps  wrMiBps  latMsAvg  latMs95th
4k         rndrd     1        534324.08  0.00      2087.20  0.00     0.00      0.00
4k         seqrd     1        689408.74  0.00      2693.00  0.00     0.00      0.00
1m         rndrd     1        5525.08    0.00      5525.08  0.00     0.18      0.22
1m         seqrd     1        5912.00    0.00      5912.00  0.00     0.17      0.20
4k         rndrd     16       515271.32  0.00      2012.78  0.00     0.03      0.00
4k         seqrd     16       894866.27  0.00      3495.57  0.00     0.02      0.00
1m         rndrd     16       6728.51    0.00      6728.51  0.00     2.36      23.95
1m         seqrd     16       6013.90    0.00      6013.90  0.00     2.65      24.38
4k         rndrw     1        28345.71   18897.14  110.73   73.82    0.02      0.01
1m         rndrw     1        179.65     119.76    179.65   119.76   3.27      0.38
4k         rndrw     16       28891.83   19261.22  112.86   75.24    0.33      0.01
1m         rndrw     16       186.84     124.56    186.84   124.56   50.31     20.74
4k         rndwr     1        0.00       19210.84  0.00     75.04    0.05      0.00
4k         seqwr     1        0.00       28544.05  0.00     111.50   0.03      0.01
1m         rndwr     1        0.00       122.52    0.00     122.52   7.71      0.44
1m         seqwr     1        0.00       111.48    0.00     111.48   8.80      0.94
4k         rndwr     16       0.00       19370.95  0.00     75.67    0.81      0.01
4k         seqwr     16       0.00       29467.31  0.00     115.11   0.53      0.02
1m         rndwr     16       0.00       136.90    0.00     136.90   110.97    71.83
1m         seqwr     16       0.00       117.21    0.00     117.21   113.98    383.33
```
