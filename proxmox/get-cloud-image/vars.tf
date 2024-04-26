variable "cloud_image_url" {
  type        = string
  description = "URL for downloading the cloud image."
}

variable "download_file_content_type" {
  default     = "iso"
  type        = string
  description = <<EOF
  This field determines the category of the downloaded file from the Proxmox perspective. 
  When using the default value, the file will be stored in the 'iso' category on the specified storage pool.
  EOF
}

variable "disk_name" {
  type        = string
  description = "Proxmox storage pool (i.e. disk name) where the cloud image will be downloaded."
}

variable "proxmox_node_name" {
  type        = string
  description = "Proxmox node name. In a single-node environment, it's typically: `pve`."
}