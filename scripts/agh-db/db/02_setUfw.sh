sudo ufw default deny
sudo ufw allow ssh
sudo ufw allow postgres
sudo ufw allow 9000 #minIO
echo y\n | sudo ufw enable
sudo ufw status
