#!/bin/sh


echo "Check Networking..."
./scripts/general/00-check-ip.sh

echo "Installing ArgusHack Installer dependencies..."
sudo apt update && \
sudo apt install -y openssh-client ca-certificates openssl build-essential unzip lsb_release

sleep 10

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
sudo apt update && sudo apt install -y packer

echo "Running ArgusHack Installer..."
make install
