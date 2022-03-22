locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

source "vmware-iso" "ubuntu-server" {

  // Hypervisor Connection
  remote_type                       = var.hypervisor.type
  remote_host                       = var.hypervisor.host
  remote_username                   = var.hypervisor.username
  remote_password                   = var.hypervisor.password
  skip_validate_credentials         = var.hypervisor.insecure
  insecure_connection               = var.hypervisor.insecure

  // Hypervisor Provision
  vnc_disable_password              = true
  vnc_over_websocket                = true

  // Virtual Machine Settings
  remote_datastore                  = var.hypervisor.datastore
  vm_name                           = var.vm.name
  guest_os_type                     = var.vm.hw.type
  cpus                              = var.vm.hw.cpus
  memory                            = var.vm.hw.mem
  version                           = var.vm.hw.version

  // Disk Settings
  disk_adapter_type                 = var.vm.disk.adapter
  disk_type_id                      = var.vm.disk.type
  disk_size                         = var.vm.disk.size
  skip_compaction                   = var.vm.disk.type == 0 ? true : false

  // Network Settings
  network_adapter_type              = var.vm.network.adapter
  network_name                      = var.vm.network.name

  // ISO Settings
  cdrom_adapter_type                = var.vm.instance.cdrom_type

  // Removable Media Settings
  iso_checksum                      = "${var.vm.iso.hash}:${var.vm.iso.checksum}"
  iso_urls                          = var.vm.iso.urls
  tools_upload_flavor               = "linux"

  // VMX
  vmx_data = {
    firmware = "efi"
    "hpet0.present" = "TRUE"
    "ich7m.present" = "TRUE"
    "smc.present" = "TRUE"
    "usb.present" = "TRUE"
    "bios.bootOrder" = "cdrom,disk"
    "ethernet0.bsdname" = "ens192"
    "ethernet0.pcislotnumber" = "192"
    "ethernet0.wakeonpcktrcv" = "TRUE"
  }

  // Boot and Provisioning Settings
  http_port_min = var.vm.instance.http_port.min
  http_port_max = var.vm.instance.http_port.max
  http_content = {
    "/meta-data"          = file("data/meta-data")
    "/user-data"          = templatefile("data/ubuntu-server-cloud-init.yaml", {
      hostname            = var.vm.network.hostname
      username            = var.vm.auth.username
      password_encrypted  = var.vm.auth.password_encrypted
      ip                  = var.vm.network.ip
      gateway             = var.vm.network.gateway
      nameserver          = var.vm.network.nameserver
      language            = var.vm.instance.language
      keyboard            = var.vm.instance.keyboard
      timezone            = var.vm.instance.timezone
    })
  }

  boot_wait               = "2s"
  boot_command = [
    "<esc><esc><esc><wait>",
    "<enter><wait>",
    "linux /casper/vmlinuz quiet ",
    "autoinstall ",
    "ip=${split("/", var.vm.network.ip)[0]}::${var.vm.network.gateway}:${cidrnetmask(var.vm.network.ip)}:${var.vm.network.hostname}:: ",
    "nameserver=${var.vm.network.nameserver} ",
    "ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]

  shutdown_command = "echo '${var.vm.auth.password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.vm.provision.shutdown_timeout

  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_username            = var.vm.auth.username
  ssh_password            = var.vm.auth.password
  ssh_port                = var.vm.auth.ssh_port
  ssh_timeout             = var.vm.auth.ssh_timeout

  skip_export             = true
  keep_registered         = true
}
