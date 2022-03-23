build {
  sources = ["source.vmware-iso.ubuntu-server"]

  provisioner "file" {
    sources = var.vm.provision.files
    destination = "/tmp/"
  }

  provisioner "shell" {
    execute_command = "echo '${var.vm.auth.password}' | {{.Vars}} sudo -E -S /bin/bash -eux '{{.Path}}'"
    environment_vars = concat([
      "USERNAME=${var.vm.auth.username}",
      "IP=${var.vm.network.ip}"
    ], var.vm.provision.env)
    scripts = var.vm.provision.scripts
    expect_disconnect = true
  }
}
