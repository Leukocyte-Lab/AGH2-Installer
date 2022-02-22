apt install -y software-properties-common
add-apt-repository -y universe
add-apt-repository -y ppa:groonga/ppa

apt install -y wget lsb-release
wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb
apt install -y -V ./groonga-apt-source-latest-$(lsb_release --codename --short).deb
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release --codename --short)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt update && apt install -y -V postgresql-13-pgdg-pgroonga