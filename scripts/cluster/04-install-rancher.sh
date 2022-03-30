#!/bin/bash

# 加入Rrepo
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable && \
# 更新repo
helm repo update && \
# 建立namespace
kubectl create namespace cattle-system && \
# 安裝憑證管理
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.5.1/cert-manager.crds.yaml && \
helm repo add jetstack https://charts.jetstack.io && \
helm repo update && \
KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install \
cert-manager jetstack/cert-manager   --namespace cert-manager   --create-namespace   --version v1.5.1 && \
# 安裝rancher
KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install rancher rancher-stable/rancher \
--namespace cattle-system \
--set hostname=$RANCHER_DOMAIN \
--set bootstrapPassword=$RANCHER_ROOT_PASSWORD \
--version $RANCHER_VERSION

echo "Waiting for rancher to be ready"
sleep 120