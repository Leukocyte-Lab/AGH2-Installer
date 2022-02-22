// Guest Operating System Metadata
vm--language = "en_US"
vm--keyboard = "us"
vm--timezone = "UTC"
vm--name     = "AGH-K3s-Master"
vm--hostname = "agh-k3s-master"

// Virtual Machine Guest Operating System Setting
vm--os_type = "ubuntu64Guest"

// Virtual Machine Hardware Settings
vm--firmware              = "efi"
vm--cdrom_type            = "sata"
vm--cpu_sockets           = 1
vm--cpu_cores             = 8
vm--cpu_hot_add           = false
vm--mem_size              = 16384
vm--mem_hot_add           = false
vm--disk_size             = 81920
vm--disk_controller_type  = ["pvscsi"]
vm--disk_thin_provisioned = true
vm--network_card          = "vmxnet3"

// Provisioner Settings
vm--init-scripts = []