# aliase切り替え検証

手順はすべてkibanaで実行する。

## 事前準備

以下が存在すること

* 変更前のindex(before_index)
* 変更後のindex(after_index)

## エイリアス追加

現在のエイリアスの確認
```
GET /_aliases
```

エイリアスの新規追加
```
POST /_aliases
{
  "actions" : [
    { "add" : { "index" : "before_index", "alias" : "aliase_name" } },
  ]
}
```

追加後のエイリアスの確認
```
GET /_aliases
```

結果
```
{
  ".kibana": {
    "aliases": {}
  },
  "before_index": {
    "aliases": {
      "aliase_name": {}
    }
  },
}
```

以下で同じ結果が返ってくることを確認する

indexへのクエリ
```
GET /before_index/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "keyword": "word"
          }
        }
      ]
    }
  }
}
```

エイリアスへのクエリ
```
GET /aliase_name/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "keyword": "word"
          }
        }
      ]
    }
  }
}
```

## エイリアスコマンド実行前後の確認コマンド

```sh
while true
do 
  curl -Ss -o result/result_`date "+%Y%m%d-%H%M%S.%3N"`.json -XGET URL/aliase_name/_search?pretty=true -d @json/query.json
  sleep 0.1
done
```

エイリアス切り替えコマンド
```
POST /_aliases
{
  "actions" : [
    { "remove" : { "index" : "before_index", "alias" : "aliase_name" } },
    { "add" : { "index" : "after_index", "alias" : "aliase_name" } },
  ]
}
```

```
POST /_aliases
{
  "actions" : [
    { "remove" : { "index" : "before_index", "alias" : "aliase_name" } },
    { "add" : { "index" : "after_index", "alias" : "aliase_name" } }
  ]
}
```
