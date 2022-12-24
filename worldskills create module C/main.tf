provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_pass
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "Datacenter" {
  name = var.datacenter
}

data "vsphere_datastore" "Datastore" {
  name = var.datastore
  datacenter_id = data.vsphere_datacenter.Datacenter.id
}

data "vsphere_network" "Network" {
  name = var.network
  datacenter_id = data.vsphere_datacenter.Datacenter.id
}

data "vsphere_network" "PortGroup_Network" {
  datacenter_id = data.vsphere_datacenter.Datacenter.id
  count = var.stands
  name = "PortGroup-chemp-${format("%04d", count.index + 1)}"
  depends_on = [
    vsphere_distributed_port_group.PortGroup
  ]
}

data "vsphere_compute_cluster" "Cluster" {
  name = var.cluster
  datacenter_id = data.vsphere_datacenter.Datacenter.id
}

data "vsphere_resource_pool" "ResourcePool" {
  name = var.resourcepool
  datacenter_id = data.vsphere_datacenter.Datacenter.id  
}

data "vsphere_distributed_virtual_switch" "DVS" {
  name = var.dvs
  datacenter_id = data.vsphere_datacenter.Datacenter.id 
}

data "vsphere_virtual_machine" "Template-Debian" {
  name = "debian10"
  datacenter_id = data.vsphere_datacenter.Datacenter.id 
}

data "vsphere_virtual_machine" "Template-Router" {
  name = "route"
  datacenter_id = data.vsphere_datacenter.Datacenter.id 
}

data "vsphere_virtual_machine" "Template-Win10" {
  name = "Windows 10"
  datacenter_id = data.vsphere_datacenter.Datacenter.id 
}


#-----------------------------RESOURECES-----------------------------

resource "vsphere_distributed_port_group" "PortGroup" {
  count = var.stands
  name = "PortGroup-chemp-${format("%04d", count.index + 1)}"
  vlan_id = format("%04d", count.index + 1)
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.DVS.id
}

resource "vsphere_vapp_container" "vapp_container" {
  count = var.stands
  name = "CHEMP-STAND-${format("%04d", count.index + 1)}"
  parent_resource_pool_id = data.vsphere_resource_pool.ResourcePool.id
}

data "vsphere_vapp_container" "vApp" {
  depends_on = [vsphere_vapp_container.vapp_container, data.vsphere_network.PortGroup_Network]
  count = var.stands
  datacenter_id = data.vsphere_datacenter.Datacenter.id
  name = "CHEMP-STAND-${format("%04d", count.index + 1)}"
}

resource "vsphere_virtual_machine" "Router" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Router(NAT)"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
    network_id = data.vsphere_network.Network.id
  }
  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Router.id
  }

}

resource "vsphere_virtual_machine" "Database" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Database"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "Application_Server-1" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Application Server-1"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "Application_Server-2" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Application Server-2"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "Application_Server-3" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Application Server-3"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "You" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "DevOps"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "Web-server" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Web-server"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Router.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 20
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Debian.id
  }

}

resource "vsphere_virtual_machine" "Windows" {
  depends_on = [vsphere_vapp_container.vapp_container]
  count = var.stands
  name             = "Windows user"
  resource_pool_id = data.vsphere_vapp_container.vApp[count.index].id
  datastore_id     = data.vsphere_datastore.Datastore.id
  shutdown_wait_timeout = 1
  num_cpus         = 1
  num_cores_per_socket = 2
  memory           = 3072
  guest_id         = data.vsphere_virtual_machine.Template-Win10.guest_id
  scsi_type = data.vsphere_virtual_machine.Template-Router.scsi_type


  network_interface {
  
    network_id = data.vsphere_network.PortGroup_Network[count.index].id
  }

  disk {
    label = "disk0"
    size  = 40
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Template-Win10.id
  }

}