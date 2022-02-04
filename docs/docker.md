# docker

docker-compose run rails rails new . --force --database=postgresql --skip-bundle

docker-compose build

docker-compose up -d

docker-compose down --rmi all --volumes


Dockerを用いてRuby on Railsの環境構築をする方法( Docker初学者向け )
https://qiita.com/Yusuke_Hoirta/items/3a50d066af3bafbb8641

docker-composeでRails+PostgreSQL+Redis+Sidekiq環境を作る
https://snyt45.com/posts/20210610/rails-sidekiq/

Docker for Macを使っていたら50GB位ディスク容量を圧迫していたのでいろんなものを削除する
https://qiita.com/shinespark/items/526b70b5f0b1ac643ba0
