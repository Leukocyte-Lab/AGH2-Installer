# 安裝 software-properties-common，功能為PPA (Personal Package Archive) 管理工具​
sudo apt install -y software-properties-common
sudo add-apt-repository -y universe
# 由於已安裝了 software-properties-common，因此可加入 groonga/ppa 套件庫
sudo add-apt-repository -y ppa:groonga/ppa
# 安裝顯示 OS 資訊的套件
sudo apt install -y wget lsb-release
# 下載groonga套件的deb檔
wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb
# 安裝groonga套件的deb檔
sudo apt install -y -V ./groonga-apt-source-latest-$(lsb_release --codename --short).deb
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release --codename --short)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# 完成postgresql安裝
sudo apt update && sudo apt install -y -V postgresql-13-pgdg-pgroonga
