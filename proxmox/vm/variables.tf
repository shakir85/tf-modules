variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name. In a single-node environment, it's typically: `pve`"
}

variable "hostname" {
  type        = string
  description = "VM hostname."

  validation {
    condition     = can(regex("^([a-zA-Z0-9-]{1,63})$|^([a-zA-Z0-9-]{1,63}\\.[a-zA-Z0-9-]{1,63})*$", var.hostname))
    error_message = "hostname must be a valid DNS name"
  }
}

variable "description" {
  default     = "Managed by Terraform"
  type        = string
  description = "VM resource description."
}

variable "tags" {
  default     = ["terraform"]
  type        = list(string)
  description = "List of strings for tags. For example: ['terraform', 'ubuntu']."
}

variable "username" {
  type        = string
  description = "Default user. This will be a sudo user and have SSH login access."
}

variable "temp_user_password" {
  default     = "changeme"
  type        = string
  description = "Temorary login password. Upon the first login, a prompt to change the password will be presented."
}

variable "cores" {
  default     = 1
  type        = number
  description = "The number of CPU cores."
}

variable "sockets" {
  default     = 1
  type        = number
  description = "The number of CPU sockets."
}

variable "memory" {
  default     = 512
  type        = number
  description = "The dedicated memory in megabytes"
}

variable "disk_name" {
  type        = string
  description = "Proxmox storage pool (disk name) where the VM's disk should be stored. The disk must support the Snippet storage type as it will be used for other resources."
}

variable "disk_size" {
  type        = string
  description = "Disk size in Gigabytes"

  validation {
    condition     = can(regex("^[0-9]+$", var.disk_size))
    error_message = "disk_size must be a valid positive number."
  }
}

variable "disk_interface" {
  default     = "scsi0"
  type        = string
  description = "Storage disk interface. Default value: `scsi0`."
}

variable "network_interface" {
  default     = "vmbr0"
  type        = string
  description = "Default node's network device bridge. Default value: `vmbr0`."
}

variable "cloud_image_info" {
  type        = list(string)
  description = <<EOF
  A list of strings as the following:
  index 0 for storage pool (disk) name where the cloud image iso, img, qcow... etc is stored.
  index 1 for cloud-image file name (it must end with `.img` extension)
  For example: `cloud_image_info: ["local-lvm", "debian-12-generic.qcow2.img"]`.
  EOF
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the local public key to be added to the default user's `.ssh/authorized_keys` file."
}

variable "timezone" {
  type        = string
  description = "Timezone to be configured via `timedatectl` in cloud-init template."
}

variable "cpu_type" {
  default     = "qemu64"
  type        = string
  description = "The emulated CPU type. Some VMs need certain types of CPUs. See available values in [the provider docs](https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#host)."
}

variable "firewall_is_enabled" {
  default     = false
  type        = bool
  description = "Whether this interface's firewall rules should be used"
}
