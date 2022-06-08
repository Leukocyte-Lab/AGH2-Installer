locals {
  vm = {
    name        = "ArgusHack-Server-M01"
    hw          = {
      type        = "ubuntu-64"
      cpus        = 8
      mem         = 16384
      version     = "17"
    }
    disk        = {
      adapter     = "scsi"
      type        = "thin"
      size        = 81920
    }
    network     = {
      adapter     = "vmxnet3"
      name        = coalesce(lookup(var.config.vm.server, "ip-group", "VM Network"), "VM Network")
      hostname    = "agh-server-m01"
      ip          = lookup(var.config.vm.server, "ip", "")
      gateway     = lookup(var.config.vm.server, "gateway", "")
      nameserver  = lookup(var.config.vm.server, "nameserver", "")
    }
    instance      = {
      language      = "en_US"
      keyboard      = "us"
      timezone      = "UTC"
      remove_cdrom  = true
      upgrade_tools = true
      cdrom_type    = "sata"
      http_port     = {
        min         = 8000
        max         = 8099
      }
    }
    iso         = {
      urls        = [
        "artifacts/images/ubuntu-20.04.4-live-server-amd64.iso",
        "https://releases.ubuntu.com/focal/ubuntu-20.04.4-live-server-amd64.iso"
      ]
      hash        = "sha256"
      checksum    = "28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
    }
    auth        = {
      username           = coalesce(lookup(var.config.vm.server, "user", "agh-user"), "agh-user")
      password           = lookup(var.config.vm.server, "password", "")
      password_encrypted = lookup(var.config.vm.server, "password-encrypted", "")
      ssh_port           = 22
      ssh_timeout        = "30m"
    }
    provision     = {
      ip_wait_timeout    = "20m"
      shutdown_timeout   = "15m"
      scripts            = [
        "./scripts/general/00-check-ip.sh",
        "./scripts/general/01-setup-mirror.sh",
      ]
      setup              = [
        "./scripts/cluster/00-install-k3s.sh",
        "./scripts/cluster/01-setup-k3s.sh",
        "./scripts/cluster/02-generate-deployment.sh",
        "./scripts/cluster/03-install-helm.sh",
        "./scripts/cluster/04-install-agh.sh",
      ]
      seeding            = []
      files              = [
        "./artifacts/config/sources.list",
      ]
      env                = [
        "K3S_VERSION=v1.21.10+k3s1",
        join("=", ["JWT_SECRET", lookup(var.config.secret, "jwt-secret", "")]),
        join("=", ["KEYGEN_API_TOKEN", lookup(var.config.secret.credential.keygen, "api-token", "")]),
        join("=", ["KEYGEN_ACCOUNT_ID", lookup(var.config.secret.credential.keygen, "account-id", "")]),
        join("=", ["DB_IP", split("/", lookup(var.config.vm.db, "ip", ""))[0]]),
        join("=", ["DB_USER", coalesce(lookup(var.config.secret.db, "user", "agh"), "agh")]),
        join("=", ["DB_PASSWORD", lookup(var.config.secret.db, "password", "")]),
        join("=", ["MINIO_ROOT_USER", coalesce(lookup(var.config.secret.minio.root, "user", "minio"), "minio")]),
        join("=", ["MINIO_ROOT_PASSWORD", lookup(var.config.secret.minio.root, "password", "")]),
        join("=", ["MINIO_CORE_USER", coalesce(lookup(var.config.secret.minio.core, "user", "core-minio-user"), "core-minio-user")]),
        join("=", ["MINIO_CORE_PASSWORD", lookup(var.config.secret.minio.core, "password", "")]),
        join("=", ["MINIO_CAPTAIN_USER", coalesce(lookup(var.config.secret.minio.captain, "user", "captain-minio-user"), "captain-minio-user")]),
        join("=", ["MINIO_CAPTAIN_PASSWORD", lookup(var.config.secret.minio.captain, "password", "")]),
        join("=", ["IMAGE_CREDENTIAL_USER", lookup(var.config.secret.credential.image, "user", "")]),
        join("=", ["IMAGE_CREDENTIAL_PASSWORD", lookup(var.config.secret.credential.image, "password", "")]),
      ]
    }
  }
}
