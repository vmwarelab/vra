provider "vsphere" {
  #user           = var.vsphere_user
  #password       = var.vsphere_password
  #vsphere_server = var.vsphere_server

variable "size" {
  description = "VM Size"
  default     = "small"
 }
  
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "BRAMPTON"
}

data "vsphere_datastore" "datastore" {
  name          = "MGMT-LocalDisk1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "pre-prod-staging"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DPortGroup-MGMT-Management"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 1024
  guest_id = "Ubuntu_Cloud_init_Template"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
