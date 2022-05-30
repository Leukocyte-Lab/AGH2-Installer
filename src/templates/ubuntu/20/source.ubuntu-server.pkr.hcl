locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

source "vmware-iso" "ubuntu-server" {

  // Hypervisor Connection
  remote_type                       = local.hypervisor.type
  remote_host                       = local.hypervisor.host
  remote_username                   = local.hypervisor.username
  remote_password                   = local.hypervisor.password
  skip_validate_credentials         = local.hypervisor.insecure
  insecure_connection               = local.hypervisor.insecure

  // Hypervisor Provision
  vnc_disable_password              = true
  vnc_over_websocket                = true

  // Virtual Machine Settings
  remote_datastore                  = local.hypervisor.datastore
  vm_name                           = local.vm.name
  guest_os_type                     = local.vm.hw.type
  cpus                              = local.vm.hw.cpus
  memory                            = local.vm.hw.mem
  version                           = local.vm.hw.version

  // Disk Settings
  disk_adapter_type                 = local.vm.disk.adapter
  disk_type_id                      = local.vm.disk.type
  disk_size                         = local.vm.disk.size
  skip_compaction                   = local.vm.disk.type == 0 ? true : false

  // Network Settings
  network_adapter_type              = local.vm.network.adapter
  network_name                      = local.vm.network.name

  // ISO Settings
  cdrom_adapter_type                = local.vm.instance.cdrom_type

  // Removable Media Settings
  iso_checksum                      = "${local.vm.iso.hash}:${local.vm.iso.checksum}"
  iso_urls                          = local.vm.iso.urls
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
  http_port_min = local.vm.instance.http_port.min
  http_port_max = local.vm.instance.http_port.max
  http_content = {
    "/meta-data"          = file("data/meta-data")
    "/user-data"          = templatefile("data/ubuntu-server-cloud-init.yaml", {
      hostname            = local.vm.network.hostname
      username            = local.vm.auth.username
      password_encrypted  = local.vm.auth.password_encrypted
      ip                  = local.vm.network.ip
      gateway             = local.vm.network.gateway
      nameserver          = local.vm.network.nameserver
      language            = local.vm.instance.language
      keyboard            = local.vm.instance.keyboard
      timezone            = local.vm.instance.timezone
    })
  }

  boot_wait               = "2s"
  boot_command = [
    "c",
    "linux /casper/vmlinuz quiet ",
    "autoinstall ",
    "ip=${split("/", local.vm.network.ip)[0]}::${local.vm.network.gateway}:${cidrnetmask(local.vm.network.ip)}:${local.vm.network.hostname}:: ",
    "nameserver=${local.vm.network.nameserver} ",
    "ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  boot_key_interval       = "10ms"

  shutdown_command = "echo '${local.vm.auth.password}' | sudo -S -E systemctl poweroff"
  shutdown_timeout = local.vm.provision.shutdown_timeout

  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_username            = local.vm.auth.username
  ssh_password            = local.vm.auth.password
  ssh_port                = local.vm.auth.ssh_port
  ssh_timeout             = local.vm.auth.ssh_timeout
  pause_before_connecting = "3m"

  skip_export             = true
  keep_registered         = true
}
