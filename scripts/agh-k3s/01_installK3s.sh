#!/bin/bash

myIP=10.13.2.23
k3s_token=DjtQjdU70fYD

serverMsg="--tls-san=$myIP --node-label=purpose=worker --kube-apiserver-arg=feature-gates=TTLAfterFinished=true"
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.22.5+k3s1 INSTALL_K3S_SKIP_START=true K3S_TOKEN='$k3s_token' \
sh -s - server $serverMsg

sudo systemctl start k3s.service

sudo systemctl enable k3s.service
