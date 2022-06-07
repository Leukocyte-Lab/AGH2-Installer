#!/bin/bash

read_env() {
  secrets=`cat ./out/$1.json | jq -c '. | to_entries'`;

  for secret in $(echo "${secrets}" | jq -r '.[] | @base64'); do
    _jq() {
      echo ${secret} | base64 --decode | jq -r ${1}
    }

    printenv | grep "$(_jq .key)="
  done
}
