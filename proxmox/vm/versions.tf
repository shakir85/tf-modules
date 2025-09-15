terraform {
  required_version = "~> 1.13.1"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.83.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}
