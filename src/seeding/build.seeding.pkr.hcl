source "null" "seeding" {
  // Communicator Settings and Credentials
  communicator            = "ssh"
  ssh_handshake_attempts  = 20
  ssh_host                = "${split("/", var.vm.network.ip)[0]}"
  ssh_username            = var.vm.auth.username
  ssh_password            = var.vm.auth.password
  ssh_port                = var.vm.auth.ssh_port
}

build {
  sources = ["source.null.seeding"]

  provisioner "file" {
    sources = var.vm.provision.files
    destination = "/tmp/"
  }

  provisioner "shell" {
    execute_command = "echo '${var.vm.auth.password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = concat([
      "USERNAME=${var.vm.auth.username}",
      "IP=${var.vm.network.ip}"
    ], var.vm.provision.env)
    scripts = var.vm.provision.seeding
    expect_disconnect = true
  }
}