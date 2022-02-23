locals {
  buildtime = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
}

source "vsphere-iso" "ubuntu-server" {

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server      = var.vc--endpoint
  username            = var.vc--username
  password            = var.vc--password
  insecure_connection = var.vc--insecure_connection

  // vSphere Settings
  datacenter = var.vc--datacenter
  host       = var.vc--host
  cluster    = var.vc--cluster
  datastore  = var.vc--datastore

  // Virtual Machine Settings
  guest_os_type        = var.vm--os_type
  vm_name              = var.vm--name
  firmware             = var.vm--firmware
  CPUs                 = var.vm--cpu_sockets
  cpu_cores            = var.vm--cpu_cores
  CPU_hot_plug         = var.vm--cpu_hot_add
  RAM                  = var.vm--mem_size
  RAM_hot_plug         = var.vm--mem_hot_add
  cdrom_type           = var.vm--cdrom_type
  disk_controller_type = var.vm--disk_controller_type

  storage {
    disk_size             = var.vm--disk_size
    disk_thin_provisioned = var.vm--disk_thin_provisioned
  }

  network_adapters {
    network      = var.vc--network
    network_card = var.vm--network_card
  }

  vm_version           = var.vm--version
  remove_cdrom         = var.vm--remove_cdrom
  tools_upgrade_policy = var.vm--tools_upgrade_policy
  notes                = "Built by HashiCorp Packer on ${local.buildtime}."

  // Removable Media Settings
  iso_checksum = "${var.vm--iso_hash}:${var.vm--iso_checksum}"
  iso_urls     = var.vm--iso_urls

  // Boot and Provisioning Settings
  http_port_min = var.vm--http_port_min
  http_port_max = var.vm--http_port_max
  http_content = {
    "/meta-data"          = file("data/meta-data")
    "/user-data"          = templatefile("data/ubuntu-server-cloud-init.yaml", {
      hostname            = var.vm--hostname
      username            = var.auth--username
      password_encrypted  = var.auth--password_encrypted
      ip                  = var.vm--ip
      gateway             = var.vm--gateway
      nameserver          = var.vm--nameserver
      language            = var.vm--language
      keyboard            = var.vm--keyboard
      timezone            = var.vm--timezone
      ssh_key             = var.auth--ssh_key
    })
  }
  boot_order = var.vm--boot_order
  boot_wait  = var.vm--boot_wait
  boot_command = [
    "<esc><esc><esc><wait>",
    "<enter><wait>",
    "linux /casper/vmlinuz quiet ",
    "autoinstall ",
    "ip=${split("/", var.vm--ip)[0]}::${var.vm--gateway}:${cidrnetmask(var.vm--ip)}:${var.vm--hostname}:: ",
    "nameserver=${var.vm--nameserver} ",
    "ds=\"nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/\" ---",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  ip_wait_timeout  = var.vm--ip_wait_timeout
  shutdown_command = "echo '${var.auth--password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = var.vm--shutdown_timeout

  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_username            = var.auth--username
  ssh_password            = var.auth--password
  ssh_port                = var.auth--ssh_port
  ssh_timeout             = var.auth--ssh_timeout
}
