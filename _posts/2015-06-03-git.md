# Ignoring an already checked-in directory
```
git rm -r --cached <your directory>
```
The -r option causes the removal of all files under your directory.
The --cached option causes the files to only be removed from git's index, not your working copy. By default git rm <file> would delete <file>

# push a new local branch to a remote Git repository and track it
```
git checkout -b <branch>  | git branch <branch>
git push -u origin <branch>
```

# Adding Only Untracked Files

git add -i. Type a (for "add untracked"), then * (for "all"), then q (to quit)


# Discard all Changes not staged for commit
git checkout -- .

# Create a new empty branch and import from svn
```
git checkout --orphan <branchname>
git rm --cached -r .
svn checkout 
git add .
git commit -m "backup from svn tag"
git push --set-upstream origin <branchname>
```

# save username and password in git
```
git config credential.helper store
then
git pull
```
~/.git-credentials


# I delete a Git branch both locally and remotely
Executive Summary
$ git push -d origin <branch_name>
$ git branch -d <branch_name>
Delete Local Branch
To delete the local branch use:

$ git branch -d branch_name
or use:
$ git branch -D branch_name
As of Git v1.7.0, you can delete a remote branch using
$ git push origin --delete <branch_name>


# git without proxy
*method 1*
```
$ env|grep proxy
http_proxy=http://192.168.0.119:3128/
socks_proxy=socks://192.168.0.119:3128/
https_proxy=https://192.168.0.119:3128/
$ unset http_proxy
$ git pull
```
*method 2(proxy for certain git urls/domains)*
```
@web:~/workspace/git/pub$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[http]
    proxy = ""
[https]
    proxy = ""
```

https://www.andrewpage.me/tracking-down-bugs-with-git-bisect/
https://medium.com/@fredrikmorken/why-you-should-stop-using-git-rebase-5552bee4fed1

