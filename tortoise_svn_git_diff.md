
### tortoise svn/git settings Diff viewer use beyondcompare
```
"D:\Program Files\Beyond Compare 4\BCompare.exe" %base %mine /title1=%bname /title2=%yname /leftreadonly
```



### svn how to shows diff logs between two branches ?
```
svn mergeinfo --log --show-revs eligible <branch_newer> <branch_older>
# and also show the modified files in every commit
svn mergeinfo --log -v --show-revs eligible <branch_newer> <branch_older>
```


### generate git style diff
```
git diff <original> <changed> >xxx.patch
```

use the patch
```
patch -p1 <xxx.patch
```