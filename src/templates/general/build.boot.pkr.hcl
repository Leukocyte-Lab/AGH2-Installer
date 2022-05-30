source "null" "boot" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = local.hypervisor.host
  ssh_username            = local.hypervisor.username
  ssh_password            = local.hypervisor.password
  ssh_port                = 22
}

build {
  name    = "boot"
  sources = ["source.null.boot"]

  provisioner "shell" {
    inline = ["vim-cmd vmsvc/getallvms | grep ${local.vm.name} | awk '{ print \"vim-cmd vmsvc/power.on \" $1 }' | sh"]
  }
}
