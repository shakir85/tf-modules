terraform {
  required_version = ">= 1.5.7"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.54.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.5.1"
    }
  }
}

/* 
 * The following blocks are workaround for a limitation in Proxmox, in order to support
 * writing cloud images with a `.qcow2` extension. This locals block extracts
 * the file name from the URL. The subsequent resource appends `.img` to it.
 * The result will always be an image file name with the `.img` extension, for example,
 * `foo.qcow2.img`. If you download an actual `.img` file, it will be stored as `foo.img.img`.
 *  For more info, refer to the provider's docs:
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
