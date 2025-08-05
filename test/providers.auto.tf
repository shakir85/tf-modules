provider "proxmox" {
  endpoint  = var.proxmox_end_point
  insecure  = true
  api_token = var.api_token
}

provider "random" {}
