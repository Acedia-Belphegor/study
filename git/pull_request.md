# pull request

リモートリポジトリにpushする（今回の例では `add_files` というブランチ名で）
```
$ git push origin add_files:add_files
Enter passphrase for key '/Users/yoshinori.kodama/.ssh/id_rsa': 
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (8/8), done.
Writing objects: 100% (9/9), 2.03 KiB | 693.00 KiB/s, done.
Total 9 (delta 0), reused 0 (delta 0), pack-reused 0
remote: 
remote: Create a pull request for 'add_files' on GitHub by visiting:
remote:      https://github.com/Acedia-Belphegor/study/pull/new/add_files
remote: 
To github.com:Acedia-Belphegor/study.git
 * [new branch]      add_files -> add_files
```

GitHubにログインすると `Compare & pull request` というボタンが表示されるのでクリックする
![picture 1](../images/c4542158832017303c2cd6ba78a0188e337c78b703c85612675f9a702cf589f9.png)  

pull request を作成する
![picture 2](../images/39c503743c51b9b191b3d99c4aca1746638318ea22a7f6ae0b1705e769e81f7c.png)  

memo
- `base:<ブランチ名>` にマージして欲しいリモートブランチを設定する
  - 一般的な運用ではリリース用のブランチが存在しており、masterやdevelopに直接マージすることは少ない
- Reviewersを設定する
- コメント本文を記述する

`Create pull request` をクリックすると登録される
![picture 3](../images/142e630121d76d57e888335cc334141970dc1f8bc24b26bfbfe29b5fb3053eb1.png)  


## pull requestをレビューする

Reviewersに設定されたユーザーがログインして該当のPRを開くと、右上に `Add your review` ボタンが表示されるのでクリックする
![picture 4](../images/56b3a368c4c3db6d6ffb5b53289efaf32b093d5d96c1f952ebd8e6693f2f67b9.png)  

参考
- https://howpon.com/6351

