# freeword-search

This repository is for docker-compose including Elasticsearch and Kibana. The version is same for Amazon ElasticSearch Service, 5.5.2.

To run in local environment, run docker-compose commands.

```sh
# Docker Build & Up
docker-compose build
docker-compose up -d

# Check Service Statsu & Plugins
curl -v http://localhost:9200
curl -v http://localhost:9200/_nodes/plugins?pretty
```
