#!/bin/bash

filename=/tmp/script/manul/env.sh
source $filename

/tmp/script/cluster/00-install-k3s.sh
/tmp/script/cluster/01-setup-k3s.sh
/tmp/script/cluster/02-generate-deployment.sh
/tmp/script/cluster/03-install-helm.sh
/tmp/script/cluster/04-install-agh.sh