#===========================#
# VMware vCenter Connection #
#===========================#

variable "vcenter_username" {
  type        = string
  description = "VMware vCenter user name"
  sensitive   = true
}

variable "vcenter_password" {
  type        = string
  description = "VMware vCenter password"
  sensitive   = true
}

variable "vcenter_server" {
  type        = string
  description = "VMWare vCenter server FQDN / IP"
  sensitive   = true
}

variable "vcenter_insecure_connection" {
  type    = bool
  description = "If true, does not validate the vCenter server's TLS certificate."
  default = true
}

#================================#
# VMware vCenter Objects #
#================================#

variable "vcenter_datacenter" {
  type        = string
  description = "VMWare vCenter Datacenter"
}

variable "vcenter_cluster" {
  type        = string
  description = "VMWare vCenter Cluster"
  default     = ""
}

variable "vcenter_template_folder" {
  type        = string
  description = "VMware vCenter Template Folder"
  default     = "Templates"
}

variable "vcenter_template_name" {
  type        = string
  description = "VMware vCenter Template to clone for VM creation"
}

#================================#
# VMware vCenter Virtual Machine Objects #
#================================#

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine"
}

variable "vm_folder" {
  type        = string
  description = "The location of the Virtual Machine"
  default     = ""
}

variable "vm_cpu" {
  type        = number
  description = "Number of vCPUs for the Virtual Machine"
  default     = 2
}

variable "vm_ram" {
  type        = number
  description = "Amount of vRAM for the Virtual Machine (in MB)"
}

variable "vm_disk_size" {
  type        = number
  description = "Disk size for the Virtual Machine (in GB)"
}

variable "vm_disk_thinprovisioned" {
  type        = bool
  description = "If true, the disk is thin provisioned, with space for the file being allocated on an as-needed basis."
}

variable "vm_datastore" {
  type        = string
  description = "Virtual Machine Datastore location"
}

variable "vm_network" {
  type        = string
  description = "Virtual Machine Network"
}

#variable "vm-guest-id" {
#  type        = string
#  description = "The ID of virtual machines operating system"
#}

#================================#
# Guest OS #
#================================#

variable "guest_hostname" {
  type        = string
  description = "Guest Hostname"
  default     = ""
}

variable "guest_fqdn" {
  type        = string
  description = "Guest Fully Qualified Domain Name"
  default     = ""
}

variable "ipv4_address" {
  type        = string
  description = "ipv4 addresses for a vm"
}

variable "ipv4_cidr" {
  type        = string
  description = "ipv4 subnet mask in cidr format (ex /24)"
}

variable "ipv4_netmask" {
  type        = string
  description = "ipv4 subnet mask (ex 255.255.255.0)"
}

variable "ipv4_gateway" {
  type        = string
  description = "ipv4 default gateway"
}

variable "ipv4_dns_server_list" {
  type        = list(string)
  description = "List of ipv4 DNS servers in array format"
}

variable "dns_search_domain_list" {
  type        = list(string)
  description = "List of DNS search domains in array format"
}

variable "guest_user_name" {
  type      = string
  sensitive = true
  description = "Local user"
}
variable "guest_user_hashed_password" {
  type      = string
  sensitive = true
  description = "Local user password in hashed form"
}

variable "guest_user_gecos" {
  type        = string
  sensitive   = true
  description = "Local user's descriptive name"
}

variable "guest_user_ssh_key" {
  type        = string
  description = "Public SSH key for local user"
}