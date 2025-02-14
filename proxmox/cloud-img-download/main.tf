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

/*
 * The following `locals` block is a work around a Proxmox limitation related to writing
 * cloud images with the `.qcow2` extension. This `locals` block extracts
 * the file name from the provided URL, and the subsequent resource appends
 * `.img` to it.
 *
 * As a result, the final image file will always have the `.img` extension.
 * For example, a `.qcow2` file will be stored as `foo.qcow2.img`, while an
 * existing `.img` file will be renamed to `foo.img.img`.
 *
 * For more details, refer to the provider's documentation:
 *  https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_download_file#file_name
 */
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
