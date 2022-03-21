echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/13/main/postgresql.conf

echo "host    all             all             all                     md5" | sudo tee -a /etc/postgresql/13/main/pg_hba.conf

sudo systemctl restart postgresql.service
