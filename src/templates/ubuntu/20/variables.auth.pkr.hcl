// Communicator Settings and Credentials
variable "auth--username" {
  type        = string
  description = "The username to login to the guest operating system. (e.g. rainpole)"
  sensitive   = true
}

variable "auth--password" {
  type        = string
  description = "The password to login to the guest operating system."
  sensitive   = true
}

variable "auth--ssh_key" {
  type        = string
  description = "The public key to login to the guest operating system."
  sensitive   = true
  default     = ""
}

variable "auth--ssh_port" {
  type        = string
  description = "The port for the ssh server."
}

variable "auth--ssh_timeout" {
  type        = string
  description = "The timeout for the ssh connection."
}
