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
    name        = lookup(config.vm.server, "ip-group", "VM Network")
    hostname    = "agh-server-m01"
    ip          = lookup(config.vm.server, "ip")
    gateway     = lookup(config.vm.server, "gateway")
    nameserver  = lookup(config.vm.server, "nameserver")
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
    username           = lookup(config.vm.server, "user", "agh-user")
    password           = lookup(config.vm.server, "password")
    password_encrypted = lookup(config.vm.server, "password-encrypted")
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
      join("=", ["JWT_SECRET", lookup(config.secret, "jwt-secret")]),
      join("=", ["KEYGEN_API_TOKEN", lookup(config.secret.keygen, "api-token")]),
      join("=", ["KEYGEN_ACCOUNT_ID", lookup(config.secret.keygen, "account-id")]),
      join("=", ["DB_IP", lookup(config.vm.db, "ip")]),
      join("=", ["DB_USER", lookup(config.secret.db, "user", "agh")]),
      join("=", ["DP_PASSWORD", lookup(config.secret.db, "password")]),
      join("=", ["MINIO_ROOT_USER", lookup(config.secret.minio, "root-user", "minio")]),
      join("=", ["MINIO_ROOT_PASSWORD", lookup(config.secret.minio, "root-password")]),
      join("=", ["MINIO_CORE_USER", lookup(config.secret.minio, "core-user", "core-minio-user")]),
      join("=", ["MINIO_CORE_PASSWORD", lookup(config.secret.minio, "core-password")]),
      join("=", ["MINIO_CORE_USER", lookup(config.secret.minio, "capt-user", "capt-minio-user")]),
      join("=", ["MINIO_CAPT_PASSWORD", lookup(config.secret.minio, "capt-password")]),
      join("=", ["IMAGE_CREDENTIAL_USER", lookup(config.secret.image-credential, "user")]),
      join("=", ["IMAGE_CREDENTIAL_USER", lookup(config.secret.image-credential, "password")]),
    ]
  }
}