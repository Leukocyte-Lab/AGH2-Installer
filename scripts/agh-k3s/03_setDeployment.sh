#!/bin/bash

dbIP=10.13.2.24

targetFile=deployment.yaml

jwtSecret=pmNMto9Yw3zp
keygen_apiToken=activ-069c08aeb9e0a6efd4131dbe6db10feev3
keygen_accountID=cecdf76b-c357-45de-b422-d33467c89808
db_username=agh
db_password=h7MzJyA8ULai
minio_core_name=core-minio-user
minio_core_password=ac8FKN2EuO7M
minio_capt_name=capt-minio-user
minio_capt_password=N9S3RsP0gaCr
imageCredential_username=robot\$leukocyte-lab+deploy-exercise
imageCredential_password=aMiHnCiSL0DdwclgPRfKntXrpVN7JHdv

hostArr=("captain" "core" "exploitmgr" "template")
dbName=("capt-db" "core-db" "expmgr-db" "template-db")
# 用陣列迴圈產deployment.yaml
for key in 0 1 2 3; do 
    # 把當前當元素濾掉剩下captain的字串
    result=$(echo ${hostArr[$key]} | grep "captain")
    # 判斷是否為captain
    if [[ "$result" != "" ]];then
        # 因為captain是第一個所以用覆蓋的寫入方式
        cat << EOF > $targetFile
${hostArr[$key]}:
    jwtSecret: \"$jwtSecret\" # \`jwt-secret\` is required, plz enter random string no less then 10 letters
    keygen:       # \`apiToken\` & \`accountID\` is required, plz contact sales to get tokens
    apiToken: $keygen_apiToken
    accountID: $keygen_accountID
    db:
    name: ${dbName[$key]}
    username: $db_username
    password: $db_password
    ip: $dbIP
    port: 5432
    
EOF
        
    else
        cat << EOF >> $targetFile
${hostArr[$key]}:
  db:
    # Replace the password & DB ip & port
    name: ${dbName[$key]}
    username: $db_username
    password: $db_password
    ip: $dbIP
    port: 5432

EOF
    fi
done
cat << EOF >> $targetFile
minio:
  url: \"$dbIP:9000\"
  core:
    user: \"$minio_core_name\"
    password: \"$minio_core_password\"
  capt:
    user: \"$minio_capt_name\"
    password: \"$minio_capt_password\"

imageCredential:
  # Fill the username & password for image pulling
  registry: registry.lkc-lab.com
  username: $imageCredential_username
  password: $imageCredential_password
EOF

sudo helm repo add lkclab https://charts.lkc-lab.com/