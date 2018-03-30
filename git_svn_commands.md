
# 记录使用到的 svn 参数

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

  发版本写日志使用
  
# 记录使用到的 Git 参数


  ### 很久以前 本地文件推送到 GitHub 的过程 现在都用 Sourcetree

    #### old

    把本地文件推送到 github 的过程：

    1 在远程建立空仓库

    2 在本地建立文件夹，在文件夹里保存内容。

    3 关联本地仓库和远程仓库 : `cd 本地仓库` ; `git remote add origin  git@github.com:fooofei/cpp_notes.git `
    使用 `git remote -v `查看关联结果，如果为 ：
    ```
    origin	git@github.com:fooofei/cpp_notes.git (fetch)
    origin	git@github.com:fooofei/cpp_notes.git (push)
    ```
    则表示成功.
    如果不成功，要手动 set-url , `git remote set-url origin git@github.com:fooofei/cpp_notes.git`

    4 提交新文件和改动 `git add ` ; `git commit -m "comments"`

    5 推送到远程 `git push` , 推送失败就用 `git push origin master`
    
    
    #### new
    
    1 在远程建立空仓库
    
    2 git clone 到本地 
    
    3 在本地修改  
    
    4 推送到远程 
    
  ### like svn log -v
  git log --name-status --find-renames
  
  
  ### list all remote branches
  git branch -av
  
  
  ### .gitignore
  A collection of useful .gitignore templates https://github.com/github/gitignore
  
  
  ### Git CRLF 换行符 Windows unix 一致
  Git 有在 Windows linux 平台自适应的功能 咱们不要这个功能 咱们强制在 Windows linux 平台使用 LF 换行
  https://github.com/cssmagic/blog/issues/22 

  expect:
  ```ini
  [core]
      autocrlf = false
      safecrlf = true
  ```    
  ### Git 教程
  Git 在线情景性教程 https://learngitbranching.js.org/
  
  ### Git clone specifi branch
  `git clone -b <branch_name>`
  
  ### Git config
  /etc/gitconfig
  ~/.gitconfig 当前登录用户的配置
  <project>/.git/config
  
  往下优先级越高 会覆盖优先级低的
  
  一份
  ```ini
  [alias]
    last = log -1 --stat
    cp = cherry-pick
    co = checkout
    cl = clone
    ci = commit
    st = status -sb
    br = branch
    unstage = reset HEAD --
    dc = diff --cached
    lg = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --abbrev-commit --date=relative --all
  [difftool "sourcetree"]
    cmd = 'C:/Program Files/Beyond Compare 4/BComp.exe' \"$LOCAL\" \"$REMOTE\"
  ```

  
  ### Git proxy
  ```ini
  [http]
      proxy = http://
  ```
  
  
  ### generate git style diff
  ```
  git diff <original> <changed> >xxx.patch
  ```
  use the patch
  ```
  patch -p1 <xxx.patch
  ```

  ### Windows Git 客户端
  Sourcetree 
    缺点 老是崩溃 性能也不好  主观上的不好
    优点 能自动 fetch 如果本地仓库错过了远程仓库的提交 会有角标提示 在本地提交代码时很有用 
         防止本地提交代码 因为远程比本地新而发生冲突
         能在 commit log 中显示 commiter 邮箱
  tortoise git
    缺点 无法显示本地仓库是否落下了远程仓库 远程仓库是否是比本地新
    优点 性能好