.PHONY: install
install: init-plugins pre-install install--agh-db install--agh-k3s post-install

.PHONY: init-plugins
init-plugins:
	packer init src/plugins

.PHONY: pre-install
pre-install:
	packer build -force -on-error=ask \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/pre-process | tee logs/pre-install.log

.PHONY: post-install
post-install:
	packer build -force -on-error=ask \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/post-process | tee logs/post-install.log

.PHONY: install--agh-db
install--agh-db:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/templates/ubuntu/20 | tee logs/install.agh-db.log

.PHONY: install--agh-k3s
install--agh-k3s:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/templates/ubuntu/20 | tee logs/install.agh-k3s.log
