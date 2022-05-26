#!/bin/bash

CHECK=false
# wait for gorm auto migrate 
until [ "$CHECK" = "true" ]; do
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM attack_groups;' -d captain-db && \
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM attack_mitigations;' -d captain-db && \
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM attack_patterns;' -d captain-db && \
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM attack_softwares;' -d captain-db && \
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM pattern_childrens;' -d captain-db && \
  runuser -u postgres -- psql -c '\x' -c 'SELECT * FROM pattern_tactics;' -d captain-db && \
  CHECK=true
  sleep 10
done

runuser -u postgres -- psql captain-db < /tmp/attack.sql
runuser -u postgres -- psql attack-db < /tmp/ATTACK-mitre_groups.sql
runuser -u postgres -- psql attack-db < /tmp/ATTACK-os.sql
runuser -u postgres -- psql attack-db < /tmp/ATTACK-mitre_techniques.sql
