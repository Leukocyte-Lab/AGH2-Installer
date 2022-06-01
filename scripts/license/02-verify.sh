#!/usr/bin/env bash

# echo -ne "\033[34mPlease enter Keygen verify key (ED25519): \033[0m"
# read KEYGEN_PUBLIC_KEY

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

  echo -e "\033[32mLicense key is cryptographically valid!\033[0m"
  echo -e "  => \033[34m$dec_key\033[0m"

  exit 0
else
  echo -e "\033[31mLicense key is cryptographically invalid!\033[0m"
  echo -e "  => \033[34mEnsure your key is valid\033[0m"

  exit 1
fi
