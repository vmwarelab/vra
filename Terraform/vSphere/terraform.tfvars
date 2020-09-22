# vRealize Automation

# vsphere_user   = "xxxxxr@corp.local"
# vsphere_password   = "xxxxxx"
# vsphere_server  = "x.x.x.x" 

# vSphere Variables
vsphere_datacenter = "BRAMPTON"
vsphere_datastore = "MGMT-LocalDisk1"
vsphere_resource_pool = "terraform-rp"
vsphere_compute_cluster = "BRM-MGMT-CL"
vsphere_network = "DPortGroup-MGMT-Management"
vsphere_virtual_machine = "Ubuntu_Cloud_init_Template"

# vSphere machine
num_cpus = "1"
memory = "1024"
virtual_machine_name = "terraform-test"
