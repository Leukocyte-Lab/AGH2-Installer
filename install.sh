#!/usr/bin/env bash

echo -e "\033[31m=====================\033[0m"
echo -e "\033[31m ArgusHack Installer \033[0m"
echo -e "\033[31m=====================\033[0m"

echo "Check Networking..."
./scripts/general/00-check-ip.sh

echo "Installing ArgusHack Installer dependencies..."
sudo apt update && \
sudo apt install -y openssh-client ca-certificates openssl build-essential unzip lsb-release jq

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && \
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

sudo apt update && \
sudo apt install -y packer

license_handler() {
  echo -e "\033[34mPut your license file to \033[37m./out/license.lic\033[0m"
  echo -e "\033[34mThen press [ENTER] to continue...\033[0m"
  while [ true ] ; do
    read -t 3 -n 1
    if [ $? = 0 ] && [ -f "./out/license.lic" ] ; then
      break;
    fi
  done
}

echo "Check License..."
license_handler && \
make license--verify

echo "Load ArgusHack Installer..."
source ./scripts/env/00-inject-env.sh

echo "Running ArgusHack Installer..."
make install
