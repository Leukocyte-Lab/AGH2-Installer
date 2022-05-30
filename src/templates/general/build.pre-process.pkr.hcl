build {
  name    = "pre-process"
  sources = ["null.vmware-ssh"]

  provisioner "shell" {
    inline = ["esxcli system settings advanced set -o /Net/GuestIPHack -i 1"]
  }
}
