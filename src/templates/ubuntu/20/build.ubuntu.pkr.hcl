build {
  name    = "install-vm"
  sources = ["source.vmware-iso.ubuntu-server"]

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
    scripts = local.vm.provision.scripts
    expect_disconnect = true
  }
}
