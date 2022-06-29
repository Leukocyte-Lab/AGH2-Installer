#!/usr/bin/env bash

# Verify the license key's signature
openssl pkeyutl \
  -verify \
  -sigfile ./out/signature.bin \
  -in ./out/license.bin \
  -rawin \
  -pubin \
  -keyform DER \
  -inkey ./pub.key

if [ $? -eq 0 ]; then
  dec_key=$(cat ./out/license.json | jq -r .enc | tr '_-' '/+' | base64 --decode | jq -r .data.attributes.key)

  echo ""
  echo -e "\033[32mLicense key is cryptographically valid!\033[0m"
  echo ""
  echo ""
  echo -e "\033[34mPlease keep the License Key,\033[0m"
  echo -e "\033[34mThis key will use to activate your \033[31mArgusHack\033[34m product later.\033[0m"
  echo ""
  echo -e "\033[31m========================================\033[0m"
  echo -e "\033[31mArgusHack License Key\033[0m"
  echo -e "\033[31m----------------------------------------\033[0m"
  echo -e "\033[37m$dec_key\033[0m"
  echo -e "\033[31m========================================\033[0m"
  echo ""
  echo -e "\033[34mInject secrets...\033[0m"

  cat ./out/license.json | jq -r .enc | base64 --decode | jq -r .data.attributes.metadata.secret | base64 --decode > ./out/secret.json

  echo -e "\033[34mDONE\033[0m"

  exit 0
else
  echo -e "\033[31mLicense key is cryptographically invalid!\033[0m"
  echo -e "  => \033[34mEnsure your key is valid\033[0m"

  exit 1
fi
