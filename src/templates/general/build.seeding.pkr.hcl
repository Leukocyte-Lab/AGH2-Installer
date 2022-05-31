source "null" "seeding" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = "${split("/", local.vm.network.ip)[0]}"
  ssh_username            = local.vm.auth.username
  ssh_password            = local.vm.auth.password
  ssh_port                = local.vm.auth.ssh_port
}

build {
  name    = "seeding"
  sources = ["source.null.seeding"]

  provisioner "file" {
    sources = local.vm.provision.files
    destination = "/tmp/"
  }

  provisioner "shell" {
    execute_command = "echo '${local.vm.auth.password}' | {{.Vars}} sudo -E -S /bin/bash -eux '{{.Path}}'"
    environment_vars = concat([
      "USERNAME=${local.vm.auth.username}",
      "IP=${local.vm.network.ip}"
    ], local.vm.provision.env)
    scripts = local.vm.provision.seeding
    expect_disconnect = true
  }
}
