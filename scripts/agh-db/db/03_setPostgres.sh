# 設定允許非本機 IP 的連線
echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/13/main/postgresql.conf
# 設定允許非本機使用密碼連線​
echo "host    all             all             all                     md5" | sudo tee -a /etc/postgresql/13/main/pg_hba.conf

sudo systemctl restart postgresql.service
