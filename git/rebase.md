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

## 参考
- [git rebaseを初めて使った際のまとめ](https://qiita.com/310ma3/items/e0ec74b47c6c219f2a8b)
- [初心者でもわかる！リベースの使い方を解説します](https://liginc.co.jp/web/tool/79390)

