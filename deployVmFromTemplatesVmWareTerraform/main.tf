provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_pass
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "datacenter" {
  name = "Datacenter-1"
}

data "vsphere_datastore" "datastore" {
  name          = "vsanDatastore"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "ResPool" {
  name          = "CLUSTER-ESXI-01/Resources"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_vapp_container" "vapp" {
  name          = "DevOps"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = "Debian"
  datacenter_id = data.vsphere_datacenter.datacenter.id

}

resource "vsphere_virtual_machine" "balancer" {
  name             = "web-balancer"
  resource_pool_id = data.vsphere_vapp_container.vapp.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

}

resource "vsphere_virtual_machine" "node" {

  count = 3

  name             = "node ${count.index}"
  resource_pool_id = data.vsphere_vapp_container.vapp.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

}

resource "vsphere_virtual_machine" "jenkins" {
  name             = "Jenkins"
  resource_pool_id = data.vsphere_vapp_container.vapp.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

}

resource "vsphere_virtual_machine" "Zabbix" {
  name             = "Zabbix"
  resource_pool_id = data.vsphere_vapp_container.vapp.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

}

resource "vsphere_virtual_machine" "prometheus" {
  name             = "Prometheus"
  resource_pool_id = data.vsphere_vapp_container.vapp.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.cpus
  memory    = var.memory
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
  
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

}