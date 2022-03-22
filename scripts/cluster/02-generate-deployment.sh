#!/bin/bash

TARGET_FILE=/tmp/deployment.yaml

declare -a SERVICES=("captain" "core" "exploitmgr" "template")

# Clear
echo "" > $TARGET_FILE

for SERVICE in "${SERVICES[@]}"; do
  # ------------------------- #
  cat << EOF >> $TARGET_FILE
$SERVICE:
  db:
    name: $SERVICE-db
    username: $DB_USER
    password: $DB_PASSWORD
    ip: $DB_IP
    port: 5432
EOF
  # ------------------------- #

  if [[ "$SERVICE" == "captain" ]];
  then
  # ------------------------- #
    cat << EOF >> $TARGET_FILE
  jwtSecret: $JWT_SECRET
  keygen:
    apiToken: $KEYGEN_API_TOKEN
    accountID: $KEYGEN_ACCOUNT_ID
EOF
  # ------------------------- #
  fi;

done

cat << EOF >> $TARGET_FILE
minio:
  url: $DB_IP:9000
  core:
    user: $MINIO_CORE_USER
    password: $MINIO_CORE_PASSWORD
  capt:
    user: $MINIO_CAPT_USER
    password: $MINIO_CAPT_PASSWORD

imageCredential:
  registry: registry.lkc-lab.com
  username: $IMAGE_CREDENTIAL_USER
  password: $IMAGE_CREDENTIAL_PASSWORD
EOF
