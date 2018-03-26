
# Elasticsearch Tutorials

---

PUT /library/doc/1
{
  "title": "Norwegian Wood",
  "name": {
    "first" : "Haruki",
    "last" : "Murakami"
  },
  "publish_date": "1987-09-04T00:00:00+0900",
  "price": 19.95
}

GET /library/doc/1

POST /library/doc/
{
  "title": "Kafka on the Shore",
  "name": {
    "first" : "Haruki",
    "last" : "Murakami"
  },
  "publish_date": "2002-09-12T00:00:00+0900",
  "price": 19.95
}

GET /library/doc/AWJg4WN5-PeDXcfPo_13

PUT /library/doc/1
{
  "title": "Norwegian Wood",
  "name": {
    "first" : "Haruki",
    "last" : "Murakami"
  },
  "publish_date": "1987-09-04T00:00:00+0900",
  "price": 29.95
}

GET /library/doc/1

POST /library/doc/1/_update
{
  "doc": {
    "price": 10
  }
}

POST /library/doc/1/_update
{
  "doc": {
    "price_jpy": 1800
  }
}

DELETE /library/doc/1

DELETE /library

GET /library/doc/1

---

# Search / Query

PUT /library
{
  "settings": {
    "index.number_of_shards": 1,
    "index.number_of_replicas": 0
  }
}

POST /library/doc/_bulk
{"index": {"_id": 1}}
{"title": "The quick brown fox", "price": 5, "colors": ["red", "green", "blue"]}
{"index": {"_id": 2}}
{"title": "The quick brown fox jumps over the lazy dog", "price": 15, "colors": ["blue", "yellow"]}
{"index": {"_id": 3}}
{"title": "The quick brown fox jumps over the quick dog", "price": 5, "colors": ["red", "blue"]}
{"index": {"_id": 4}}
{"title": "Brown fox and brown dog", "price": 2, "colors": ["black", "yellow", "red", "blue"]}
{"index": {"_id": 5}}
{"title": "Lazy dog", "price": 9, "colors": ["red", "blue", "green"]}

GET /library/doc/_search

GET /library/doc/_search
{
  "query": {
    "match":{
      "title":"fox" 
    }
  }
}

GET /library/doc/_search?explain=true
{
  "query": {
    "match":{
      "title":"quick" 
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "match":{
      "title":"quick dog" 
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "match_phrase":{
      "title":"quick dog" 
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "must":[
        {
          "match": {
            "title" : "quick"
          }
        },
        {
          "match_phrase":{
            "title":"quick dog" 
          }
        }
      ]
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "must_not":[
        {
          "match": {
            "title" : "quick"
          }
        },
        {
          "match_phrase":{
            "title":"Lazy dog" 
          }
        }
      ]
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "should":[
        {
          "match_phrase": {
            "title" : "quick dog"
          }
        },
        {
          "match_phrase":{
            "title":"lazy dog" 
          }
        }
      ]
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "should":[
        {
          "match_phrase": {
            "title" : {
              "query": "quick dog",
              "boost": 5
            }
          }
        },
        {
          "match_phrase":{
            "title":"lazy dog" 
          }
        }
      ]
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "should":[
        {
          "match_phrase": {
            "title" : "quick dog"
          }
        },
        {
          "match_phrase":{
            "title":"lazy dog" 
          }
        }
      ]
    }
  },
  "highlight": {
    "fields": {
      "title": {}
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "filter": {
        "range": {
          "price": {
            "gte": 5,
            "lte": 10
          }
        }
      }
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "bool": {
      "must":[
        {
          "match_phrase": {
            "title" : "lazy dog"
          }
        }],
      "filter": {
        "range": {
          "price": {
            "gte": 5
          }
        }
      }
    }
  }
}

# Mapping

GET /library/_mapping

PUT /library/doc/_mapping
{
  "doc": {
    "properties": {
      "my_new_field": {
        "type" : "text"
      }
    }
  }
}

GET /library/_mapping

PUT /library/doc/_mapping
{
  "doc": {
    "properties": {
      "english_field": {
        "type" : "text",
        "analyzer": "english"
      }
    }
  }
}

GET /library/_mapping

PUT /library/doc/_mapping
{
  "doc": {
    "properties": {
      "english_field": {
        "type" : "double"
      }
    }
  }
}

GET /library/doc/_search
{
  "query": {
    "match":{
      "english_field":"fox" 
    }
  }
}

POST /log/transactions
{
  "id" : 234571
}

POST /log/transactions
{
  "id" : 1392.223
}

GET /log/transactions/_search
{
 "query": {
   "bool": {
     "filter": {
       "range": {
         "id": {
           "gt": 1392
         }
       }
     }
   }
  }
 }
 
 GET /log/_mapping
 
# Analyizer
 
GET /library/_analyze
 {
   "analyzer": "standard",
   "text": "Brown fox brown dog"
 }
 
 
GET /library/_analyze
 {
   "tokenizer": "standard",
   "text": "Brown fox brown dog"
 }
 
 GET /library/_analyze
 {
   "explain": true, 
   "tokenizer": "standard",
   "filter": ["lowercase"],
   "text": "Brown fox brown dog"
 }
 
GET /library/_analyze
 {
   "tokenizer": "standard",
   "filter": ["lowercase", "unique"],
   "text": "Brown fox brown dog"
 }
 
GET /library/_analyze
{
   "tokenizer": "standard",
   "filter": ["lowercase"],
   "text": "The quick.brown_FOx Jumped! $19.95 @ 3.0"
}

GET /library/_analyze
{
   "tokenizer": "letter",
   "filter": ["lowercase"],
   "text": "The quick.brown_FOx Jumped! $19.95 @ 3.0"
}


GET /library/_analyze
{
   "tokenizer": "standard",
   "text": "記者が汽車で帰社した"
}

GET /library/_analyze
{
   "tokenizer": "kuromoji_tokenizer",
   "filter": ["kuromoji_baseform"],
   "text": "記者が汽車で帰社した"
}

# Aggregation

GET /library/_search
{
  "size": 0,
  "aggs": {
    "popular-colors": {
      "terms": {
        "field" : "colors.keyword"
      }
    }
  }
}

GET /library/_search
{
  "query": {
    "match": {
      "title": "dog"
    }
  },
  "aggs": {
    "popular-colors": {
      "terms": {
        "field" : "colors.keyword"
      }
    }
  }
}

GET /library/_search
{
  "size": 0,
  "aggs": {
    "price-statistics": {
      "stats": {
        "field" : "price"
      }
    },
    "popular-colors": {
      "terms": {
        "field" : "colors.keyword"
      },
      "aggs": {
        "ave-price-per-color":{
          "avg": {
            "field": "price"
          }
        }
      }
    }
  }
}
