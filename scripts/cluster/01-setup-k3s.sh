#!/bin/bash

systemctl enable k3s.service && \
k3s kubectl get nodes

echo "Waiting for k3s to be ready"
sleep 30
