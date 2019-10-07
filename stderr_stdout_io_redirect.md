

functional|Windows|Linux
----|----|----
all -> stdout |>1.txt 2>&1 | >1.txt 2>&1
all -> stderr | 2>2.txt 1>&2 | 2>2.txt 1>&2
all -> onefile | all->stdout/stderr>file | all->stdout/stderr>file<br>&>1.txt


## ERROR
1>&2 2>2.txt , 只会把 stderr 输出到文件


## Append to file
```shell
原来的 > 变为 >>
```
