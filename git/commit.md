# commit

## 現在の状態を確認する
```
$ git status
```
=> 直前のコミットからの差分が表示される
```
$ git status
On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   README.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        git/

no changes added to commit (use "git add" and/or "git commit -a")
```

## git add
```
$ git add <ファイル名>
```
すべての変更ファイルをaddしたい場合は
```
$ git add .
```

## git commit
```
$ git commit -m "コミットメッセージ"
```

## コミットログの確認
```
$ git log
```
=> `c28bbdb92f28972f7f8534e5d53b46c9dd41bd57` がコミットid
```
commit c28bbdb92f28972f7f8534e5d53b46c9dd41bd57 (HEAD -> master)
Author: yoshinori.kodama <yoshinori.kodama@medley.jp>
Date:   Fri Jan 28 11:33:16 2022 +0900

    fix readme
```
簡略化して表示したい場合 (直近のコミット5件)
```
$ git log --oneline -5
```
```
36ff760 (HEAD -> master, origin/master) fix interactor
cc32460 add rails_study
0143931 add ruby
6434fa2 fix git docs
b5f6fcf written rebase.md
```
memo
- コミットidを取得したい場合などに利用する

## コミットの取り消し
直前のコミットを取り消す
```
$ git reset --soft HEAD^
```

## `git log` を見やすく整形する
```
$ vim ~/.gitconfig

[alias]
    plog = log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]' --date=iso
```
```
$ git plog
9a2a4da 2022-01-29 15:39:52 +0900 fix  (HEAD -> generate_scaffold_user, origin/master, master) [Yoshinori]
df5ab0b 2022-01-29 14:00:02 +0900 fix git rebase.md  [Yoshinori]
c1ed34c 2022-01-29 13:08:23 +0900 fix docs  [Yoshinori]
f459306 2022-01-29 12:56:26 +0900 fix interactor  [Yoshinori]
36ff760 2022-01-29 10:26:34 +0900 fix interactor  [yoshinori.kodama]
```

参考
- https://qiita.com/shuntaro_tamura/items/06281261d893acf049ed
