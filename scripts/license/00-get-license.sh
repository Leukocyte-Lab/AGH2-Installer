#!/usr/bin/env bash

echo -ne "\033[34mPlease enter Account ID: \033[0m"
read account_id
echo -ne "\033[34mPlease enter License ID: \033[0m"
read license_id
echo -ne "\033[34mPlease enter Token: \033[0m"
read token

curl -X GET https://api.keygen.sh/v1/accounts/`echo $account_id`/licenses/`echo $license_id`/actions/check-out \
  -H 'Accept: application/vnd.api+json' \
  -H "Authorization: Bearer `echo $token`" > out/license.lic
