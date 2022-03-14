// Virtual Machine Settings
variable "vm--hostname" {
  type        = string
  description = "The hostname of VM."
}

variable "vm--ip" {
  type        = string
  description = "The ip of VM."
}

variable "vm--gateway" {
  type        = string
  description = "The gateway of VM."
}

variable "vm--nameserver" {
  type        = string
  description = "The nameserver of VM."
}

variable "vm--name" {
  type        = string
  description = "The name of VM."
}

variable "vm--language" {
  type        = string
  description = "The guest operating system lanugage."
  default     = "en_US"
}

variable "vm--keyboard" {
  type        = string
  description = "The guest operating system keyboard input."
  default     = "us"
}

variable "vm--timezone" {
  type        = string
  description = "The guest operating system timezone."
  default     = "UTC"
}

variable "vm--os_type" {
  type        = string
  description = "The guest operating system type, also know as guestid. (e.g. 'ubuntu64Guest')"
}

variable "vm--firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'efi-secure'. 'efi', or 'bios')"
  default     = "efi"
}

variable "vm--cdrom_type" {
  type        = string
  description = "The virtual machine CD-ROM type. (e.g. 'sata', or 'ide')"
  default     = "sata"
}

variable "vm--tools_upgrade_policy" {
  type        = bool
  description = "Upgrade VMware Tools on reboot."
  default     = true
}

variable "vm--remove_cdrom" {
  type        = bool
  description = "Remove the virtual CD-ROM(s)."
  default     = true
}

variable "vm--cpu_sockets" {
  type        = number
  description = "The number of virtual CPUs sockets. (e.g. '2')"
}

variable "vm--cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket. (e.g. '1')"
}

variable "vm--cpu_hot_add" {
  type        = bool
  description = "Enable hot add CPU."
  default     = false
}

variable "vm--mem_size" {
  type        = number
  description = "The size for the virtual memory in MB. (e.g. '2048')"
}

variable "vm--mem_hot_add" {
  type        = bool
  description = "Enable hot add memory."
  default     = false
}

variable "vm--disk_size" {
  type        = number
  description = "The size for the virtual disk in MB. (e.g. '40960')"
}

variable "vm--disk_controller_type" {
  type        = list(string)
  description = "The virtual disk controller types in sequence. (e.g. 'pvscsi')"
  default     = ["pvscsi"]
}

variable "vm--disk_thin_provisioned" {
  type        = bool
  description = "Thin provision the virtual disk."
  default     = true
}

variable "vm--network_card" {
  type        = string
  description = "The virtual network card type. (e.g. 'vmxnet3' or 'e1000e')"
  default     = "vmxnet3"
}

variable "vm--version" {
  type        = number
  description = "The vSphere virtual hardware version. (e.g. '18')"
  default     = 13
}

// Removable Media Settings
variable "vm--iso_urls" {
  type        = list(string)
  description = "The URL of the remote ISO to use"
  default     = []
}

variable "vm--iso_hash" {
  type        = string
  description = "The algorithm used for the checkcum of the ISO image. (e.g. 'sha512')"
  default     = null
}

variable "vm--iso_checksum" {
  type        = string
  description = "The checksum of the ISO image. (e.g. Result of 'shasum -a 512 iso-linux-ubuntu-server-20-04-lts.iso')"
}

// Boot Settings
variable "vm--http_port_min" {
  type        = number
  description = "The start of the HTTP port range."
}

variable "vm--http_port_max" {
  type        = number
  description = "The end of the HTTP port range."
}

variable "vm--boot_order" {
  type        = string
  description = "The boot order for virtual machines devices."
  default     = "disk,cdrom"
}

variable "vm--boot_wait" {
  type        = string
  description = "The time to wait before boot."
}


variable "vm--ip_wait_timeout" {
  type        = string
  description = "Time to wait for guest operating system IP address response."
}

variable "vm--shutdown_timeout" {
  type        = string
  description = "Time to wait for guest operating system shutdown."
}

// Provisioner Settings
variable "vm--init-scripts" {
  type        = list(string)
  description = "A list of scripts and their relative paths to transfer and execute."
  default     = []
}
