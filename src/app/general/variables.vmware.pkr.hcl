// Hypervisor
hypervisor = {
  host        = lookup(config.hypervisor.password)
  port        = 22
  username    = "root"
  password    = lookup(config.hypervisor.password)
  type        = "esx5"
  datastore   = lookup(config.hypervisor.datastore, "datastore1")
  insecure    = true
  provision   = {
    cleanup     = [
      "./scripts/cleanup/00-cleanup.sh"
    ]
  }
}
