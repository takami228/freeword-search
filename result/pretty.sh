#!/bin/bash

for file in *.json;
do 
  echo $file
  cat $file | jq . > ../pretty/$file
done