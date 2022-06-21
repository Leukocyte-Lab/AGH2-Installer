#!/bin/bash


echo -ne "\033[34mPlease enter Account ID: \033[0m"
read account_id
echo -ne "\033[34mPlease enter Token: \033[0m"
read token

echo -ne "\033[34mPlease enter project name: \033[0m"
read PROJECT_NAME

echo -ne "\033[34mPlease enter image user: \033[0m"
read IMAGE_USER

echo -ne "\033[34mPlease enter image password: \033[0m"
read IMAGE_PASSWORD

VALID_EXPIRY=false
until [ "$VALID_EXPIRY" = "true" ]; do
    echo -ne "\033[34mPlease enter expripry date (YYYY-mm-dd): \033[0m"
    read EXPIRY_DATE
    date -d $EXPIRY_DATE > /dev/null 2>&1
    if [ $? -eq 0 ]; 
    then
        VALID_EXPIRY="true"
    else
        echo -ne "\033[31mInvalid date\n\033[0m"
    fi
done

until [ "$POLICY_ID" != "" ]; do
    echo -ne "\033[34m \nDemo => 1 \nDev => 2 \nPlease choice policy code: \033[0m"
    read POLICY_CODE
    case $POLICY_CODE in
        "1") POLICY_ID="23b6abbf-ab11-430d-a5bf-9283961d5ee9"
            ;;
        "2") POLICY_ID="5fba01c7-2fa5-4c9e-ad53-1e9e121f5554"
            ;;
        *) echo -ne "\033[31mInvalid policy code\n\033[0m"
        esac
done

listEntitlement=`curl -s https://api.keygen.sh/v1/accounts/$account_id/entitlements?limit=100 -g \
  -H 'Accept: application/vnd.api+json' \
  -H "Authorization: Bearer $token"`
listEntitlementID=`echo $listEntitlement | jq -r '.data[] | .id'`
entitlementIDLen=0
idArray=(`echo $listEntitlementID | tr ' ' ' '`)
entitlementStr=""
for entitlementID in "${idArray[@]}"; do
    entitlementStr="$entitlementStr \n `echo $listEntitlement | jq -r .data[$entitlementIDLen].attributes.name` =>  $entitlementIDLen"
    let entitlementIDLen+=1
done
CHECK_ENTITLEMENTS=false
declare -a ENTITLEMENTS_ARR
until [ "$CHECK_ENTITLEMENTS" = "true" ]; do
    echo -ne "\033[34m $entitlementStr \nPlease choice entitlements code(type ok, when complet choice): \033[0m"
    read ENTITLEMENTS_CODE
    ENTITLEMENTS_ID=${idArray[ENTITLEMENTS_CODE]}
    if [ $ENTITLEMENTS_CODE == "ok" ];then
        break
    fi
    re='^[0-9]+$'
    if [[ $ENTITLEMENTS_ID != "" && $ENTITLEMENTS_CODE =~ $re ]];
    then
        ENTITLEMENTS_ARR[$ENTITLEMENTS_CODE]=$ENTITLEMENTS_ID
    else
        echo -ne "\033[31mInvalid entitlements code\n\033[0m"
    fi
done

read MINIO_ROOT_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read DB_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read MINIO_CORE_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read MINIO_CAPT_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read JWT_SECRET <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read VM_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read VM_PASSWORD_ENCRYPTED <<< $(openssl passwd -6 -salt 4096 $VM_PASSWORD)

echo="MINIO_ROOT_PASSWORD="$MINIO_ROOT_PASSWORD
echo="DB_PASSWORD="$DB_PASSWORD
echo="MINIO_CORE_PASSWORD="$MINIO_CORE_PASSWORD
echo="MINIO_CAPT_PASSWORD="$MINIO_CAPT_PASSWORD
echo="JWT_SECRET="$JWT_SECRET
echo="VM_PASSWORD="$VM_PASSWORD
echo="VM_PASSWORD_ENCRYPTED="$VM_PASSWORD_ENCRYPTED

METADATA_SECRET=`echo $( base64 <<< cat <<EOF
{
    "MINIO_ROOT_PASSWORD": "$MINIO_ROOT_PASSWORD",
    "DB_PASSWORD": "$DB_PASSWORD",
    "MINIO_CORE_PASSWORD": "$MINIO_CORE_PASSWORD",
    "MINIO_CAPT_PASSWORD": "$MINIO_CAPT_PASSWORD",
    "JWT_SECRET": "$JWT_SECRET",
    "VM_PASSWORD": "$VM_PASSWORD",
    "VM_PASSWORD_ENCRYPTED": "$VM_PASSWORD_ENCRYPTED",
    "IMAGE_USER": "${IMAGE_USER}",
    "IMAGE_PASSWORD": "${IMAGE_PASSWORD}",
    "KEYGEN_API_TOKEN": "${token}",
    "KEYGEN_ACCOUNT_ID": "${account_id}"
}
EOF
) | tr -d ' '`

CREATE_LICENSE_REQUEST_BODY=$(cat << EOF
{
    "data": {
        "type": "licenses",
        "attributes": {
            "name": "$PROJECT_NAME",
            "expiry": "$EXPIRY_DATE",
            "metadata": {
            "releaseChannelUrl": "https://leukocyte-lab.github.io/release/$PROJECT_NAME/version.yaml",
            "updaterRegistryUrl": "registry.lkc-lab.com/leukocyte-lab/argushack2/worker-init",
            "secret": "$METADATA_SECRET"
            }
        },
        "relationships": {
            "policy": {
                "data": { "type": "policies", "id": "$POLICY_ID" }
            }
        }
    }
}
EOF
) ;


LICENSE_INFO=$( curl -s -X POST https://api.keygen.sh/v1/accounts/$account_id/licenses \
  -H 'Content-Type: application/vnd.api+json' \
  -H 'Accept: application/vnd.api+json' \
  -H "Authorization: Bearer $token" \
  -d "$CREATE_LICENSE_REQUEST_BODY" )

LICENSE_ID=$( echo $LICENSE_INFO | jq -r .data.id )
if [ "$LICENSE_ID" = null ]; then
  echo -ne "\033[31mOpps Something was wrong, when create license\n\033[0m"
  exit 1
fi

if [[ "${#ENTITLEMENTS_ARR[@]}" = 0 ]]; then
    echo -ne "\033[33mOK\n\033[0m"
    exit 0
fi
ENTITLEMENTS_DATA=""
COUNT=0
for ENTITLEMENTS in "${ENTITLEMENTS_ARR[@]}"; do
    ENTITLEMENTS_DATA=$(cat << EOF
$ENTITLEMENTS_DATA{
    "type": "entitlements",
    "id": "$ENTITLEMENTS"
}
EOF
)
    let COUNT+=1
    if [[ "$COUNT" != ${#ENTITLEMENTS_ARR[@]} ]]
    then
        ENTITLEMENTS_DATA=$ENTITLEMENTS_DATA","
    fi
done

ATTACH_ENTITLEMENT_REQUESR_BODY=$(cat << EOF
{"data": [$ENTITLEMENTS_DATA]}
EOF
)

STATE_CODE="0"
STATE_CODE=$( curl -o /dev/null -w "%{http_code}" -s -X POST https://api.keygen.sh/v1/accounts/$account_id/licenses/$LICENSE_ID/entitlements \
-H 'Content-Type: application/vnd.api+json' \
-H 'Accept: application/vnd.api+json' \
-H "Authorization: Bearer $token" \
-d "$ATTACH_ENTITLEMENT_REQUESR_BODY" )
if [ "$STATE_CODE" != "200" ]; then
    echo -ne "\033[31mOpps Something was wrong, when attach entitlements\n\033[0m"
    exit 1
fi
echo -ne "\033[33mOK\n\033[0m"