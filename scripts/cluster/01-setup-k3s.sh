#!/bin/bash

systemctl enable k3s.service && \
k3s kubectl get nodes