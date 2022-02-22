curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=$K3S_VERSION INSTALL_K3S_SKIP_START=true K3S_TOKEN=$K3S_CLUSTER_TOKEN \
  sh -s - server \
  --tls-san=$IP \
  --node-label=purpose=worker \
  --kube-apiserver-arg=feature-gates=TTLAfterFinished=true