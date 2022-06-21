#!/usr/bin/env bash

entitlementData=$(curl -s GET https://api.keygen.sh`echo $(cat ./out/license.json | jq -r .enc | base64 --decode | jq -r .data.relationships.entitlements.links.related)` \
  -H 'Accept: application/vnd.api+json' \
  -H "Authorization: Bearer `echo $(cat ./out/secret.json | jq -r .KEYGEN_API_TOKEN)`")

for entitlementItem in $(echo "${entitlementData}" | jq -r '.data[] | @base64');do
    _jq(){
        echo ${entitlementItem} | base64 --decode | jq -r ${1}
    }
    if [ $(_jq '.attributes.code') = "SSL" ]; then
      export CERT_PRIVATE_KEY=$(_jq '.attributes.metadata.privateKey')
    fi
done