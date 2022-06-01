#!/usr/bin/env bash

mkdir -p ./out

cat ./out/license.lic | sed -n '/BEGIN/,/END/ { //!p; }' | tr '\n' ' ' | sed 's/ //g' | base64 --decode > ./out/license.json && \
echo "key/license/`cat ./out/license.json | jq -r .enc`.`cat ./out/license.json | jq -r .sig`" > ./out/license.key && \
cat ./out/license.json | jq -r .sig | base64 --decode > ./out/signature.bin && \
echo -ne "license/" > ./out/license.bin && \
cat ./out/license.json | jq -r .enc | tr '_-\n' '/+ ' | sed 's/ //g' >> ./out/license.bin
