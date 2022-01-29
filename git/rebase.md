# rebase

作業ブランチにmasterブランチの修正内容を反映する

## ローカルのmasterブランチを最新化する
```
$ git checkout master
$ git pull origin master
```

## 作業ブランチをrebaseする
```
$ git checkout fix_git_md
$ git rebase master
```

## コミットログ
masterブランチの最終コミットの後に作業ブランチのコミットが追記されている
```
$ git log
commit eb312bb1aaccb076ab9bd0766847fba14c77d004 (HEAD -> fix_git_md)
Author: yoshinori.kodama <yoshinori.kodama@medley.jp>
Date:   Fri Jan 28 15:11:41 2022 +0900

    fix git docs

commit bddc038314c4385a94000e6c1691f9180eef1318
Author: yoshinori.kodama <yoshinori.kodama@medley.jp>
Date:   Fri Jan 28 14:33:54 2022 +0900

    written pull_request.md

commit 554b0c93c5406170b25d5233ddb739f31b6dfb91 (origin/master, origin/HEAD, master)
Author: Yoshinori <acedia-belphegor.7@gmail.com>
Date:   Fri Jan 28 15:04:07 2022 +0900

    rebase test
```

## push

rebase前後でコミットハッシュが変更されるため、そのままpushしても失敗する

rebase前 => `edde51e07a14a5597015dd3b66499e447b87ed57`
```
commit edde51e07a14a5597015dd3b66499e447b87ed57 (HEAD -> fix_git_md, origin/fix_git_md)
Author: yoshinori.kodama <yoshinori.kodama@medley.jp>
Date:   Fri Jan 28 14:33:54 2022 +0900

    written pull_request.md
```
rebase後 => `bddc038314c4385a94000e6c1691f9180eef1318`
```
commit bddc038314c4385a94000e6c1691f9180eef1318
Author: yoshinori.kodama <yoshinori.kodama@medley.jp>
Date:   Fri Jan 28 14:33:54 2022 +0900

    written pull_request.md
```
そのままpushしてみる
```
$ git push origin fix_git_md
Enter passphrase for key '/Users/yoshinori.kodama/.ssh/id_rsa': 
To github.com:Acedia-Belphegor/study.git
 ! [rejected]        fix_git_md -> fix_git_md (non-fast-forward)
error: failed to push some refs to 'git@github.com:Acedia-Belphegor/study.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```
強制push (-f オプション) すれば成功する
```
$ git push -f origin fix_git_md
```

memo
- 他の人も使っているリモートブランチに強制pushするのはだめ

## コミットを１つにまとめる
```
$ git rebase -i <commit_id>
```

`git log` でコミットログを確認する
```
$ git log --oneline
c1ed34c (HEAD -> rebase_test, master) fix docs
f459306 fix interactor
36ff760 (origin/master) fix interactor
cc32460 add rails_study
0143931 add ruby
6434fa2 fix git docs
b5f6fcf written rebase.md
eb312bb fix git docs
bddc038 written pull_request.md
554b0c9 rebase test
9820a61 Merge pull request #1 from Acedia-Belphegor/add_files
80fe535 add files
e4a0388 (fork1) first commit
```

基準となるコミットidを入力する
（`9820a61` が直前のコミットとなり、このコミットの直後にこれからまとめるコミットが１つだけ存在する状態にする）
```
$ git rebase -i 9820a61
```

最後のコミット(`554b0c9`)だけ `pick` 他のコミットは `squash` に修正し、:wq でエディタを閉じる
```
pick 554b0c9 rebase test
squash bddc038 written pull_request.md # pick => squash
squash eb312bb fix git docs # pick => squash
squash b5f6fcf written rebase.md # pick => squash
squash 6434fa2 fix git docs # pick => squash
squash 0143931 add ruby # pick => squash
squash cc32460 add rails_study # pick => squash
squash 36ff760 fix interactor # pick => squash
squash f459306 fix interactor # pick => squash
squash c1ed34c fix docs # pick => squash

# Rebase 9820a61..c1ed34c onto 36ff760 (10 commands)
#
# Commands:
# p, pick <commit> = use commit
# r, reword <commit> = use commit, but edit the commit message
# e, edit <commit> = use commit, but stop for amending
# s, squash <commit> = use commit, but meld into previous commit
# f, fixup <commit> = like "squash", but discard this commit's log message
# x, exec <command> = run command (the rest of the line) using shell
# b, break = stop here (continue rebase later with 'git rebase --continue')
# d, drop <commit> = remove commit
# l, label <label> = label current HEAD with a name
# t, reset <label> = reset HEAD to a label
# m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]
# .       create a merge commit using the original merge commit's
# .       message (or the oneline, if no original merge commit was
# .       specified). Use -c <commit> to reword the commit message.
#
# These lines can be re-ordered; they are executed from top to bottom.
#
# If you remove a line here THAT COMMIT WILL BE LOST.
#
# However, if you remove everything, the rebase will be aborted.
#
# Note that empty commits are commented out
```

再度エディタが開くので、まとめたコミットに対するコミットメッセージを記入して、:wq でエディタを閉じる
```
rebased # <= これを追記した

# This is a combination of 10 commits.
# This is the 1st commit message:

rebase test

# This is the commit message #2:

written pull_request.md

# This is the commit message #3:

fix git docs

# This is the commit message #4:

written rebase.md

# This is the commit message #5:

fix git docs

# This is the commit message #6:

add ruby

# This is the commit message #7:

add rails_study

# This is the commit message #8:

fix interactor

# This is the commit message #9:

fix interactor

# This is the commit message #10:

fix docs

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
...
```

`git log` でコミットログを確認すると、まとまっている
```
$ git log --oneline
be5b417 (HEAD -> rebase_test) rebased
9820a61 Merge pull request #1 from Acedia-Belphegor/add_files
80fe535 add files
e4a0388 (fork1) first commit
```

## 参考
- [git rebaseを初めて使った際のまとめ](https://qiita.com/310ma3/items/e0ec74b47c6c219f2a8b)
- [初心者でもわかる！リベースの使い方を解説します](https://liginc.co.jp/web/tool/79390)

