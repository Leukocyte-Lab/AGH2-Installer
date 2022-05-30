build {
  name    = "cleanup"
  sources = ["null.vmware-ssh"]

  provisioner "shell" {
    execute_command = "{{.Vars}} /bin/sh -eux '{{.Path}}'"
    environment_vars = concat([
      "DATASTORE=${local.hypervisor.datastore}",
    ])
    scripts = local.hypervisor.provision.cleanup
    expect_disconnect = true
  }
}
