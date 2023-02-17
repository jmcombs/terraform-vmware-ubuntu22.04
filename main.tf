terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">=2.3.1"
    }
  }
}

provider "vsphere" {
  user                 = var.vcenter_username
  password             = var.vcenter_password
  vsphere_server       = var.vcenter_server
  allow_unverified_ssl = var.vcenter_insecure_connection
}

locals {
  templatevars = {
    guest_hostname              = var.guest_hostname,
    guest_fqdn                  = var.guest_fqdn,
    ipv4_address                = var.ipv4_address,
    ipv4_cidr                   = var.ipv4_cidr,
    ipv4_netmask                = var.ipv4_netmask,
    ipv4_gateway                = var.ipv4_gateway,
    ipv4_dns_server_1           = var.ipv4_dns_server_list[0],
    ipv4_dns_server_2           = var.ipv4_dns_server_list[1],
    dns_search_domain_1         = var.dns_search_domain_list[0],
    guest_user_name             = var.guest_user_name,
    guest_user_hashed_password  = var.guest_user_hashed_password,
    guest_user_gecos            = var.guest_user_gecos,
    guest_user_ssh_key          = var.guest_user_ssh_key
  }
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vcenter_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vcenter_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vm_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "/${var.vcenter_datacenter}/vm/${var.vcenter_template_folder}/${var.vcenter_template_name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name              = var.vm_name
  folder            = var.vm_folder
  resource_pool_id  = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id      = data.vsphere_datastore.datastore.id
  num_cpus          = var.vm_cpu
  memory            = var.vm_ram
  guest_id          = data.vsphere_virtual_machine.template.guest_id
  scsi_type         = data.vsphere_virtual_machine.template.scsi_type
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label             = "disk0"
    size              = var.vm_disk_size == "" ? data.vsphere_virtual_machine.template.disks.0.size : var.vm_disk_size
    thin_provisioned  = var.vm_disk_thinprovisioned == "" ? data.vsphere_virtual_machine.template.disks.0.thin_provisioned : var.vm_disk_thinprovisioned
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }
  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("./templates/metadata.yaml", local.templatevars))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("./templates/userdata.yaml", local.templatevars))
    "guestinfo.userdata.encoding" = "base64"
  }
  lifecycle {
    ignore_changes = [
      annotation,
      clone[0].template_uuid,
      clone[0].customize[0].dns_server_list,
      clone[0].customize[0].network_interface[0]
    ]
  }
}
