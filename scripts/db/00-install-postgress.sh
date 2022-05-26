#!/bin/bash

add-apt-repository -y universe && \
add-apt-repository -y ppa:groonga/ppa && \
apt update && \
apt install -y wget lsb_release

wget https://packages.groonga.org/ubuntu/groonga-apt-source-latest-$(lsb_release -cs).deb

apt install -y ./groonga-apt-source-latest-$(lsb_release -cs).deb

echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

apt update && \
apt install -y postgresql-13-pgdg-pgroonga
