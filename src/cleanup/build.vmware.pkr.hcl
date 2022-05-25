source "null" "vmware-cleanup" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = var.hypervisor.host
  ssh_username            = var.hypervisor.username
  ssh_password            = var.hypervisor.password
  ssh_port                = 22
}

build {
  sources = ["source.null.vmware-cleanup"]

  provisioner "shell" {
    execute_command = "{{.Vars}} /bin/sh -eux '{{.Path}}'"
    environment_vars = concat([
      "DATASTORE=${var.hypervisor.datastore}",
    ])
    scripts = var.hypervisor.provision.cleanup
    expect_disconnect = true
  }
}
