provider "proxmox" {
  endpoint  = "https://10.10.50.20:8006"
  insecure  = true
  api_token = var.api_token
  username  = "terraform"
}

provider "random" {}
