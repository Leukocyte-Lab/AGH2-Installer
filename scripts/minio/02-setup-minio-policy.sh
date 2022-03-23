#!/bin/bash

wget -o-  https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc

./mc alias set agh-minio http://localhost:9000 $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD

./mc admin policy remove agh-minio/ readonly
./mc admin policy add agh-minio/ readonly /tmp/IAMpolicy.json

./mc admin user add agh-minio/ $MINIO_CAPT_USER $MINIO_CAPT_PASSWORD
./mc admin user add agh-minio/ $MINIO_CORE_USER $MINIO_CORE_PASSWORD

./mc admin policy set agh-minio/ readwrite user=$MINIO_CAPT_USER
./mc admin policy set agh-minio/ readonly user=$MINIO_CORE_USER