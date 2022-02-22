// Guest Operating System Metadata
vm--language = "en_US"
vm--keyboard = "us"
vm--timezone = "UTC"
vm--family   = "linux"
vm--name     = "ubuntu"

// Virtual Machine Guest Operating System Setting
vm--os_type = "ubuntu64Guest"

// Virtual Machine Hardware Settings
vm--firmware              = "efi"
vm--cdrom_type            = "sata"
vm--cpu_sockets           = 1
vm--cpu_cores             = 4
vm--cpu_hot_add           = false
vm--mem_size              = 8192
vm--mem_hot_add           = false
vm--disk_size             = 128000
vm--disk_controller_type  = ["pvscsi"]
vm--disk_thin_provisioned = true
vm--network_card          = "vmxnet3"

// Boot Settings
vm--boot_order = "disk,cdrom"
vm--boot_wait  = "5s"

// Removable Media Settings
vm--iso_urls           = [
  "artifacts/images/ubuntu-20.04.3-live-server-amd64.iso",
  "https://releases.ubuntu.com/focal/ubuntu-20.04.3-live-server-amd64.iso"
]
vm--iso_checksum_type  = "sha256"
vm--iso_checksum_value = "f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"

// Provisioner Settings
scripts = []