
variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name where the container will be deployed. In a single-node environment, it's typically: `pve`"
}

variable "hostname" {
  type        = string
  description = "LXC hostname."
}

variable "lxc_template_file" {
  type = string
  description = "Name of the LXC container template file. For example: ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}

variable "lxc_template_path" {
  type = string
  description = "Storage name where the LXC template is located. For example, `local` or `local-lvm`."
}

variable "password" {
  type        = string
  description = "Container login password."
}

variable "disk_name" {
  type        = string
  description = "Proxmox storage pool (disk name) where the VM's disk should be stored."
}

variable "disk_size" {
  type        = string
  description = "Disk size in Gigabytes"
}

variable "container_network_interface" {
  default = "eth0"
  type = string
  description = "LXC container network interface name. Default value: `eth0`."
}

variable "host_bridge_network" {
  default     = "vmbr0"
  type        = string
  description = "Default node's network device bridge. Default value: `vmbr0`."
}

variable "ip_address" {
  default = "dhcp"
  type = string
  description = "For setting static DHCP IP, add an IPv4 with CIDR notation. For example 10.20.30.40/24. Default value `dhcp`."
}

