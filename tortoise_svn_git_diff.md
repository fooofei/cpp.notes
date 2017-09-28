
### tortoise svn/git settings Diff viewer use beyondcompare
```
"D:\Program Files\Beyond Compare 4\BCompare.exe" %base %mine /title1=%bname /title2=%yname /leftreadonly
```



### svn how to shows diff logs between two branches ?
```
svn mergeinfo --log --show-revs eligible <branch_newer> <branch_older>
# and also show the modified files in every commit
svn mergeinfo --log --verbose --show-revs eligible <branch_newer> <branch_older>
```
`ref http://svnbook.red-bean.com/en/1.7/svn.ref.svn.html#svn.ref.svn.sw.show_revs`


### generate git style diff
```
git diff <original> <changed> >xxx.patch
```

use the patch
```
patch -p1 <xxx.patch
```

## git recursive
if a repo reference another repo, such 
repo `BugId` which located at https://github.com/SkyLined/BugId/tree/master/modules reference the `FileSystem`
(when we click, it located at https://github.com/SkyLined/FileSystem/tree/23ee1bf0839c8088542634913d591c4e4d21e79c)
, when we clone the repo `BugId`, how to clone the reference repo(such as `FileSystem`, `Kill`, etc.)
at the same time ?
the solution is:
1 use the Github Desktop to clone repo `BugId`, and the other repo(such `FileSystem`) will 
auto clone
2 use tortoise_git, check the recursive when clone repo `BugId`