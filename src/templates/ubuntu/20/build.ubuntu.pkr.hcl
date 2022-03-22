build {
  sources = ["source.vmware-iso.ubuntu-server"]

  provisioner "shell" {
    execute_command = "echo '${var.vm.auth.password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "USERNAME=${var.vm.auth.username}",
      "IP=${var.vm.network.ip}"
    ]
    scripts = var.vm.provision.scripts
    expect_disconnect = true
  }
}
