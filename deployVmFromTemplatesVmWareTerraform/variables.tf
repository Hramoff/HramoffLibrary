variable "vsphere_user" {
  description = "username"
  type        = string
  default     = "administrator@vsphere.local"
}

variable "vsphere_pass" {
  description = "password"
  type        = string
  default     = "P@ssw0rd"
}

variable "vsphere_server" {
  description = "IP vsphere server"
  type        = string
  default     = "10.28.91.61"
}

variable "network" {
  description = "vsphere general network"
  type = string
  default = "VM Network"
}

variable "cluster" {
  description = "ESXI cluster"
  type = string
  default = "CLUSTER-ESXI-01"
}

variable "cpus" {
  description = "number of cpu"
  default = 1
}

variable "memory" {
  description = "a lot of memory"
  default = 2048
}




/* variable "ResPool" {
  description = "ESXI resource pool. If resource pool missing you cluster - enter cluster name"
  type = string
  default = "DevOps"
} */