variable "cloud_image_url" {
  type        = string
  description = "URL for downloading the cloud image."
}

variable "disk_name" {
  type        = string
  description = "Proxmox storage pool (i.e. disk name) where the cloud image will be downloaded."
}

variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name. In a single-node environment, it's typically: `pve`."
}