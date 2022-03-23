source "null" "boot" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = var.hypervisor.host
  ssh_username            = var.hypervisor.username
  ssh_password            = var.hypervisor.password
  ssh_port                = 22
}

build {
  sources = ["source.null.boot"]

  provisioner "shell" {
    inline = ["vim-cmd vmsvc/getallvms | grep ${var.vm.name} | awk '{ print \"vim-cmd vmsvc/power.on \" $1 }' | sh"]
  }
}
