source "null" "vmware-postprocess" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = var.hypervisor.host
  ssh_username            = var.hypervisor.username
  ssh_password            = var.hypervisor.password
  ssh_port                = 22
}

build {
  sources = ["source.null.vmware-postprocess"]

  provisioner "shell" {
    inline = ["esxcli system settings advanced set -o /Net/GuestIPHack -i 0"]
  }
}
