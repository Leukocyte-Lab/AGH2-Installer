#!/bin/bash

cp /tmp/sources.list /etc/apt/sources.list
apt update

curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION \
  sh -s - server \
  --tls-san=$IP \
  --node-label=purpose=worker \
  --kube-apiserver-arg=feature-gates=TTLAfterFinished=true