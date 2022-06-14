#!/bin/bash

filename=/tmp/script/manul/env.sh
source $filename

/tmp/script/db/00-install-postgress.sh
/tmp/script/db/01-setup-postgress.sh
/tmp/script/db/02-setup-firewall.sh
/tmp/script/db/03-setup-databases.sh

/tmp/script/minio/00-install-minio.sh
/tmp/script/minio/01-setup-minio.sh
/tmp/script/minio/02-setup-minio-policy.sh

/tmp/script/db/04-seed-databases.sh