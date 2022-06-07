#!/usr/bin/env bash

source ./scripts/license/ff-license-handler.sh

echo -e "\033[31m=====================\033[0m"
echo -e "\033[31m ArgusHack Installer \033[0m"
echo -e "\033[31m=====================\033[0m"

echo -ne "\033[34mCheck Networking...\033[0m"
./scripts/general/00-check-ip.sh 2>&1 > /dev/null

echo -e "\033[32mDONE\033[0m"

echo -ne "\033[34mInstalling ArgusHack Installer dependencies...\033[0m"
sudo apt update && \
sudo apt install -y openssh-client ca-certificates openssl build-essential unzip lsb-release jq sshpass

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update && \
sudo apt install -y packer

echo -e "\033[32mDONE\033[0m"

echo -e "\033[34mCheck License...\033[0m"
license_handler && \
make license--verify

echo -ne "\033[34mLoad ArgusHack Installer...\033[0m"
source ./scripts/env/00-inject-env.sh secret SECRET_
echo -e "\033[32mDONE\033[0m"

echo -ne "\033[34mLoading configuration...\033[0m"
if [ ! -f "./out/config.json" ] || [ ! -f "./out/secret.json" ] ; then
  ./scripts/env/02-set-env.sh
fi
source ./scripts/env/00-inject-env.sh config
echo -e "\033[32mDONE\033[0m"

echo -e "\033[34mRunning ArgusHack Installer...\033[0m"
make install
