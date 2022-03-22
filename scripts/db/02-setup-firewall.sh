#!/bin/bash

ufw default deny
ufw allow ssh
ufw allow postgres
ufw allow 9000
yes | ufw enable
ufw status
