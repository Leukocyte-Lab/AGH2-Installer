minio_root_user=minio
minio_root_password=vW6QxRtPtVzs

sudo cat << EOF > /etc/default/minio
# Volume to be used for MinIO server.
MINIO_VOLUMES="/mnt/data"
# Use if you want to run MinIO on a custom port.
MINIO_OPTS="--address :9000 --console-address :9001"
# Root user for the server.
MINIO_ROOT_USER=$minio_root_user
# Root secret for the server.
MINIO_ROOT_PASSWORD=$minio_root_password
EOF

# Create minio-user
sudo useradd minio-user
# Create Mount Point
sudo mkdir /mnt/data
# Grant Permission
sudo chown -R minio-user /mnt/data && sudo chmod u+rxw /mnt/data
# Start Service
sudo systemctl start minio.service
# Enable Service
sudo systemctl enable minio.service
