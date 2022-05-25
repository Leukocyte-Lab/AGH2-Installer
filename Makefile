.PHONY: install
install: init-plugins cleanup pre-install install-vm sleep setup sleep seeding sleep check post-install

.PHONY: install-vm
install-vm: install--agh-db boot--agh-db install--agh-k3s boot--agh-k3s

.PHONY: setup
install-vm: setup--agh-db setup--agh-k3s

.PHONY: seeding
install-vm: seeding--agh-db seeding--agh-k3s

.PHONY: check
install-vm: check--agh-db check--agh-k3s

.PHONY: init-plugins
init-plugins:
	packer init src/plugins

.PHONY: cleanup
cleanup:
	packer build -force -on-error=ask \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/cleanup | tee logs/cleanup.log

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

.PHONY: setup--agh-db
setup--agh-db:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
		src/setup | tee logs/setup.agh-db.log

.PHONY: seeding--agh-db
seeding--agh-db:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
		src/seeding | tee logs/seeding-agh-db.log

.PHONY: check--agh-db
check--agh-db:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
		src/check | tee logs/check.agh-db.log

.PHONY: boot--agh-db
boot--agh-db: sleep
	packer build -force -on-error=ask \
		-var-file=src/app/agh-db/variables.agh-db.pkrvars.hcl \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/boot | tee logs/boot.agh-db.log

.PHONY: install--agh-k3s
install--agh-k3s:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/templates/ubuntu/20 | tee logs/install.agh-k3s.log

.PHONY: setup--agh-k3s
setup--agh-k3s:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		src/setup | tee logs/setup.agh-k3s.log

.PHONY: seeding--agh-k3s
seeding--agh-k3s:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		src/seeding | tee logs/seeding-agh-k3s.log

.PHONY: check--agh-k3s
check--agh-k3s:
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		src/check | tee logs/check.agh-k3s.log

.PHONY: boot--agh-k3s
boot--agh-k3s: sleep
	packer build -force -on-error=ask \
		-var-file=src/app/agh-k3s/variables.agh-k3s.pkrvars.hcl \
		-var-file=src/app/general/variables.vmware.pkrvars.hcl \
		src/boot | tee logs/boot.agh-k3s.log

.PHONY: sleep
sleep:
	sleep 15
