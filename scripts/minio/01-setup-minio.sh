#!/bin/bash

cat << EOF > /etc/default/minio
# Volume to be used for MinIO server.
MINIO_VOLUMES="/mnt/data"
# Use if you want to run MinIO on a custom port.
MINIO_OPTS="--address :9000 --console-address :9001"
# Root user for the server.
MINIO_ROOT_USER=$MINIO_ROOT_USER
# Root secret for the server.
MINIO_ROOT_PASSWORD=$MINIO_ROOT_PASSWORD
EOF

# Create minio-user
useradd minio-user
# Create Mount Point
mkdir /mnt/data
# Grant Permission
chown -R minio-user /mnt/data && chmod u+rxw /mnt/data
# Start Service
systemctl start minio.service
# Enable Service
systemctl enable minio.service
