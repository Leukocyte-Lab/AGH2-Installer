source "null" "vmware-ssh" {
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = local.hypervisor.host
  ssh_username            = local.hypervisor.username
  ssh_password            = local.hypervisor.password
  ssh_port                = 22
}
