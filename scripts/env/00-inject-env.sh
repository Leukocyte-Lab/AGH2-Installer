#!/bin/bash

secrets=`cat ./out/$1.json | jq -c '. | to_entries'`;

for secret in $(echo "${secrets}" | jq -r '.[] | @base64'); do
  _jq() {
    echo ${secret} | base64 --decode | jq -r ${1}
  }

  export "$2$(_jq .key)=$(_jq .value)"
done
