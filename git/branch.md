# branch

現在のローカルブランチを確認する
```
$ git branch
```

ブランチ切り替え
```
$ git checkout fix_hogehoge
```

作業ブランチの作成 ＆ 作業ブランチに切り替え
```
$ git checkout -b new_hogehoge
```

ローカルブランチを削除する(強制的に削除する場合は -D)
```
$ git branch -d fix_hogehoge
```

リモートブランチを確認する
```
$ git branch -r 
```

リモートブランチをローカルにコピーする
```
$ git checkout -b <ローカルブランチ名> origin/<リモートブランチ名>
```

別ユーザーのリモートブランチをローカルにコピーする
```
$ git fetch
$ git checkout -b <ローカルに作成するブランチ名> origin/<リモートブランチ名>
```