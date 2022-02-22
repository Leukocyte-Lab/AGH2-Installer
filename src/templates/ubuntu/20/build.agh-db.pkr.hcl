build {
  sources = ["source.vsphere-iso.ubuntu-server"]

  provisioner "shell" {
    execute_command = "echo '${var.auth--password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    environment_vars = [
      "USERNAME=${var.auth--username}",
      "SSH_KEY=${var.auth--ssh_key}",
      "IP=${var.vm--ip}",
      "K3S_TOKEN=${var.app--k3s_token}",
      "K3S_CLUSTER_TOKEN=${var.app--k3s_cluster_token}"
    ]
    scripts = var.vm--init-scripts
  }
}
