// Hypervisor
variable "hypervisor" {
  type        = object({
    host        = string
    port        = number
    username    = string
    password    = string
    type        = string
    datastore   = string
    insecure    = bool
    provision     = object({
      cleanup        = list(string)
    })
  })
  default     = {
    host        = "esxi.local"
    port        = 22
    username    = "root"
    password    = "password"
    type        = "esx5"
    datastore   = "datastore1"
    insecure    = true
    provision   = {
      cleanup     = []
    }
  }
}
