
# -- Meta variables ----------
variable "description" {
  default     = "Manage by Terraform"
  type        = string
  description = "Container description"
}

variable "node_name" {
  type        = string
  description = "The name of the node to assign the container to"
}

variable "hostname" {
  type        = string
  description = "Hostname to assign to the container"
}

variable "template_file_id" {
  type        = string
  description = "The identifier for an OS template file. The ID format is <datastore_id>:<content_type>/<file_name>, for example local:iso/jammy-server-cloudimg-amd64.tar.gz."
}

variable "os_type" {
  default     = "unmanaged"
  type        = string
  description = "OS type: Alpine, Ubunt ...etc"
}

variable "temp_password" {
  default     = "changeme"
  type        = string
  description = "Temporary login password"
}

variable "tags" {
  default     = ["lxc"]
  type        = list(string)
  description = "A list of the container tags"
}

# variable "unprivileged" {
#   default     = true
#   type        = bool
#   description = "Whether the container runs as unprivileged on the host"
# }

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the local public key to be added to the default user's `.ssh/authorized_keys` file."
}

## -- Network variables ----------
variable "ipv4_config" {
  default     = "dhcp"
  type        = string
  description = "The IP configuration, Value should be either `dhcp` or a static IPv4, e.g., `192.168.1.19/24`. (default to dhcp)"
}

variable "nic_name" {
  default     = "eth0"
  type        = string
  description = "Name of the container's network interface. It will be mapped to the `nic_bridge`"
}

# variable "nic_bridge" {
#   default     = "vmbr0"
#   type        = string
#   description = "The name of the network bridge on the Proxmox host"
# }

variable "firewall" {
  default     = false
  type        = bool
  description = "Whether this interface's firewall rules should be used"
}

## Storage variables ----------
variable "disk_id" {
  type        = string
  description = "Storage disk identifier (name)"
}

variable "disk_size" {
  default     = "4"
  type        = string
  description = "The size of the root filesystem in gigabytes (defaults to 4). When set to 0 a directory or zfs/btrfs subvolume will be created. Requires datastore_id to be set."
}

## Memory variables ----------
# variable "memory" {
#   default     = 1024
#   type        = number
#   description = "The dedicated memory in megabytes"
# }
#
# variable "swap" {
#   default     = 512
#   type        = number
#   description = "Sets Swap memory size"
# }

## Compute variables ----------
# variable "cpu_cores" {
#   default     = 1
#   type        = number
#   description = "The number of CPU cores"
# }
