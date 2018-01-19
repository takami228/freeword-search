# freeword-search

Run docker-compose commands.

```sh
# Docker Build & Up
docker-compose build
docker-compose up -d

# Check Service Statsu & Plugins
curl -v http://localhost:9200
curl -v http://localhost:9200/_nodes/plugins?pretty
```
