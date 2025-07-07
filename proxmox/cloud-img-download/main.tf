terraform {
  required_version = ">= 1.5.7"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.70.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
  }
}

locals {
  url_list = split("/", var.cloud_image_url)
  filename = element(local.url_list, length(local.url_list) - 1)
}

resource "proxmox_virtual_environment_download_file" "cloud_image_file" {
  content_type = "iso"
  datastore_id = var.storage_pool
  file_name    = "${local.filename}.img"
  node_name    = var.proxmox_node_name
  url          = var.cloud_image_url
}
