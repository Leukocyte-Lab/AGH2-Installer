locals {
  hypervisor = {
    host        = lookup(var.config.hypervisor, "host", "")
    port        = 22
    username    = coalesce(lookup(var.config.hypervisor, "user", "root"), "root")
    password    = lookup(var.config.hypervisor, "password", "")
    type        = "esx5"
    datastore   = coalesce(lookup(var.config.hypervisor, "datastore", "datastore1"), "datastore1")
    insecure    = true
    provision   = {
      cleanup     = [
        "./scripts/cleanup/00-cleanup.sh"
      ]
    }
  }
}
