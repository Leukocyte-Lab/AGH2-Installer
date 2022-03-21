#!/bin/bash

check=false
until [ "$check" = "true" ]; do
    sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml helm install agh lkclab/agh2 -f deployment.yaml --namespace agh --create-namespace && check=true
    sleep 10
done
