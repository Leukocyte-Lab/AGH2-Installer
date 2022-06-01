.PHONY: install
install: init-plugins cleanup pre-install install-vm sleep setup sleep seeding sleep check post-install

.PHONY: license--get
license--get:
	scripts/license/00-get-license.sh

.PHONY: license--verify
license-verify:
	scripts/license/01-parse.sh && \
	scripts/license/02-verify.sh

.PHONY: install-vm
install-vm: install--agh-db boot--agh-db install--agh-k3s boot--agh-k3s

.PHONY: setup
setup: setup--agh-db setup--agh-k3s

.PHONY: seeding
seeding: seeding--agh-db seeding--agh-k3s

.PHONY: check
check: check--agh-db check--agh-k3s

.PHONY: init-plugins
init-plugins:
	packer init src/plugins

.PHONY: cleanup
cleanup:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=cleanup.* \
		src/app/general/ | tee logs/cleanup.log

.PHONY: pre-install
pre-install:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=pre-process.* \
		src/app/general | tee logs/pre-process.log

.PHONY: post-install
post-install:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=post-process.* \
		src/app/general/ | tee logs/post-process.log

.PHONY: install--agh-db
install--agh-db:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=install-vm.* \
		src/app/agh-db | tee logs/install-vm--agh-db.log

.PHONY: setup--agh-db
setup--agh-db:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=setup.* \
		src/app/agh-db | tee logs/setup--agh-db.log

.PHONY: seeding--agh-db
seeding--agh-db:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=seeding.* \
		src/app/agh-db | tee logs/seeding--agh-db.log

.PHONY: check--agh-db
check--agh-db:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=check.* \
		src/app/agh-db | tee logs/check--agh-db.log

.PHONY: boot--agh-db
boot--agh-db: sleep
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=boot.* \
		src/app/agh-db | tee logs/boot--agh-db.log

.PHONY: install--agh-k3s
install--agh-k3s:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=install-vm.* \
		src/app/agh-k3s | tee logs/install-vm--agh-k3s.log

.PHONY: setup--agh-k3s
setup--agh-k3s:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=setup.* \
		src/app/agh-k3s | tee logs/setup--agh-k3s.log

.PHONY: seeding--agh-k3s
seeding--agh-k3s:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=seeding.* \
		src/app/agh-k3s | tee logs/seeding--agh-k3s.log

.PHONY: check--agh-k3s
check--agh-k3s:
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=check.* \
		src/app/agh-k3s | tee logs/check--agh-k3s.log

.PHONY: boot--agh-k3s
boot--agh-k3s: sleep
	packer build -timestamp-ui -force \
		-on-error=ask \
		-only=boot.* \
		src/app/agh-k3s | tee logs/boot--agh-k3s.log

.PHONY: sleep
sleep:
	sleep 15
