#!/bin/bash

minio_root_user=minio
minio_root_password=vW6QxRtPtVzs

minio_capt_user=capt-minio-user
minio_capt_password=N9S3RsP0gaCr
minio_core_user=core-minio-user
minio_core_password=ac8FKN2EuO7M
# 下載minio client
wget https://dl.min.io/client/mc/release/linux-amd64/mc
# 賦予權限
chmod +x mc
# 設定alias(執行minio client的設定檔)
./mc alias set myminio http://localhost:9000 $minio_root_user $minio_root_password
# 修改readonly的權限內容
./mc admin policy remove myminio/ readonly
./mc admin policy add myminio/ readonly minio/IAMpolicyReadonly.json
# 新增使用者capt-minio-user
./mc admin user add myminio/ $minio_capt_user $minio_capt_password
# 新增使用者core-minio-user
./mc admin user add myminio/ $minio_core_user $minio_core_password
# 賦予capt-minio-user權限readwrite
./mc admin policy set myminio/ readwrite user=$minio_capt_user
# 賦予core-minio-user權限readonly
./mc admin policy set myminio/ readonly user=$minio_core_user