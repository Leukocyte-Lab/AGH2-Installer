locals {
  vm = {
    name        = "ArgusHack-DB"
    hw          = {
      type        = "ubuntu-64"
      cpus        = 4
      mem         = 8192
      version     = "17"
    }
    disk        = {
      adapter     = "scsi"
      type        = "thin"
      size        = 81920
    }
    network     = {
      adapter     = "vmxnet3"
      name        = coalesce(lookup(var.config.vm.db, "ip-group", "VM Network"), "VM Network")
      hostname    = "agh-db"
      ip          = lookup(var.config.vm.db, "ip", "")
      gateway     = lookup(var.config.vm.db, "gateway", "")
      nameserver  = lookup(var.config.vm.db, "nameserver", "")
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
      username           = coalesce(lookup(var.config.vm.db, "user", "agh-db"), "agh-db")
      password           = lookup(var.config.vm.db, "password", "")
      password_encrypted = lookup(var.config.vm.db, "password-encrypted", "")
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
        "./scripts/db/00-install-postgress.sh",
        "./scripts/db/01-setup-postgress.sh",
        "./scripts/db/02-setup-firewall.sh",
        "./scripts/db/03-setup-databases.sh",
        "./scripts/minio/00-install-minio.sh",
        "./scripts/minio/01-setup-minio.sh",
        "./scripts/minio/02-setup-minio-policy.sh",
      ]
      seeding            = [
        "./scripts/db/04-seed-databases.sh",
      ]
      check              = []
      files              = [
        "./artifacts/db/attack.sql",
        "./artifacts/db/ATTACK-mitre_groups.sql",
        "./artifacts/db/ATTACK-os.sql",
        "./artifacts/db/ATTACK-mitre_techniques.sql",
        "./artifacts/json/IAMpolicy.json",
        "./artifacts/config/sources.list",
      ]
      env                = [
        join("=", ["DB_USER", coalesce(lookup(var.config.secret.db, "user", "agh"), "agh")]),
        join("=", ["DB_PASSWORD", lookup(var.config.secret.db, "password", "")]),
        join("=", ["MINIO_ROOT_USER", coalesce(lookup(var.config.secret.minio.root, "user", "minio"), "minio")]),
        join("=", ["MINIO_ROOT_PASSWORD", lookup(var.config.secret.minio.root, "password", "")]),
        join("=", ["MINIO_CORE_USER", coalesce(lookup(var.config.secret.minio.core, "user", "core-minio-user"), "core-minio-user")]),
        join("=", ["MINIO_CORE_PASSWORD", lookup(var.config.secret.minio.core, "password", "")]),
        join("=", ["MINIO_CAPT_USER", coalesce(lookup(var.config.secret.minio.captain, "user", "captain-minio-user"), "captain-minio-user")]),
        join("=", ["MINIO_CAPT_PASSWORD", lookup(var.config.secret.minio.captain, "password", "")]),
        join("=", ["IMAGE_CREDENTIAL_USER", lookup(var.config.secret.credential.image, "user", "")]),
        join("=", ["IMAGE_CREDENTIAL_PASSWORD", lookup(var.config.secret.credential.image, "password", "")]),
      ]
    }
  }
}
