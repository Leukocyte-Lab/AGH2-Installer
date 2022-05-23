#!/bin/bash

cp /tmp/sources.list /etc/apt/sources.list
apt update

add-apt-repository -y universe && \
add-apt-repository -y ppa:groonga/ppa

sleep 10

apt install -y wget lsb-release

sleep 10

wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release --codename --short).deb

sleep 30

apt install -y -V ./groonga-apt-source-latest-$(lsb_release --codename --short).deb

sleep 10

echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release --codename --short)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

sleep 10

apt update
apt install -y -V postgresql-13-pgdg-pgroonga

sleep 60
