# MINIO_ROOT_PASSWORD= $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read MINIO_ROOT_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read DB_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read MINIO_CORE_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read MINIO_CAPT_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read JWT_SECRET <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read VM_PASSWORD <<< $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20)
read VM_PASSWORD_ENCRYPTED <<< $(openssl passwd -6 -salt 4096 $VM_PASSWORD)

echo "MINIO_ROOT_PASSWORD="$MINIO_ROOT_PASSWORD
echo "DB_PASSWORD="$DB_PASSWORD
echo "MINIO_CORE_PASSWORD="$MINIO_CORE_PASSWORD
echo "MINIO_CAPT_PASSWORD="$MINIO_CAPT_PASSWORD
echo "JWT_SECRET="$JWT_SECRET
echo "VM_PASSWORD="$VM_PASSWORD
echo "VM_PASSWORD_ENCRYPTED="$VM_PASSWORD_ENCRYPTED