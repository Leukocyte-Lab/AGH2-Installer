// Guest Operating System Metadata
vm--name        = "AGH-DB"
vm--hostname    = "agh-db"
vm--ip          = "10.20.4.2/16"
vm--gateway     = "10.20.0.1"
vm--nameservers = ["10.20.0.1", "1.1.1.1"]

vm--language = "en_US"
vm--keyboard = "us"
vm--timezone = "UTC"

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

// Provisioner Settings
vm--init-scripts = []