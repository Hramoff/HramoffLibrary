variable "vsphere_user" {
  description = "username"
  type = string
  default = ""
}

variable "vsphere_pass" {
  description = "password"
  type = string
  default = ""
}

variable "vsphere_server" {
  description = "IP vSphere Server"
  type = string
  default = ""
}

variable "datacenter" {
  description = "You vSphere Datacenter"
  type = string
  default = ""
}

variable "datastore" {
  description = "Your vSpehre Datastore"
  type = string
  default = ""
}

variable "network" {
  description = "Your distributed switch network"
  type = string
  default = ""
}

variable "cluster" {
  description = "Name of your vSpehre-cluster"
  type = string
  default = ""
}

variable "resourcepool" {
  description = "Name of your Resources Pool"
  type = string
  default = ""
}

variable "dvs" {
  description = "Name of your distributed virtual switch"
  type = string
  default = ""
}

variable "stands" {
  description = "Count your workstation"
  type = number
  default = 0
}

