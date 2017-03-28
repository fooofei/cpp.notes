
把本地文件推送到 github 的过程：

1、在远程建立空仓库

2、在本地建立文件夹，在文件夹里保存内容。

3、关联本地仓库和远程仓库 : `cd 本地仓库` ; `git remote add origin  git@github.com:fooofei/cpp_notes.git `
使用 `git remote -v `查看关联结果，如果为 ：
```
origin	git@github.com:fooofei/cpp_notes.git (fetch)
origin	git@github.com:fooofei/cpp_notes.git (push)
```
则表示成功.
如果不成功，要手动 set-url , `git remote set-url origin git@github.com:fooofei/cpp_notes.git`

4、提交新文件和改动 `git add ` ; `git commit -m "comments"`

5、推送到远程 `git push` , 推送失败就用 `git push origin master`