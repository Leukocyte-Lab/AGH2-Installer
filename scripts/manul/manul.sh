#!/bin/bash

sudo apt install sshpass

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

filename=$SCRIPTPATH/env.sh
while IFS='' read -r line || [[ -n "$line" ]]; do
    eval $line
done < $filename

sshpass -p "$AGH_DB_PASSWORD" scp -o StrictHostKeyChecking=no $SCRIPTPATH/../../artifacts/db/ATTACK-mitre_groups.sql $AGH_DB_USER@$DB_IP:/tmp/
sshpass -p "$AGH_DB_PASSWORD" scp $SCRIPTPATH/../../artifacts/db/ATTACK-mitre_techniques.sql $AGH_DB_USER@$DB_IP:/tmp/
sshpass -p "$AGH_DB_PASSWORD" scp $SCRIPTPATH/../../artifacts/db/ATTACK-os.sql $AGH_DB_USER@$DB_IP:/tmp/
sshpass -p "$AGH_DB_PASSWORD" scp $SCRIPTPATH/../../artifacts/db/attack.sql $AGH_DB_USER@$DB_IP:/tmp/

sshpass -p "$AGH_DB_PASSWORD" scp $SCRIPTPATH/../../artifacts/json/IAMpolicy.json $AGH_DB_USER@$DB_IP:/tmp/

sshpass -p "$AGH_DB_PASSWORD" scp -r $SCRIPTPATH/../../scripts/ $AGH_DB_USER@$DB_IP:/tmp/script/

sshpass -p "$AGH_DB_PASSWORD" ssh -t $AGH_DB_USER@$DB_IP "echo $AGH_DB_PASSWORD | sudo -S chmod -R +x /tmp/script/;"




sshpass -p "$AGH_MASTER_PASSWORD" scp -o StrictHostKeyChecking=no -r $SCRIPTPATH/../../scripts/ $AGH_MASTER_USER@$IP:/tmp/script/

sshpass -p "$AGH_MASTER_PASSWORD" ssh -t $AGH_MASTER_USER@$IP "echo $AGH_MASTER_PASSWORD | sudo -S chmod -R +x /tmp/script/;"

sshpass -p "$AGH_DB_PASSWORD" ssh -t $AGH_DB_USER@$DB_IP "
echo $AGH_DB_PASSWORD | sudo -S /./tmp/script/manul/db-entry.sh" & \
sshpass -p "$AGH_MASTER_PASSWORD" ssh -t $AGH_MASTER_USER@$IP "
echo $AGH_MASTER_PASSWORD | sudo -S /./tmp/script/manul/master-entry.sh"