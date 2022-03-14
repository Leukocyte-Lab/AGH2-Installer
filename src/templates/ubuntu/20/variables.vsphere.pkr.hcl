// vSphere Credentials
variable "vc--endpoint" {
  type        = string
  description = "The FQDN or IP address of the vCenter Server instance."
  default     = "vsphere.local"
}

variable "vc--username" {
  type        = string
  description = "The username to login to the vCenter Server instance."
  default     = "administrator@vsphere.local"
  sensitive   = true
}

variable "vc--password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

variable "vc--insecure_connection" {
  type        = bool
  description = "Do not validate vCenter Server TLS certificate."
  default     = true
}

// VM Settings
variable "vc--datacenter" {
  type        = string
  description = "(Optional) The name of the target vSphere datacenter. If not specified, the first datacenter found is used."
  default     = null
}

variable "vc--host" {
  type        = string
  description = "(Ignore when `vc--cluster`) The name of the target vSphere cluster. If not specified, the first cluster found is used."
  default     = null
}

variable "vc--cluster" {
  type        = string
  description = "(Ignore when `vc--host`) The name of the target vSphere cluster. If not specified, the first cluster found is used."
  default     = null
}

variable "vc--datastore" {
  type        = string
  description = "(Optional) The name of the target vSphere datastore. If not specified, the first datastore found is used."
  default     = null
}

variable "vc--network" {
  type        = string
  description = "(Optional) The name of the target vSphere network segment. If not specified, the first network segment found is used."
  default     = null
}
