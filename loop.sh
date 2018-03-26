#!/bin/bash

URL='xxx'

while true
do 
  RESULT_JSON_NAME=result_`date "+%Y%m%d-%H%M%S.%3N"`.json
  curl -Ss -o result/$RESULT_JSON_NAME -XGET $URL -d @json/query.json
done