
variable "vsphere_datacenter" {
  default = "BRAMPTON"
  
}

variable "vsphere_datastore" {
  default = "MGMT-LocalDisk1"
}

#variable "vsphere_resource_pool" {
#}

variable "vsphere_compute_cluster" {
  default = "BRM-MGMT-CL"
}

variable "vsphere_network" {
  default = "DPortGroup-MGMT-Management"
}

variable "vsphere_virtual_machine" {
  default = "Ubuntu_Cloud_init_Template"
}

variable "num_cpus" {
  default = "1"
  
}

variable "memory" {
  default = "1024"
}

variable "virtual_machine_name" {
  default = "terraform-test"
}
