#!/bin/bash

check=false
# wait for gorm auto migrate 
until [ "$check" = "true" ]; do
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM attack_groups;' -d capt-db && \
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM attack_mitigations;' -d capt-db && \
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM attack_patterns;' -d capt-db && \
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM attack_softwares;' -d capt-db && \
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM pattern_childrens;' -d capt-db && \
    sudo -u postgres psql -c '\x' -c 'SELECT * FROM pattern_tactics;' -d capt-db && \
    check=true
    sleep 10
done
sudo -u postgres psql capt-db < attack.sql

