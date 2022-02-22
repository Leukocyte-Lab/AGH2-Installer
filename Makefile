.PHONY: install
install: init-plugins install--agh-db install--agh-k3s
  
.PHONY: init-plugins
init-plugins:
  packer init plugins

.PHONY: install--agh-db
install--agh-db:
  packer build \
    -var-file=src/app/agh-db/build.agh-db.pkr.hcl \
    -var-file=src/app/agh-db/variables.agh-db.pkr.hcl \
    -var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
    src/templates/general \
    src/templates/ubuntu/20 | tee logs/install.agh-db.log

.PHONY: install--agh-k3s
install--agh-k3s:
  packer build \
    -var-file=src/app/agh-k3s/build.agh-k3s.pkr.hcl \
    -var-file=src/app/agh-k3s/variables.agh-k3s.pkr.hcl \
    -var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
    src/templates/general \
    src/templates/ubuntu/20 | tee logs/install.agh-k3s.log
