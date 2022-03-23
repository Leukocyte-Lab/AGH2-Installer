#!/bin/bash

cat /tmp/deployment.yaml

helm repo add lkclab https://charts.lkc-lab.com/ && \
helm repo update && \
KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install agh lkclab/agh2-helm -f /tmp/deployment.yaml --namespace agh --create-namespace

echo "Waiting for agh to be ready"
sleep 120
