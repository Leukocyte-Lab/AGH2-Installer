echo "listen_addresses = '*'" | tee -a /etc/postgresql/13/main/postgresql.conf && \
echo "host    all             all             all                     md5" | tee -a /etc/postgresql/13/main/pg_hba.conf && \
systemctl restart postgresql.service