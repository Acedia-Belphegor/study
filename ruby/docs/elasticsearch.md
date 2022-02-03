# elasticsearch

参考
- https://qiita.com/Hitoshi5858/items/02a8e231cb346e5efbf9

elasticsearchインストール
```
$ brew update
$ brew install elasticsearch
```

kuromojiインストール
```
$ ELASTIC_SEARCH_VERSION=$(ls /usr/local/Cellar/elasticsearch/)
$ /usr/local/bin/elasticsearch-plugin/ install "https://artifacts.elastic.co/downloads/elasticsearch-plugins/analysis-kuromoji/analysis-kuromoji-$ELASTIC_SEARCH_VERSION.zip"
```

elasticsearch起動
```
$ cd /usr/local/Cellar/elasticsearch/{version}
$ bin/elasticsearch
```
または
```
$ brew services start elasticsearch
```

疎通確認
```
$ curl http://localhost:9200
{
  "name" : "MacBookPro-yk",
  "cluster_name" : "elasticsearch_brew",
  "cluster_uuid" : "_4lv2u8ZQ8a8i34R0CfMWw",
  "version" : {
    "number" : "7.10.2-SNAPSHOT",
    "build_flavor" : "oss",
    "build_type" : "tar",
    "build_hash" : "unknown",
    "build_date" : "2021-01-16T01:34:41.142971Z",
    "build_snapshot" : true,
    "lucene_version" : "8.7.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

インデックス取得(全件)
```
$ curl -XGET "http://localhost:39200/es_patient_development/_search?pretty=true"
```

インデックス削除
```
$ curl -XDELETE "http://localhost:39200/es_patient_development?pretty=true"
```

kibana (キバナ) => ES向けBIツール
https://dev.classmethod.jp/articles/kibana-for-beginners/

SQLとElasticsearchとのクエリの比較
https://qiita.com/NAO_MK2/items/630f2c4caa0e8a42407c

通常の文字列 : Keyword
全文検索対象 : Text

