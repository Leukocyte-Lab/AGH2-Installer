// VM
variable "vm" {
  type        = object({
    name        = string
    hw          = object({
      type        = string
      cpus        = number
      mem         = number
      version     = number
    })
    disk        = object({
      adapter     = string
      size        = number
      type        = string
    })
    network     = object({
      adapter     = string
      hostname    = string
      name        = string
      ip          = string
      netmask     = string
      gateway     = string
      nameserver  = string
    })
    instance      = object({
      language      = string
      keyboard      = string
      timezone      = string
      remove_cdrom  = bool
      upgrade_tools = bool
      cdrom_type    = string
      http_port       = object({
        min             = number
        max             = number
      })
    })
    iso         = object({
      urls        = list(string)
      hash        = string
      checksum    = string
    })
    auth        = object({
      username           = string
      password           = string
      password_encrypted = string
      ssh_port           = number
      ssh_timeout        = string
    })
    provision     = object({
      ip_wait_timeout    = string
      shutdown_timeout   = string
      scripts            = list(string)
      seeding            = list(string)
      files              = list(string)
      env                = list(string)
    })
  })
}
